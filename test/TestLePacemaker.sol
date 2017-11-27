pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Pacemaker.sol";

contract TestLePacemaker {

  function testGetBalance() {
    Pacemaker pmker = Pacemaker(DeployedAddresses.Pacemaker());

    uint expected = 0;

    Assert.equal(pmker.getBalance(), expected, "Contract should have empty balance");
  }

}
