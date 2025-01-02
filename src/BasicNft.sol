// SPDX-License-Identifier: MIT

// This Contract Mints a basic NFT and stores the URI of the token in a mapping

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    constructor() ERC721("Kitty", "CAT") {
        s_tokenCounter = 0;
    }

    // Minting the NFT using the _safeMint function from the ERC721 contract
    function mintNft(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }
    // Overriding the tokenURI function to return the URI of the token
    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }
}
