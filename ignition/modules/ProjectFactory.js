const hre = require("hardhat");

async function main() {
    const ProjectFactory = await hre.ethers.getContractFactory("ProjectFactory");
    const project = await ProjectFactory.deploy();

    await project.waitForDeployment();

    console.log("ProjectFactory deployed to:", await project.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
