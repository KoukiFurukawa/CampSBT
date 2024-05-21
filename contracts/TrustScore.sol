// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract TrustScoreV1
{
    address internal owner;
    mapping(address => int256) internal score;
    
    constructor()
    {
        owner = msg.sender;
        score[owner] = 530000;
    }

    function addition(int256 amount) external 
    {
        score[msg.sender] += amount;
    }

    function subtraction(int256 amount) external 
    {
        score[msg.sender] -= amount;
    }

    function get_score() external view returns (int256)
    {
        return score[msg.sender];
    }

}