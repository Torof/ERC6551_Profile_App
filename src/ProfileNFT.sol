// SPDX-License-Identifier: MIT

pragma solidity 0.8.21;

import {IERC5192} from "./interfaces/IERC5192.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable2Step} from "@openzeppelin/contracts/access/Ownable2Step.sol";

contract ProfileNFT is Ownable2Step, ERC721("CareerZenProfile","CZP"), IERC5192 {
    address public immutable erc6551registryAddress;
    address public immutable userAccountImplementationAddress;
    uint256 public immutable chainId;
    mapping(uint256 => address) public boundAccount;
    mapping(uint256 => bool) private _locked;
    uint256 private _totalSupply;

    constructor(address erc6551registryAddress_, address userAccountImplementationAddress_){
        erc6551registryAddress = erc6551registryAddress_;
        userAccountImplementationAddress = userAccountImplementationAddress_;
        chainId = block.chainid;
    }

    function mint(address to) public returns (address){
        //IMPLEMENT: address is allowed to mint its profile NFT

        _totalSupply++;
        uint256 tokenId = _totalSupply;
        //locks token on minting
        _locked[tokenId] = true;

        //starts at id#1
        _safeMint(to, tokenId);
        (bool success, bytes memory data) = erc6551registryAddress.call(abi.encodeWithSignature("createAccount(address,uint256,address,uint256,uint256,bytes)", userAccountImplementationAddress,chainId, address(this), tokenId, 0));
        require(success, "failed to create account" );
        address _account = abi.decode(data, (address));
        boundAccount[tokenId] = _account;
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256) internal view override {
        require(from == address(0) || to == address(0)|| !_locked[tokenId], "SBT: only minting, burning or unlocked");
    }

    function unlockAndTransfer(uint256 tokenId, address to) external onlyOwner(){} 

    function locked(uint256 tokenId) external view returns (bool isLocked){
        isLocked = _locked[tokenId];
    }

    function totalSupply() external view returns(uint256 supply){
        supply = _totalSupply;
    }
}