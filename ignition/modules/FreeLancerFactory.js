const hre = require("hardhat");

async function main() {
    const FreelancerFactory = await hre.ethers.getContractFactory("FreelancerFactory");
    const freelancerFactory = await FreelancerFactory.deploy();

    await freelancerFactory.waitForDeployment();

    console.log("FreelancerFactory deployed to:", await freelancerFactory.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
