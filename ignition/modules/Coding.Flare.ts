import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const CodingFlareModule = buildModule("CodingFlareModule", (m) => {
  const codingflare = m.contract("CodingFlare");
  return { codingflare };
});

export default CodingFlareModule;
