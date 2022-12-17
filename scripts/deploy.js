
const hre = require("hardhat");

async function main() {

  const MyTokenContract = await hre.ethers.getContractFactory("MyToken");
  const deployContract   = await MyTokenContract.deploy();

  await deployContract.deployed();

  console.log("Contract Address", deployContract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
