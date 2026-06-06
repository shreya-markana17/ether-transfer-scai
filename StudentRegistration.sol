// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentRegistration {
    
    struct Student {
        uint id;
        string name;
        uint age;
        bool isRegistered;
    }
    
    address public owner;
    uint public studentCount;
    
    mapping(uint => Student) public students;
    
    event StudentRegistered(uint id, string name, uint age);
    
    constructor() {
        owner = msg.sender;
        studentCount = 0;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    
    function registerStudent(string memory _name, uint _age) public onlyOwner {
        studentCount++;
        students[studentCount] = Student(studentCount, _name, _age, true);
        emit StudentRegistered(studentCount, _name, _age);
    }
    
    function getStudent(uint _id) public view returns (string memory, uint, bool) {
        Student memory s = students[_id];
        return (s.name, s.age, s.isRegistered);
    }
}
