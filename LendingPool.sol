// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract LendingPool is ReentrancyGuard {
    IERC20 public usdtToken;
    IERC721 public billNFT;
    
    mapping(uint256 => uint256) public loans; // TokenID => Số tiền nợ

    constructor(address _token, address _nft) {
        usdtToken = IERC20(_token);
        billNFT = IERC721(_nft);
    }

    // Nhà đầu tư nạp tiền
    function deposit(uint256 amount) external {
        usdtToken.transferFrom(msg.sender, address(this), amount);
    }

    // SME vay tiền (Thế chấp NFT)
    function borrow(uint256 tokenId, uint256 invoiceAmount) external nonReentrant {
        // 1. Chuyển NFT vào contract
        billNFT.transferFrom(msg.sender, address(this), tokenId);
        
        // 2. Tính số tiền được vay (70% giá trị)
        uint256 borrowAmount = (invoiceAmount * 70) / 100;
        
        // 3. Chuyển tiền cho SME
        usdtToken.transfer(msg.sender, borrowAmount);
        
        // 4. Ghi nợ
        loans[tokenId] = borrowAmount;
    }
}
