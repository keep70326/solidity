pragma solidity ^0.4.24;

contract class{
    struct Student {
        string Name;
        uint Score;
        bool Active;
    }
    mapping (uint => Student) student;

    modifier notStudent(uint id){
        require(student[id].Active, '尚未登入此學生成績or本班級無此座號');
        _;
    }

    function register(uint id, string name) public {
        student[id] = Student({Name:name, Score:0, Active:true});
    } 

    function keyScore(uint id, uint Score) public notStudent(id){
        student[id].Score = Score;
    }

    function searchScore(uint id)public notStudent(id) view returns(string Name, uint Score) {
        return (student[id].Name, student[id].Score);
    }
}