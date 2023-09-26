// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {IERC5192} from "../interfaces/IERC5192.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable2Step} from "@openzeppelin/contracts/access/Ownable2Step.sol";

contract ProfileNFT is Ownable2Step, ERC721, IERC5192 {

    // SBT is locked on minting
    mapping(uint256 => bool) private _unlocked;
    uint256 private _totalSupply;

    constructor(string memory name, string memory symbol) ERC721(name, symbol){}

    function mint(address to) public onlyOwner returns (uint256 tokenId_){

        _totalSupply++;
        uint256 tokenId = _totalSupply;

        //starts at id#1
        _safeMint(to, tokenId);
        tokenId_ = tokenId;
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256) internal view override {
        require(from == address(0) || to == address(0)|| _unlocked[tokenId], "SBT: only minting, burning or unlocked");
    }

    //IMPLEMENT signature verification?
    function unlockAndTransfer(uint256 tokenId, address to) external onlyOwner(){} 

    function locked(uint256 tokenId) external view returns (bool isLocked){
        isLocked = !_unlocked[tokenId];
    }

    function totalSupply() external view returns(uint256 supply){
        supply = _totalSupply;
    }
}