async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  const institutionName = "Your Institution Name";
  const IdentityManager = await ethers.getContractFactory("IdentityManager");
  const identityManager = await IdentityManager.deploy(institutionName);

  console.log("IdentityManager deployed to:", identityManager.address);

  // Save contract address to the frontend
  const fs = require("fs");
  const contractsDir = __dirname + "/../../frontend/src/abi";

  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    contractsDir + "/contract-address.json",
    JSON.stringify({ IdentityManager: identityManager.address }, undefined, 2)
  );

  const IdentityManagerArtifact = await artifacts.readArtifact("IdentityManager");

  fs.writeFileSync(
    contractsDir + "/IdentityManager.json",
    JSON.stringify(IdentityManagerArtifact, null, 2)
  );
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
