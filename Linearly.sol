pragma solidity 0.8.7;
 //SPDX-Licence-Identifier: Unlicence
 import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

 contract Linearly is ERC20Burnable {
    uint256 public slope;
    uint256 public baseFee;
    uint256 public tokenNumber;
    address public owner;

    constructor(uint256 _slope, uint256 _baseFee)
        ERC20Burnable()
        ERC20("Linearly", "LNRLY")
    {
        owner = msg.sender;
        tokenNumber = 0;
        slope = _slope;
        baseFee = _baseFee;
    }
    
    
