const hre = require("hardhat");

async function main() {
    // const project = await ethers.getContractAt("ProjectFactory", "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512");

    // Register a freelancer
    // const newProject = await project.createProject("123456","0xdF3e18d64BC6A983f673Ab319CCaE4f1a57C7097");
    // const address = await project.getProject("123456");

  // Print values
  // console.log("Project Details -> ",address);
  const projectes = await ethers.getContractAt("ProjectEscrow", "0x7F9E9764C20Ebf3E9b6CAA53895E05cB0b74eB09");
  const balance = await projectes.getBalance();
  // const tx = await projectes.releasePayment();
  // tx.wait();
  console.log("Balance: "+ethers.formatEther(balance)+" ETH"); 
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});