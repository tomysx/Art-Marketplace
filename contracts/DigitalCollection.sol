// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

//Creacion de tokens ERC-1155
contract DigitalCollection is ERC1155, Ownable {
    using SafeMath for uint256;

    uint256 private _currentTokenId = 0;
    mapping(uint256 => string) private _tokenURIs;
    mapping(uint256 => address) private _tokenSellers;

    constructor(string memory baseURI) ERC1155(baseURI) {}

    function create(uint256 amount, string memory newTokenURI) public onlyOwner {
        uint256 newTokenId = _currentTokenId;
        _mint(msg.sender, newTokenId, amount, "");
        _tokenURIs[newTokenId] = newTokenURI;
        _currentTokenId = newTokenId.add(1);
    }

    function setTokenSeller(uint256 tokenId, address seller) public {
        require(msg.sender == owner() || balanceOf(msg.sender, tokenId) > 0, "Only owner or token holder can set seller");
        _tokenSellers[tokenId] = seller;
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        return _tokenURIs[tokenId];
    }

    function getSeller(uint256 tokenId) public view returns (address) {
        return _tokenSellers[tokenId];
    }
}
