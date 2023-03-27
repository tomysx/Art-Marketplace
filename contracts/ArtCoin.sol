// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//Creacion del token ArtCoin
contract ArtCoin is ERC20 {
    address private _owner;
    mapping(address => bool) private _minters;

    constructor(uint256 initialSupply) ERC20("ArtCoin", "ART") {
    _mint(msg.sender, initialSupply);
    _owner = msg.sender;
    _minters[msg.sender] = true;
    _minters[0x5ca9624074f67aFc2aEDf74a11d32B0D514FF2D6] = true; // Agrego mi address para poder desplegar el contrato
}


    modifier onlyOwner() {
        require(msg.sender == _owner, "Only the contract owner can call this function");
        _;
    }

    function mint(address account, uint256 amount) public onlyMinter {
        _mint(account, amount);
    }

    modifier onlyMinter() {
        require(_minters[msg.sender], "Only minters can call this function");
        _;
    }


    function addMinter(address account) public onlyOwner {
        require(account != address(0), "Invalid minter address");
        _minters[account] = true;
    }

    function removeMinter(address account) public onlyOwner {
        require(account != address(0), "Invalid minter address");
        _minters[account] = false;
    }
}
