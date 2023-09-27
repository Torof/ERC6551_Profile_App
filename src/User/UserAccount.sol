// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import "../ERC6551_implementation/ERC6551Account.sol";
import {IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import {IERC1155Receiver} from "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";


contract UserAccount is ERC6551Account, IERC721Receiver, IERC1155Receiver {
    //TODO add ownership cycle guards

    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data)
        external
        returns (bytes4)
    {
        return IERC721Receiver.onERC721Received.selector;
    }

    function onERC1155Received(address operator, address from, uint256 id, uint256 value, bytes calldata data)
        external
        returns (bytes4)
    {
        return IERC1155Receiver.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external returns (bytes4) {
        return IERC1155Receiver.onERC1155BatchReceived.selector;
    }

    function supportsInterface(bytes4 interfaceId) external override(ERC6551Account, IERC165) pure returns (bool) {
        return (
            interfaceId == type(IERC165).interfaceId || 
            interfaceId == type(IERC6551Account).interfaceId ||
            interfaceId == type(IERC6551Executable).interfaceId ||
            interfaceId == type(IERC1155Receiver).interfaceId ||
            interfaceId ==  type(IERC721Receiver).interfaceId
        );
    }

    //IMPLEMENT: equip functionnality ?
}
