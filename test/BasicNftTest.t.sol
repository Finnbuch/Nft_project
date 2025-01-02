//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("USER");
    string public constant CUTE_CAT =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory name = basicNft.name();
        string memory expected_name = "Kitty";
        assert(
            keccak256(abi.encodePacked(name)) ==
                keccak256(abi.encodePacked(expected_name))
        );
    }
    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(CUTE_CAT);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(CUTE_CAT)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
