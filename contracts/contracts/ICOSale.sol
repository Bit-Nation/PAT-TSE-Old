pragma solidity ^0.4.4;

import "zeppelin/contracts/SafeMath.sol";
import "zeppelin/contracts/ownership/Ownable.sol";

import "./PATToken.sol";

// This ICO contract has been inspired by the EOS one
// https://github.com/EOSIO/eos-token-distribution/blob/master/src/eos_sale.sol

contract ICOSale is Ownable {
  using SafeMath for uint;

  PATToken public token;

  uint public endDate;
  uint public startingAt;

  // All ether received, by days
  mapping (uint => uint) public dailyTotal;

  // What each backer invested, by days
  mapping (uint => mapping (address => uint)) public userInvests;

  // Does the backer got its tokens?
  mapping (uint => mapping (address => bool)) public userClaimed;

  event Claimed(uint day, address backer, uint nbTokens);
  event CollectedUnsold(address collecter, uint unsoldTokens);
  event CollectedEth(address collecter, uint ethAmount);

  function ICOSale(uint _nbDays, uint _startAt, address _tokenAddress) {
    endDate = (now * 1 days) + _nbDays;
    startingAt = _startAt;

    token = PATToken(_tokenAddress);
  }

  function () payable {
    var currentDay = now * 1 days;

    // Check if campaign started
    if (currentDay < startingAt) throw;

    // Check if campaign is other
    if (currentDay >= endDate) throw;

    // Now, just save that for future claims
    dailyTotal[currentDay] = dailyTotal[currentDay].add(msg.value);
    userInvests[currentDay][msg.sender] = msg.value;
  }

  // Allow backers to get their tokens
  function claimByDay(uint day) {
    var currentDay = now * 1 days;

    // Someone is claiming to early!
    if (day > currentDay) throw;

    // No need to continue if the total invested of the day is 0
    if (dailyTotal[day] == 0) throw;

    // Does the sender already claimed its tokens?
    if (userClaimed[day][msg.sender]) throw;

    var totalInvested = dailyTotal[day];
    var senderInvested = userInvests[day][msg.sender];

    var price = tokensByDay(day).div(totalInvested);

    var nbTokens = price.mul(senderInvested);

    userClaimed[day][msg.sender] = true;

    // Reward backer
    // No need to mint, the contract will own its PAT
    token.transfer(msg.sender, nbTokens);

    // Log that
    Claimed(day, msg.sender, nbTokens);
  }

  // Convenient function to claim all the different days
  function claimAll() {
    var currentDay = now * 1 days;

    // No need to loop if it is too early
    if (currentDay < startingAt) throw;

    for (uint day = startingAt; day < currentDay; day++) {
      claimByDay(day);
    }
  }

  // Return the amount of tokens available 
  function tokensByDay(uint day) returns (uint) {
    var nbDays = day.sub(startingAt);

    if (nbDays < 0 || day > endDate) return 0;

    // Total supply is 4.2e9

    // We sell 20% the first two days, it means 10% a day (420e6 tokens)
    if (nbDays <= 2) return 420e6;
    
    // First month: 1/30 a day (140e6 tokens)
    if (nbDays <= 30) return 140e6;

    // Next 24 months: 1% a day (42e6)
    if (nbDays <= 720) return 42e6;
  }

  // Allow the owner to get unsold tokens
  function collectUnsold() onlyOwner {
    // Is campaign over?
    if (now * 1 days <= endDate) throw;

    // Send unsold tokens
    var balance = token.balanceOf(address(this));
    token.transfer(owner, balance);

    CollectedUnsold(owner, balance);
  }

  // allow owner to get its ETH, at any time
  function collectEth() onlyOwner {
    if (!owner.send(this.balance)) throw;
    CollectedEth(owner, this.balance);
  }
}
