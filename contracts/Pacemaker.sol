pragma solidity ^0.4.4;


contract Pacemaker {

	address public owner;

	mapping (address => bool) public authorities;
	
	// nombre de blocks apres lesquels les autorites peuvent prendre la main sur le smart contract
	uint256 public blockTime;

	// dernier "signe de vie" de l'owner
	uint256 public lastBlockTime; 


	event Deposit(address indexed _from, uint256 _value);
	event Withdrawal(address _sendTo, address _whoMadeIt);

	function Pacemaker(uint256 _blockTime) {
		owner = msg.sender;
		blockTime = _blockTime;
		lastBlockTime = block.number;
	}

	function addAuthority(address _auth) public onlyAdmin {
		authorities[_auth] = true;
	}

	function removeAuthority(address _auth) public onlyAdmin {
		authorities[_auth] = false;
	}

	modifier onlyAdmin() {
		require(msg.sender == owner);
		_;
	}

	modifier onlyAuthority() {
		require(authorities[msg.sender]);
		_;
	}

	modifier onlyWhenDied() {
		require(block.number > lastBlockTime + blockTime);
		_;
	}

	function deposit() public payable {
		Deposit(msg.sender, msg.value);
	}

	function pace() public onlyAdmin {
		lastBlockTime = block.number;
	}
	
	function setBlockTime(uint256 _nblocktime) public onlyAdmin {
		blockTime = _nblocktime;
	}

	function withdraw(address sendTo) public onlyAdmin {
		require(sendTo.send(this.balance));
		Withdrawal(sendTo, msg.sender);
	}

	function withdrawAuthority(address sendTo) public onlyAuthority onlyWhenDied {
        require(sendTo.send(this.balance));
        Withdrawal(sendTo, msg.sender);
	}
}
