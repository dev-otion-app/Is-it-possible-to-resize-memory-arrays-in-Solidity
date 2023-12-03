// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

contract PlayingWithArrays{

    // This function is commented as otherwise the contract won't be compiled
    // function dont_do_this(uint[] memory array) external pure returns(uint[] memory){
    //     array.push(3);
    //     return array;
    // }

    uint[] storage_array = [1,2];

    function grow_storage_array() external{
        storage_array.push(3);
    }

    function request_element_in_memory(uint[] memory array, uint element) external pure returns(uint a){
        a = array[element]; // Checks if element is less than the length (the word pointed by array). Then returns the corresponding offset if it exists.
    }

    function grow_memory_array(uint[] memory array) external pure returns(uint[] memory){
        assembly{
            mstore(array, add(mload(array),1)) // Increase the size of the array in 1
            mstore(0x40, add(mload(0x40),0x20)) // Update the free memory pointer
        }
        array[array.length - 1] = 3; // New array element
        return array;
    }

    function grow_memory_array_2(uint[] memory array) external pure returns(uint[] memory){
        assembly{
            mstore(array, add(mload(array),1)) // Increase the size of the array in 1
            mstore(add(array, mul(mload(array),0x20)), 0x3) // Add a new element in the corresponding offset
            mstore(0x40, add(mload(0x40),0x20)) // Update the free memory pointer
        }
        return array;
    }

}