const HDWalletProvider = require("@truffle/hdwallet-provider");

module.exports = {
  networks: {
    // Configuración para la testnet de Binance Smart Chain
    bsctestnet: {
      provider: () =>
        new HDWalletProvider({
          privateKeys: ["cdedd9c5efd690acea8fa6eb0b906163de120822ec526a0c04c123336633a222"],
          providerOrUrl: "https://data-seed-prebsc-1-s1.binance.org:8545/",
        }),
      network_id: 97,
      confirmations: 10,
      timeoutBlocks: 200,
      skipDryRun: true,
    },
    
  },

  compilers: {
    solc: {
      version: "^0.8.0",
    },
  },

  api_keys: {
    bscscan: "33ZMYDH737D32XU631DJWCY5UBQTZMJQIW",
  },

  db: {
    enabled: false,
  },
};
