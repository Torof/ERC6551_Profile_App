// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

// import {IERC5192} from "../interfaces/IERC5192.sol";
// import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./ProfileNFT.sol";
import {Ownable2Step} from "@openzeppelin/contracts/access/Ownable2Step.sol";

contract ProfileFactory is Ownable2Step {

    address public immutable erc6551registryAddress;
    address public immutable userAccountImplementationAddress;
    uint256 public immutable chainId;

    //index => address of profileTypeContract
    address[] public profileTypeContracts;

    //address of user => is allowed to mint
    mapping(address => bool) private _allowlist;

    //CHECK is this needed? => or use account() from ERC6551Registry?
    //index of profileTypeContractAddress => tokenId => boundAccount
    mapping(uint256 => mapping(uint256 => address)) public boundAccount;

    constructor(address erc6551registryAddress_, address userAccountImplementationAddress_){
        erc6551registryAddress = erc6551registryAddress_;
        userAccountImplementationAddress = userAccountImplementationAddress_;
        chainId = block.chainid;
    }

    function mintAndBound(address to, uint256 index) public returns (address tba){
        //IMPLEMENT: check address is allowed to mint its profile NFT

        //mints token of specific profileType
        (uint256 tokenId) = ProfileNFT(profileTypeContracts[index]).mint(to);

        //create account in ERC6551Registry and bind to profileNFT
        (bool success, bytes memory data) = erc6551registryAddress.call(abi.encodeWithSignature("createAccount(address,uint256,address,uint256,uint256,bytes)", userAccountImplementationAddress,chainId, profileTypeContracts[index], tokenId, 0));
        require(success, "failed to create account" );

        //register boundAccount for tokenId of profileType
        address _account = abi.decode(data, (address));
        boundAccount[index][tokenId] = _account;
        tba = _account;
    }

    //CHECK simple array of addresses or array of structs?
    function createNewProfileType(string memory name, string memory symbol) external {
        //IMPLEMENT: check address is allowed to create new profileType

        //deploy new profileTypeContract
        ProfileNFT profileTypeContract = new ProfileNFT(name, symbol);

        //add to profileTypeContracts
        profileTypeContracts.push(address(profileTypeContract));
    }

    function account() external view returns (address account_){
    }

    //IMPLEMENT: function for onwership change of profileNFT
}