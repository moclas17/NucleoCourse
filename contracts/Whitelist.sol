// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Whitelist {
    address public owner;

    mapping(address => bool) public whitelistedWallets;
    mapping(bytes32 => bool) public whitelistedEmails;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // =====================
    // WALLET MANAGEMENT
    // =====================

    function addWallet(address _wallet) external onlyOwner {
        whitelistedWallets[_wallet] = true;
    }

    function addWalletsBulk(address[] calldata _wallets) external onlyOwner {
        for (uint i = 0; i < _wallets.length; i++) {
            whitelistedWallets[_wallets[i]] = true;
        }
    }

    function isWalletWhitelisted(address _wallet) public view returns (bool) {
        return whitelistedWallets[_wallet];
    }

    // =====================
    // EMAIL MANAGEMENT (stored as hash)
    // =====================

    function addEmail(string calldata _email) external onlyOwner {
        bytes32 hashed = keccak256(abi.encodePacked(_email));
        whitelistedEmails[hashed] = true;
    }

    function addEmailsBulk(string[] calldata _emails) external onlyOwner {
        for (uint i = 0; i < _emails.length; i++) {
            bytes32 hashed = keccak256(abi.encodePacked(_emails[i]));
            whitelistedEmails[hashed] = true;
        }
    }

    function isEmailWhitelisted(string calldata _email) public view returns (bool) {
        bytes32 hashed = keccak256(abi.encodePacked(_email));
        return whitelistedEmails[hashed];
    }

    // =====================
    // COMBINED CHECK
    // =====================

    function isWhitelisted(address _wallet, string calldata _email) external view returns (bool) {
        return isWalletWhitelisted(_wallet) || isEmailWhitelisted(_email);
    }
}
