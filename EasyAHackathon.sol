// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract SimpleSalaryPayment {
    address public owner;
    IERC20 public token;

    // Event to log salary payments for transparency and traceability
    event SalaryPaid(address indexed from, address indexed to, uint256 amount);

    // Set the contract deployer as the owner and the ERC20 token address
    constructor(address _tokenAddress) {   
        owner = msg.sender;
        token = IERC20(_tokenAddress);
    }

    // Ensure only the owner can execute this function
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }

    // Pay salary to a single employee
    // This function now assumes that the owner (sender) is always the contract owner
    function paySalary(address recipient, uint256 amount) external onlyOwner {
        require(token.transferFrom(owner, recipient, amount), "Failed to transfer salary.");
        emit SalaryPaid(owner, recipient, amount);  // Emitting event for tracking
    }
}
