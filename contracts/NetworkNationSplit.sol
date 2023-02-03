pragma solidity ^0.7.0;

contract NetworkNationSplit {
    address[] partners;
    uint[] percentages;
    uint totalPercentage;

    constructor(address[] memory _partners, uint[] memory _percentages) public {
        require(
            _partners.length == _percentages.length,
            "The number of partners and percentage must match."
        );

        for (uint i = 0; i < _partners.length; i++) {
            partners.push(_partners[i]);
            percentages.push(_percentages[i]);
            totalPercentage += _percentages[i];
        }

        require(
            totalPercentage == 100,
            "The total percentage must be 100."
        );
    }

    function distributeFee(uint fee) public {
        uint share;
        for (uint i = 0; i < partners.length; i++) {
            share = (fee * percentages[i]) / 100;
            partners[i].transfer(share);
        }
    }
}
