//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant TOKEN_URI = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();  
    }

    function testNameIsCorrect() public {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        assertEq(actualName, expectedName);
    }
    function testCanMintAndHaveABalance() public {
        vm.startPrank(USER);
        basicNft.mintNft(TOKEN_URI);

        assert(basicNft.balanceOf(USER) == 1);
        assertEq(basicNft.tokenURI(0), TOKEN_URI);
    }
}