// SPDX-License-Identifier: None

pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "../src/VolcanoCoin.sol";

error Unauthorized();

contract VolcanoCoinTest is Test {

    VolcanoCoin public volcanoCoin;

    function setUp() public {
        volcanoCoin = new VolcanoCoin();
    }

    function testTotalInitialSupply() public{
        uint256 totalSupply = volcanoCoin.getTotalSupply();
        assertEq(totalSupply, 10000);
    }

    function testTotalSupplyIncrease() public{
        uint256 totalSupply = volcanoCoin.getTotalSupply();
        assertEq(totalSupply, 10000);
        for (uint256 i = 0; i < 10; i++){
            uint256 previousTotalSupply = totalSupply;
            console.log(previousTotalSupply);
            volcanoCoin.increaseTotalSupply();
            totalSupply = volcanoCoin.getTotalSupply();
            assertEq(totalSupply, previousTotalSupply+1000);
        }
    }

    function testFailIncrementAsNotOwner() public{
        vm.expectRevert(Unauthorized.selector);
        vm.prank(address(0));
        volcanoCoin.increaseTotalSupply();  
    }

}