// SPDX-License-Identifier: MIT

pragma solidity 0.8.21;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {Ownable2Step} from "@openzeppelin/contracts/access/Ownable2Step.sol";

contract InstitutionAccount is ERC1155, Ownable2Step {
    constructor(string memory url) ERC1155(url){}

    function mint(address to, uint256 id, uint256 amount) external onlyOwner() {
        _mint(to, id, amount, "");
    }

    function uri(uint256 tokenId) public view override returns(string) {
        return super.uri().length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
    }
}
