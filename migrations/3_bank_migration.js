var loanContract = artifacts.require("LoanDisbursement");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(loanContract);
};