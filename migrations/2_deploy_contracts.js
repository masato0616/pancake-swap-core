const PancakeFactory = artifacts.require("PancakeFactory");

module.exports = function (deployer) {
  deployer.deploy(PancakeFactory, '0x010Ba66bA910e669A2A38fd9cBd82f78e5ef4418');
};
