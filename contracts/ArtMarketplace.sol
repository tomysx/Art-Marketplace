// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./DigitalPieces.sol";
import "./DigitalCollection.sol";
import "./ArtCoin.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ArtMarketplace is ERC721URIStorage {
    using SafeMath for uint256;

    DigitalPieces private _digitalPieces;
    DigitalCollection private _digitalCollection;
    ArtCoin private _artCoin;

    address private _owner;
    uint256 private _commissionPercentage;

    mapping(uint256 => uint256) private _erc721Prices;
    mapping(uint256 => bool) private _erc721Listed;
    mapping(uint256 => uint256) private _erc1155Prices;
    mapping(uint256 => bool) private _erc1155Listed;
    mapping(uint256 => string) private _tokenURIs;

    event ERC721Listed(uint256 tokenId, uint256 price);
    event ERC1155Listed(uint256 tokenId, uint256 price);
    event ERC721Purchased(uint256 tokenId, address buyer);
    event ERC1155Purchased(uint256 tokenId, address buyer, uint256 amount);

    constructor(
        address digitalPiecesAddress,
        address digitalCollectionAddress,
        address artCoinAddress,
        uint256 commissionPercentage,
        address contractOwner
    ) ERC721("ArtMarketplace", "ARTM") {
        _digitalPieces = DigitalPieces(digitalPiecesAddress);
        _digitalCollection = DigitalCollection(digitalCollectionAddress);
        _artCoin = ArtCoin(artCoinAddress);
        _commissionPercentage = commissionPercentage;
        _owner = contractOwner;
    }

    modifier onlyOwner() {
        require(msg.sender == _owner, "Only the owner can call this function");
        _;
    }

    function listERC721(uint256 tokenId, uint256 price, string memory uri) public onlyOwner {
        require(_digitalPieces.ownerOf(tokenId) == msg.sender, "Not the owner");
        _digitalPieces.transferFrom(msg.sender, address(this), tokenId);
        _erc721Prices[tokenId] = price;
        _erc721Listed[tokenId] = true;
        _setTokenURI(tokenId, uri);
        emit ERC721Listed(tokenId, price);
    }

    function listERC1155(uint256 tokenId, uint256 price) public onlyOwner {
        require(_digitalCollection.balanceOf(msg.sender, tokenId) > 0, "Not the owner");
        _digitalCollection.setTokenSeller(tokenId, msg.sender);
        _digitalCollection.safeTransferFrom(msg.sender, address(this), tokenId, 1, "");
        _erc1155Prices[tokenId] = price;
        _erc1155Listed[tokenId] = true;
        emit ERC1155Listed(tokenId, price);
    }

    function buyERC721(uint256 tokenId) public {
        require(_erc721Listed[tokenId], "Token not listed");
        uint256 price = _erc721Prices[tokenId];
        uint256 commission = price.mul(_commissionPercentage).div(100);
        uint256 sellerShare = price.sub(commission);

        address seller = _digitalPieces.ownerOf(tokenId);

        // Cambio el destinatario de la comisión al contrato del Marketplace
        _artCoin.transferFrom(msg.sender, address(this), commission);

        // Cambio el destinatario del importe del vendedor al vendedor
        _artCoin.transferFrom(msg.sender, seller, sellerShare);

        _digitalPieces.transferFrom(seller, msg.sender, tokenId);
        _erc721Listed[tokenId] = false;

        emit ERC721Purchased(tokenId, msg.sender);
    }

    function buyERC1155(uint256 tokenId, uint256 amount) public {
        require(_erc1155Listed[tokenId], "Token not listed");
       

        address seller = _digitalCollection.getSeller(tokenId);
        require(_digitalCollection.balanceOf(seller, tokenId) >= amount, "Seller does not have enough tokens");
        uint256 price = _erc1155Prices[tokenId].mul(amount);
        uint256 commission = price.mul(_commissionPercentage).div(100);
        uint256 sellerShare = price.sub(commission);

        _artCoin.transferFrom(msg.sender, address(this), commission);
        _artCoin.transferFrom(msg.sender, seller, sellerShare);

        _digitalCollection.safeTransferFrom(address(this), msg.sender, tokenId, amount, "");

        emit ERC1155Purchased(tokenId, msg.sender, amount);
    }

    function getERC721Price(uint256 tokenId) public view returns (uint256) {
        require(_erc721Listed[tokenId], "Token not listed");
        return _erc721Prices[tokenId];
    }

    function getERC1155Price(uint256 tokenId) public view returns (uint256) {
        require(_erc1155Listed[tokenId], "Token not listed");
        return _erc1155Prices[tokenId];
    }

    function isERC721Listed(uint256 tokenId) public view returns (bool) {
        return _erc721Listed[tokenId];
    }

    function isERC1155Listed(uint256 tokenId) public view returns (bool) {
        return _erc1155Listed[tokenId];
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory baseURI = _baseURI();

        // If there is no base URI, return the token URI.
        if (bytes(baseURI).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(baseURI, _tokenURI));
        }

        return super.tokenURI(tokenId);
    }


    //FASE ADICIONAL
        //Funcionalidades extra solo para administradores

    function setCommissionPercentage(uint256 commissionPercentage) public onlyOwner {
        require(commissionPercentage <= 100, "Commission percentage can't exceed 100");
        _commissionPercentage = commissionPercentage;
    }

    function withdrawCommission() public onlyOwner {
        uint256 balance = _artCoin.balanceOf(address(this));
        require(balance > 0, "No commission to withdraw");
        _artCoin.transfer(msg.sender, balance);
    }

    function updateTokenURI(uint256 tokenId, string memory newTokenURI) public onlyOwner {
        require(_exists(tokenId), "Token does not exist");
        _tokenURIs[tokenId] = newTokenURI;
    }

}
