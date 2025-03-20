const hre = require("hardhat");

async function main() {
    const FreelancerFactory = await ethers.getContractAt("FreelancerFactory", "0x5FC8d32690cc91D4c39d9d3abcBD16989F875707");

    // Register a freelancer
    await FreelancerFactory.registerFreelancer("Ramesh", "Solidity, React", 11);
    const freelancers = await FreelancerFactory.getAllFreelancers();
    console.log("All Freelancers are 0->"+freelancers[0]+" 1 -> "+freelancers[1]);
    
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});