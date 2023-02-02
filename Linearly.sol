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
    
    
function getTokenPrice() public view returns (uint256) {
        uint256 tokenPrice = (slope * tokenNumber * 10**18) + baseFee;
        return tokenPrice;
    }


 function buyToken() public payable {
        require(
            msg.value >= getTokenPrice(),
            "Insufficient Funds for purchasing token"
        );
        _mint(msg.sender, 1);
        tokenNumber++;
    }



    function sellToken() public payable {
        require(balanceOf(msg.sender) > 0, "You do not have tokens to sell");
        tokenNumber--;
        uint256 tokenPrice = getTokenPrice();
        _spendAllowance(msg.sender, address(this), 1);
        _burn(msg.sender, 1);
        (bool sent, bytes memory data) = payable(msg.sender).call{
            value: tokenPrice
        }("");
        require(sent, "Failed to send Funds");
    }
