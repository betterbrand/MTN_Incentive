pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract NetworkNationSplit is UUPSUpgradeable, OwnableUpgradeable {
    // Store an array of addresses and their corresponding percentages
    mapping(address => uint256) public feeDistribution;
    mapping(uint256 => uint256) public totalPercentage;

    // Store the network admin address
    address public networkAdmin;

    modifier only_admin {
        require(msg.sender == networkAdmin, "");
        _;
    }

    function initialize(address _admin) public initializer {
        __Context_init_unchained();
        __Ownable_init_unchained();
        __NetworkNationSplit_init_unchained(_admin);
        __UUPSUpgradeable_init_unchained();
    }

    function __NetworkNationSplit_init_unchained(address _admin) private onlyInitializing {
        networkAdmin = _admin;
    }

    // Function to set the network admin address
    function setNetworkAdmin(address _networkAdmin) public only_admin {
        networkAdmin = _networkAdmin;
    }

    // Function to set the fee distribution for an address
    function setFeeDistribution(address _address, uint _percentage) public only_admin {
       
        feeDistribution[_address] = _percentage;
    }


  function collectFee(uint amount, address[]memory partners) public payable {
        
        // Calculate the total percentage

            require (msg.value == amount, "Insufficient amount sent");
            
            //to do : Implement Split among addresses
            uint256 j = 0;

            for(j; j < partners.length; j++) {
                require(checkAddressValue(partners[j]), "Address is not a partner");

                uint256 _percentage = feeDistribution[partners[j]];

                payable(partners[j]).transfer(msg.value * _percentage);

            }


        }


    function checkAddressValue(address _address) public view returns (bool) {
    return feeDistribution[_address] != 0;
   }


    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {
    }

    }

