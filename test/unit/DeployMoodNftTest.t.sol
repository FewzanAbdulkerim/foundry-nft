// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testConverterSvgToUri() public view {
        string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="100"><text x="10" y="20" font-family="Verdana" font-size="20" fill="blue">Hi your brower decodes this.</text></svg>';
        string memory expectedUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iMTAwIj48dGV4dCB4PSIxMCIgeT0iMjAiIGZvbnQtZmFtaWx5PSJWZXJkYW5hIiBmb250LXNpemU9IjIwIiBmaWxsPSJibHVlIj5IaSB5b3VyIGJyb3dlciBkZWNvZGVzIHRoaXMuPC90ZXh0Pjwvc3ZnPg==";
        string memory actualUri = deployer.svgToImageURI(svg);
        assertEq(actualUri, expectedUri);
    }
}