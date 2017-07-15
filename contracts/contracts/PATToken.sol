pragma solidity ^0.4.4;

import "zeppelin/contracts/token/MintableToken.sol";

contract PATToken is MintableToken {
  string public constant name = "Pangea Arbitration Token";
  string public constant symbol = "PAT";
  uint public constant decimals = 18;
}
