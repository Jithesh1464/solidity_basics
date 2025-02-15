// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


contract fundme{
    address public immutable owner;
    mapping(address=>uint256) public AddressToAmountFunded;
    address [] public funders;
    constructor() {
        owner=msg.sender;
    }
    function donate() public payable {
        uint amnt=50;
        require(msg.value >= amnt,"no sufficent amount it should be atleast 50 dollars");
        AddressToAmountFunded[msg.sender]+=msg.value;
        funders.push(msg.sender);
    }

    function getversion() public view returns(uint256){
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }
    function getprice() public view returns(uint256){
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306); 
        (, int256 answer,,,)= priceFeed.latestRoundData();
        return uint256(answer);
    }

    modifier onlyowner{
        require(msg.sender==owner,"only the owner can withdraw");
        _;
    }
    function withdraw() payable onlyowner public{
        
        payable(msg.sender).transfer(address(this).balance);
        for(uint index=0;index<funders.length;index++){
            AddressToAmountFunded[funders[index]]=0;
        }
        funders=new address[](0);
    }
}
