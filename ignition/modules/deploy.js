const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();

    console.log("Deploying contract with account:", deployer.address);  

    const USDC = await hre.ethers.getContractFactory("TestUSDC");
    const usdc = await USDC.deploy();
    await usdc.waitForDeployment();
    console.log("Test USDC deployed to:",await usdc.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});