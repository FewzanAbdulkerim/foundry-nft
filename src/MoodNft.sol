//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MoodNft is ERC721 {
    // Error messages
    error MoodNft__CannotFlipMoodIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_sadSvg;
    string private s_happySvg;

    enum Mood {
        SAD,
        HAPPY
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory sadSvg, string memory happySvg) ERC721("MoodNft", "MNFT") {
        s_tokenCounter = 0;
        s_sadSvg = sadSvg;
        s_happySvg = happySvg;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY; // Default mood is HAPPY
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        if (getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
            revert MoodNft__CannotFlipMoodIfNotOwner();
        }
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_ownerOf(tokenId) != address(0), "ERC721: URI query for nonexistent token");

        string memory imageURI = s_tokenIdToMood[tokenId] == Mood.HAPPY ? s_happySvg : s_sadSvg;
        string memory mood = s_tokenIdToMood[tokenId] == Mood.HAPPY ? "happy" : "sad";

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "Mood NFT",',
                        '"description": "An NFT that reflects the mood of the owner, 100% on Chain!",',
                        '"attributes": [{"trait_type": "mood", "value": "',
                        mood,
                        '"}],',
                        '"image": "',
                        imageURI,
                        '"}'
                    )
                )
            )
        );

        return string(abi.encodePacked("data:application/json;base64,", json));
    }
}
