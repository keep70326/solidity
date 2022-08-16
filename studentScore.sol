// SPDX-License-Identifier: MIT
pragma solidity ^0.7.1.0;

contract StudentScores{
    struct Class{
        string teacher;
        mapping (string => uint) scores;//學生名字＝>成績
    }

    mapping (string => Class) classes; //班級名稱

    function AddClass(string calldata className, string calldata teacher) public {
        Class storage class = classes[className];
        class.teacher = teacher;
    }

    function AddStudentScore (string calldata className, string calldata studentName, uint score) public {
        Class storage class = classes[className];
        class.scores[studentName] = score; 
    }

    function getStudentScore(string calldata className, string calldata studentName) public view returns(uint) {
        Class storage class = classes[className];
        return (class.scores[studentName]);
    }
}