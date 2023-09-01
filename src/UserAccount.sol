// SPDX-License-Identifier: MIT

pragma solidity 0.8.21;

import {ERC6551Account} from "./ERC6551Account.sol";
import {IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import {IERC1155Receiver} from "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";

contract UserAccount is ERC6551Account, IERC721Receiver, IERC1155Receiver {

        //TODO add ownership cycle guards
        function onERC721Received(
            address operator,
            address from,
            uint256 tokenId,
            bytes calldata data
        ) external returns (bytes4){
            testString = "hello";
            return IERC721Receiver.onERC721Received.selector;
        }

        function onERC1155Received(
            address operator,
            address from,
            uint256 id,
            uint256 value,
            bytes calldata data
        ) external returns (bytes4){
            return IERC1155Receiver.onERC1155Received.selector;
        }

        function onERC1155BatchReceived(
            address operator,
            address from,
            uint256[] calldata ids,
            uint256[] calldata values,
            bytes calldata data
        ) external returns (bytes4){
            return IERC1155Receiver.onERC1155BatchReceived.selector;
        }
    
        //ADD: ERC1155 receiver and batch receiver
        //IMPLEMENT: equip functionnality ?
}