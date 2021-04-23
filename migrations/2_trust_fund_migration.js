var trustFundContract = artifacts.require("Trust");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(trustFundContract);
};