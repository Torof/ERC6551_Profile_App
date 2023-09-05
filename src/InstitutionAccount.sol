// SPDX-License-Identifier: MIT

pragma solidity 0.8.21;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {Ownable2Step} from "@openzeppelin/contracts/access/Ownable2Step.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract InstitutionAccount is ERC1155, Ownable2Step {
    using Strings for uint256;
    constructor(string memory uri) ERC1155(uri){}

    function mint(address to, uint256 id, uint256 amount) external onlyOwner() {
        _mint(to, id, amount, "");
    }

    function uri(uint256 tokenId) public view override returns(string memory) {
        return bytes(super.uri(tokenId)).length > 0 ? string(abi.encodePacked(super.uri(tokenId), tokenId.toString())) : "";
    }
}
