/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Gustavo Oliveira
This work is licensed under a Creative Commons Attribution 4.0 International License.

https://sepolia.etherscan.io/address/0x8BB5c4f63C92c7691bdD8551028fe6e1d3B90F70

0x8BB5c4f63C92c7691bdD8551028fe6e1d3B90F70
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
        gerarToken(10000);
    }

    function meuSaldo() public view returns(uint256) {
        return contractAddress.balanceOf(address(this));
    }

    function gerarToken(uint256 _valor) public returns (bool){
        return contractAddress.mint(address(this), _valor);
    }

}
