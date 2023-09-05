// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {UserAccount} from "../src/UserAccount.sol";
import {Registry} from "../src/Registry.sol";
import {ProfileNFT} from "../src/ProfileNFT.sol";

contract CareerzenTest is Test {
    uint256 public constant HELPER_CHAINID = 31337;

    Registry public czRegistry;
    UserAccount public czAccount;
    ProfileNFT public czProfileNFT;
    address public contractsOwner = vm.addr(10);
    address public profileToken1 = vm.addr(11);
    address public profileToken2 = vm.addr(12);

    function setUp() public {
        vm.startPrank(contractsOwner);
        czAccount = new UserAccount();
        czRegistry = new Registry();
        czProfileNFT = new ProfileNFT(address(czRegistry), address(czAccount));
    }

    function test() public {
        
    }

    // function test() public {
    //     assertEq(contractsOwner, czProfileNFT.ownerOf(1));

    //     vm.prank(contractsOwner);
    //     czProfileNFT.safeTransferFrom(contractsOwner, tbaOwner, 1);
    //     //tbaOwner is now owner of token id 1

    //     assertEq(tbaOwner, czProfileNFT.ownerOf(1));
    //     console.log(address(czRegistry));

    //     //Creates TBA for token id 1
    //     address tbaAccountAddress_1 =
    //         czRegistry.createAccount(address(czAccount), HELPER_CHAINID, address(czProfileNFT), 1, 0, "");
    //     console.log(tbaAccountAddress_1);

    //     //Transfer token id 2 to TBA , owner is now TBA or token id 1
    //     vm.prank(contractsOwner);
    //     czProfileNFT.safeTransferFrom(contractsOwner, tbaAccountAddress_1, 2);
    //     //verify owner is tba
    //     assertEq(tbaAccountAddress_1, czProfileNFT.ownerOf(2));

    //     //test that tbaAccounts and onERC721Receiver works
    //     (bool success, bytes memory data) = tbaAccountAddress_1.call(abi.encodeWithSignature("testString()"));
    //     string memory decoded = abi.decode(data, (string));
    //     assertEq(decoded, "hello");

    //     vm.prank(contractsOwner);
    //     vm.expectRevert(abi.encodePacked("ERC721: caller is not token owner or approved"));
    //     czProfileNFT.safeTransferFrom(tbaAccountAddress_1, tbaOwner, 2);

    //     vm.prank(tbaOwner);
    //     //make transfer of token id 2 from TBA to address3
    //     UserAccount(payable(tbaAccountAddress_1)).execute(
    //         address(czProfileNFT),
    //         0,
    //         abi.encodeWithSignature("safeTransferFrom(address,address,uint256)", tbaAccountAddress_1, address3, 2),
    //         0
    //     );
    //     //verify address3 is now owner of token id 2
    //     assertEq(address3, czProfileNFT.ownerOf(2));
    // }
}
