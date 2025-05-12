//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script{
    function run() public returns (MoodNft){
        string memory sadSvg= vm.readFile("./img/sad.svg");
        string memory happySvg=vm.readFile("./img/happy.svg");
        console.log(sadSvg);
    }

    function svgToImageURI(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(svg));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}