const hre = require("hardhat");

async function main() {
    const freelancer = await ethers.getContractAt("Freelancer", "0xa16E02E87b7454126E5E10d957A927A7F5B5d2be");

    // Register a freelancer
    const name = await freelancer.name();
  const skills = await freelancer.skills();
  const experience = await freelancer.experienceYears();
  const balance = await freelancer.getBalance();
  const owner = await freelancer.owner();

  // Print values
  console.log(`📌 Freelancer Name: ${name}`);
  console.log(`📌 Skills: ${skills}`);
  console.log(`📌 Experience: ${experience} years`);
  console.log(`📌 Contract Balance: ${ethers.formatEther(balance)} ETH`);
  console.log(`📌 Owner: ${owner}`);
    
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});