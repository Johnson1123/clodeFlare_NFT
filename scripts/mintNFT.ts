import { ethers } from "hardhat"

async function main() {
  const token_address = "0x1Ed5d41A42c18F2437B94436FE969e7c453ce29D"
  const CodingFlareContract = await ethers.getContractAt("ICodingFlare", token_address);

//   =============== mint token ==============
  
  await CodingFlareContract.mintCollectionNFT();
  console.log("Token minted successfully");
//   =============== token minted ==============
}

main()
  .then(() => process.exit(1))
  .catch((error) => {
    console.error(error);
   process.exit(1)
  });