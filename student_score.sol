// SPDX-License-Identifier: MIT
pragma solidity ^0.7.1.0;

contract StudentScores{
    mapping(string => uint) private scores;
    string[] private names;

    function addScore(string memory name, uint score) public {
        scores[name] = score;
        names.push(name);
    }

    function getScore(string memory name) public view returns(uint) {
        return (scores[name]);
    }

    function clearAllScore() public {
        while (names.length > 0) {
            delete scores[names[names.length-1]];
            names.pop();
        }
    }
}