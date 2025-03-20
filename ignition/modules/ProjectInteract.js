const hre = require("hardhat");

async function main() {
    const project = await ethers.getContractAt("ProjectFactory", "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512");

    // Register a freelancer
    const newProject = await project.createProject("123456","0xdF3e18d64BC6A983f673Ab319CCaE4f1a57C7097");
    const address = await project.getProject("123456");

  // Print values
  console.log("Project Details -> ",address);
  const projectes = await ethers.getContractAt("ProjectEscrow", address[0]);
  const balance = await projectes.getBalance();
  console.log("Balance: "+ethers.formatEther(balance)+" ETH"); 
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});