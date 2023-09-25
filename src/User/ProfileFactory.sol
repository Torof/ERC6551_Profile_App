// SPDX-License-Identifier: MIT

pragma solidity 0.8.21;

// import {IERC5192} from "../interfaces/IERC5192.sol";
// import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./ProfileNFT.sol";
import {Ownable2Step} from "@openzeppelin/contracts/access/Ownable2Step.sol";

contract ProfileFactory is Ownable2Step {
    address public immutable erc6551registryAddress;
    address public immutable userAccountImplementationAddress;
    uint256 public immutable chainId;
    mapping(address => bool) private _allowlist;
    mapping(uint256 => address) public boundAccount;
    mapping(uint256 => bool) private _locked;
    
    address[] public profileTypeContracts;

    constructor(address erc6551registryAddress_, address userAccountImplementationAddress_){
        erc6551registryAddress = erc6551registryAddress_;
        userAccountImplementationAddress = userAccountImplementationAddress_;
        chainId = block.chainid;


    }

    function mintAndBound(address to, uint256 index) public returns (address tba){
        //IMPLEMENT: check address is allowed to mint its profile NFT

        (uint256 tokenId) = ProfileNFT(profileTypeContracts[index]).mint(to);
        (bool success, bytes memory data) = erc6551registryAddress.call(abi.encodeWithSignature("createAccount(address,uint256,address,uint256,uint256,bytes)", userAccountImplementationAddress,chainId, address(this), tokenId, 0));
        require(success, "failed to create account" );
        address _account = abi.decode(data, (address));
        boundAccount[tokenId] = _account;
        tba = _account;
    }

    function createNewProfileType(string memory name, string memory symbol) external {}

    //IMPLEMENT: function for onwership change of profileNFT
}