// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract InternshipNFT is ERC721 {

    uint256 public nextTokenId;

    constructor() ERC721("Internship Certificate NFT", "ICNFT") {}

    function mintCertificate() public {
        _safeMint(msg.sender, nextTokenId);
        nextTokenId++;
    }
}
