// SPDX-License-Identifier: MIT

pragma solidity 0.8.21;

import {IERC5192} from "./interfaces/IERC5192.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable2Step} from "@openzeppelin/contracts/access/Ownable2Step.sol";

contract ProfileNFT is Ownable2Step, ERC721("CareerZenProfile","CZP"), IERC5192 {
    address public immutable erc6551registry;
    address public immutable userAccountImplementation;
    uint256 public immutable chainId;
    mapping(uint256 => address) public boundAccount;
    mapping(uint256 => bool) private _locked;
    uint256 private _totalSupply;

    constructor(address erc6551registryAddress_, address userAccountImplementation_){
        erc6551registryAddress = erc6551registryAddress_;
        userAccountImplementation = userAccountImplementation_;
        chainId = block.chainid();
    }

    function mint(address to) public {
        //IMPLEMENT: address is allowed to mint its profile NFT

        _totalSupply++;
        
        //locks token on minting
        _locked[_totalSupply] = true;

        //starts at id#1
        _safeMint(to, _totalSupply);
        erc6551registry.call(abi.encodeWithSignature("createAccount(address,uint256,address,uint256,uint256,bytes)", userAccountImplementation,);)
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