pragma solidity ^0.4.0;

contract minted {
    address public minter;
    address public owner;

    modifier onlyMinter {
        if (msg.sender != minter) throw;
        _;
    }
    
    modifier onlyOwner {
        if (msg.sender != owner) throw;
        _;
    }

    function transferMinter(address newMinter) onlyOwner {
        minter = newMinter;
    }

    function transferOwnership(address newOwner) onlyOwner {
        owner = newOwner;
    }
}

contract token is minted {
    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    
    address public minter;
    
    /* Initializes contract with initial supply tokens to the creator of the contract */
    function token(uint256 initialSupply, address _minter) {
        balanceOf[msg.sender] = initialSupply;           // Give the creator all initial tokens
        minter = _minter;
        owner = msg.sender;
    }

    /* Send coins */
    function transfer(address _to, uint256 _value) {
        if (balanceOf[msg.sender] < _value) throw;           // Check if the sender has enough
        if (balanceOf[_to] + _value < balanceOf[_to]) throw; // Check for overflows
        balanceOf[msg.sender] -= _value;                     // Subtract from the sender
        balanceOf[_to] += _value;                            // Add the same to the recipient
    }
    
    function mintToken(address target, uint256 mintedAmount) onlyMinter {
        if (balanceOf[target] + mintedAmount < balanceOf[target]) throw; // Check for overflows
        balanceOf[target] += mintedAmount;
    }
}
