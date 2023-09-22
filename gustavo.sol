/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Gustavo Oliveira
This work is licensed under a Creative Commons Attribution 4.0 International License.

https://sepolia.etherscan.io/address/0x690AaC2450d313Dfa82CF421A12d45dDba2339a4

0x690AaC2450d313Dfa82CF421A12d45dDba2339a4
*/
pragma solidity 0.8.19;

import "./bradesco_token_aberto.sol";

contract GORContrato is ExercicioToken {

    ExercicioToken public contractAddress;

    struct Client{
       address _client;
       uint256 _tokenBalance; 
    }

    mapping (address => Client) public client;

    constructor() {
        contractAddress = ExercicioToken(0x89A2E711b2246B586E51f579676BE2381441A0d0);
    }

    function saldo() public view returns (uint256) {
        return contractAddress.balanceOf(msg.sender);
    }

    function gerarToken(uint256 amount) public onlyOwner {
        client[msg.sender]._tokenBalance += amount;
    }

}
