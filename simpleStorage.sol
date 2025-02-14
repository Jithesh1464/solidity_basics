// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract demo{
    struct student{ 
    uint  roll;
    uint score;
    string name;
}
   student[] public st_record;
   mapping (uint => string) public roll_to_name;
   function adddetail(uint _roll,uint _score,string memory _name) public{
    st_record.push(student(_roll,_score,_name));
    roll_to_name[_roll]=_name;
   }
   function find_len() public view returns (uint){
        return st_record.length;
   }
}
