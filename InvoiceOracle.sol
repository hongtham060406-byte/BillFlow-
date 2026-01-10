// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title InvoiceOracle (Mock)
 * @dev Hackathon-level oracle for invoice verification
 */
contract InvoiceOracle {
    address public verifier;

    mapping(bytes32 => bool) private verifiedInvoices;

    constructor(address _verifier) {
        verifier = _verifier;
    }

    modifier onlyVerifier() {
        require(msg.sender == verifier, "Not authorized");
        _;
    }

    function verifyInvoice(bytes32 invoiceHash) external onlyVerifier {
        verifiedInvoices[invoiceHash] = true;
    }

    function isVerified(bytes32 invoiceHash) external view returns (bool) {
        return verifiedInvoices[invoiceHash];
    }
}
