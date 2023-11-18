import hre, { ethers } from "hardhat";

function delay(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function main() {

  // const exampleOwnerContract = await ethers.deployContract("ExampleOwnerContract", []);
  // await exampleOwnerContract.waitForDeployment();
  // console.log("owner contract deployed to", await exampleOwnerContract.getAddress());

  const constructorArgs = ["0x712b3d230F3C1c19db860d80619288b1F0BDd0Bd"]; //curvedao token
  // 0xfdaFc9d1902f4e0b84f65F49f244b32b31013b74 composable cow address 


  //MethodID: 0x095ea7b3000000000000000000000000
  // 9008D19f58AAbD9eD0D60971565AA8510560ab41
  // 00000000000000000000000000000000000000000000000098a7d9b8314c0000
  // 0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83 usdc
  const payrollHandler = await ethers.deployContract("PayrollHandler", constructorArgs);
  // [["100000000000000000", "0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83",0, 100, 1700310345 ]]

  await payrollHandler.waitForDeployment();

  console.log("payroll deployed to:", await payrollHandler.getAddress());

  // await delay(30000); // Wait for 30 seconds before verifying the contract

  // await hre.run("verify:verify", {
  //   address: payrollHandler.getAddress(),
  //   constructorArguments: constructorArgs,
  // });

  // await hre.run("verify:verify", {
  //   address:exampleOwnerContract.getAddress(),
  //   constructorArguments: [],
  // });
  // Uncomment if you want to enable the `tenderly` extension
  // await hre.tenderly.verify({
  //   name: "Greeter",
  //   address: contractAddress,
  // });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
