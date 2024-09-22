import {ethers} from "hardhat"
// import { Contract } from "../typechain-types";

async function main() {

     const [owner, other] = await ethers.getSigners();

  const NFT = await ethers.deployContract("CodingFlare");
  
  NFT.waitForDeployment();

  

  console.log(`NFT deployed to ${NFT.target}`);

  console.log("-----------------  Minting NFT to second address  --------------------");

    const mintToken = await NFT.mintCollectionNFT();

    mintToken.wait();

    console.log(" Token minted");
}

main()
  .then(() => process.exit(1))
  .catch((error) => {
    console.error(error);
   process.exit(1)
  });