// var ConvertLib = artifacts.require("./ConvertLib.sol");
var Pacemaker = artifacts.require("./Pacemaker.sol");

module.exports = function(deployer) {
  // deployer.deploy(ConvertLib);
  // deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(Pacemaker);
};
