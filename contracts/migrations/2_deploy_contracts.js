var sale = artifacts.require("./ICOSale.sol");
var token = artifacts.require("./PATToken.sol");

// fill it correctly
var nbDays = 20;
var startAt = 30;

module.exports = function(deployer) {
  deployer.deploy(token).then(function() {
    return deployer.deploy(sale, nbDays, startAt, token.address);
  });
};
