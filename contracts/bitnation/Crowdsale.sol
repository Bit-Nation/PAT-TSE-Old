pragma solidity ^0.4.4;


import "../zeppelin/token/StandardToken.sol";
import "../zeppelin/ownership/Ownable.sol";


/*
 * Crowdsale Token
 */
contract Crowdsale is StandardToken, Ownable {
  string public constant name = "BITNATION ICO";
  string public constant symbol = "?";
  uint public constant decimals = 18;
  // replace with your fund collection multisig address 
  address public constant multisig = 0x0;
  
  mapping(address => bool) public isReferrer;

  // 1 ether = 500 tokens 
  uint public constant PRICE = 500;
  // referrers get 1/10
  uint public constant REF_SHARE = 10;

  function addReferrer(address referrer) onlyOwner {
    isReferrer[referrer] = true;
  }
  
  function delReferrer(address referrer) onlyOwner {
    isReferrer[referrer] = false;
  }

  function () payable {
    createTokens(msg.sender);
  }
  
  function referrer(address referrer) payable {
    createTokensReferrer(msg.sender, referrer);
  }
  
  function createTokens(address recipient) payable {
    if (msg.value == 0) {
      throw;
    }

    uint tokens = msg.value.mul(PRICE);
    totalSupply = totalSupply.add(tokens);

    balances[recipient] = balances[recipient].add(tokens);

    if (!multisig.send(msg.value)) {
      throw;
    }
  }
  
  function createTokensReferrer(address recipient, address referrer) payable {
    if (recipient == referrer || !isReferrer[referrer] || msg.value == 0) {
      throw;
    }
    
    uint tokens = msg.value.mul(PRICE);
    uint tokens_ref = tokens.div(REF_SHARE);
    
    totalSupply = totalSupply.add(tokens);
    totalSupply = totalSupply.add(tokens_ref);

    balances[recipient] = balances[recipient].add(tokens);
    balances[referrer] = balances[referrer].add(tokens_ref);

    if (!multisig.send(msg.value)) {
      throw;
    }
  }
}
