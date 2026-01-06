// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockUSDT is ERC20 {
    constructor() ERC20("Mock USDT", "mUSDT") {
        _mint(msg.sender, 1000000 * 10**18); // In ra 1 triệu đô
    }
    
    function faucet() external {
        _mint(msg.sender, 1000 * 10**18); // Ai gọi hàm này được tặng 1000 đô
    }
}
