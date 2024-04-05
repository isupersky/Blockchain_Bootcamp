//SPDX-License-Identifier:MIT
pragma solidity 0.8.19;

contract RegisterAccess{

    string[] private info;
    address public owner;
    mapping (address => bool) public allowlist;

    constructor(){
        owner = msg.sender;
        allowlist[msg.sender] = true;
    }

    event InfoChange(string oldInfo, string newInfo);

    modifier onlyOwner {
        require(msg.sender == owner,"Ony owner");
         _;
    }

    modifier onlyAllowList {
        require(allowlist[msg.sender] == true,"Only allowList");
        _;
    }

    function getInfo(uint index) public view returns (string memory){
        return info[index];
    }

    function setInfo(uint index, string memory _info) public onlyAllowList{
        emit InfoChange(info[index], _info);
        info[index]= _info;
    }

    function addInfo(string memory _info) public onlyAllowList returns (uint index){
        info.push (_info);
        index = info.length -1;
    }
    function listInfo() public view returns(string[] memory){
        return info;
    }
    function addMember(address _member) public onlyOwner{
        allowlist[_member] =true;
    }

    function deleteMember(address _member) public onlyOwner {
        allowlist[_member] =false;
    }
}