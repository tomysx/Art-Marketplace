const ArtCoin = artifacts.require("ArtCoin");
const DigitalPieces = artifacts.require("DigitalPieces");
const DigitalCollection = artifacts.require("DigitalCollection");
const ArtMarketplace = artifacts.require("ArtMarketplace");

module.exports = function (deployer) {
  deployer.deploy(ArtCoin, 1000000).then(function () {
    return deployer.deploy(DigitalPieces);
  }).then(function () {
    return deployer.deploy(DigitalCollection, "https://ipfs.io/ipfs/");
  }).then(function () {
    return deployer.deploy(ArtMarketplace, ArtCoin.address, DigitalPieces.address, DigitalCollection.address, 5);
  });
};
