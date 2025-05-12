//SPDX-Licence-Identifier:MIT

pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";

contract DeployMoodNft is Test{
    DeployMoodNft public deployer;
    
    function setUP() public {
        deployer=new DeployMoodNft();
    }
    function testConverterSvgToUri() public {
        string memory svg = "<svg></svg>";
        string memory expectedUri = "data:image/svg+xml;base64,PHN2Zz48L3N2Zz4=";
        string memory actualUri = deployer.svgToImageURI(svg);
        assertEq(actualUri, expectedUri);
    }
}