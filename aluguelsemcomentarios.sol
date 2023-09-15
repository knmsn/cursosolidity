/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Jeff Prestes
This work is licensed under a Creative Commons Attribution 4.0 International License.

https://sepolia.etherscan.io/tx/0xb25745e46998d6cbda8f17650c1b53458f2f353f8a2c88cb2eb1fdfec1cf3acb
https://sepolia.etherscan.io/tx/0xb25745e46998d6cbda8f17650c1b53458f2f353f8a2c88cb2eb1fdfec1cf3acb
https://sepolia.etherscan.io/tx/0xb25745e46998d6cbda8f17650c1b53458f2f353f8a2c88cb2eb1fdfec1cf3acb
https://sepolia.etherscan.io/tx/0xb25745e46998d6cbda8f17650c1b53458f2f353f8a2c88cb2eb1fdfec1cf3acb
https://sepolia.etherscan.io/tx/0xb25745e46998d6cbda8f17650c1b53458f2f353f8a2c88cb2eb1fdfec1cf3acb
https://sepolia.etherscan.io/tx/0xb25745e46998d6cbda8f17650c1b53458f2f353f8a2c88cb2eb1fdfec1cf3acb
*/
pragma solidity 0.8.19;

contract Aluguel {
    string public locatario;
    string public locador;
    uint256 private valor;
    uint256 constant public numeroMaximoLegalDeAlugueisParaMulta = 3;
    bool[] public statusPagamento;

    address payable public contaLocador;
    address public owner;
    address payable private contaLocadorPersisted;

    constructor(    string memory _nomeLocador, 
                    string memory _nomeLocatario, 
                    address payable _contaLocador, 
                    uint256 _valorDoAluguel)  payable {
        locador = _nomeLocador;
        locatario = _nomeLocatario;
        valor = _valorDoAluguel;
        contaLocador = _contaLocador;
        owner = msg.sender;
    }
 
    function valorAtualDoAluguel() public view returns (uint256) {
        return valor;
    }
 
    function simulaMulta( uint256 mesesRestantes, uint256 totalMesesContrato) public view returns(uint256 valorMulta) 
    {
        valorMulta = valor*numeroMaximoLegalDeAlugueisParaMulta;
        valorMulta = valorMulta/totalMesesContrato;
        valorMulta = valorMulta*mesesRestantes;
        return valorMulta;
    } 
        
    function reajustaAluguel(uint256 percentualReajuste) public 
    {
        if (percentualReajuste > 20) {
            percentualReajuste = 20;
        }
        uint256 valorDoAcrescimo = 0;
        valorDoAcrescimo = ((valor*percentualReajuste)/100);
        valor = valor + valorDoAcrescimo;
    }
    
    function aditamentoValorAluguel(uint256 valorCerto) public   {
        valor = valorCerto;
    }

    function aplicaMulta(uint256 mesesRestantes, uint256 percentual) public     {
        require(mesesRestantes<30, "Periodo de contrato invalido");
        for (uint numeroDeVoltas=0; numeroDeVoltas < mesesRestantes; numeroDeVoltas=numeroDeVoltas+2) {
            valor = valor+((valor*percentual)/100);
        }
    }
    

    function receberPagamento() public payable {
        require(contaLocadorPersisted==contaLocador, "Nao e o locador");
        require(msg.value>=valor, "Valor insuficiente");
        contaLocador.transfer(msg.value);
        statusPagamento.push(true);
    }
    
    function retornaTexto(uint256 _parametro) public view returns (string memory) {
        if ((valor * _parametro) > 5000) {
            return "Muito caro";
        } else {
            return "Preco razoavel";
        }
    }
    
    function quantosPagamentosJaForamFeitos() public view returns (uint256) {
        return statusPagamento.length;
    }
}
