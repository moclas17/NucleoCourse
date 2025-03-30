
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AlcanciaDigital{
    address public owner;
    uint public cantidadObjetivo;
    string public nombreAlcancia;
    bool public alcanciaAbierta;

    constructor(string memory _nombreInicial, uint _objetivoInicial){
        owner = msg.sender;
        nombreAlcancia = _nombreInicial;
        cantidadObjetivo = _objetivoInicial;
        alcanciaAbierta = true;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "No eres el duenio del contrato");
        _;
    }

    function cambiarNombreAlcancia(string memory _nombreInicial) public onlyOwner{
        nombreAlcancia = _nombreInicial;
    }
    function cambiarObjetivo(uint _objetivoInicial) public onlyOwner {
        cantidadObjetivo = _objetivoInicial;
    }
    function cambiarEstadoAlcancia() public onlyOwner{
        alcanciaAbierta = ! alcanciaAbierta;
    }
    function depositarFondos() public payable {
        require(alcanciaAbierta, "No puede hacer deposito a esta alcancia");
        //require(msg.value > 0, "No puede depositar 0");

    }

    function obtenerBalance() public view returns (uint) {
        return address(this).balance;
    }

    function comprobarObjetivoAlcanzado () public view onlyOwner returns (bool){    
        return cantidadObjetivo <= obtenerBalance();
    }

     
}