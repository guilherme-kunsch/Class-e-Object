#Include "Protheus.ch"

/*/{Protheus.doc} Class
Classe Pessoa

@author Guilherme Kunsch
@since  30/07/2025
@version 12/Superior
/*/

//criar um metodo de inserir dinheiro no saldo

Class Pessoa
    Data cNomPerson
    Data dNascimento
    Data nSaldoConta
    Data nValDepositado

    Method New(nNome, dDtNasc) Constructor
    Method PagarConta(nValor)
    Method InserirDinheiro(xValor)
EndClass


/*/{Protheus.doc} Contrutor
Contrutor da classe Pessoa

@author Guilherme Kunsch
@since  30/07/2025
@version 12/Superior
/*/

Method New(cNome, dDtNasc, nSaldoIni, nValDeposito) Class Pessoa
    ::cNomPerson     := cNome
    ::dNascimento   := dDtNasc
    ::nSaldoConta   := nSaldoIni
    ::nSaldoConta    := nSaldoIni + nValDeposito
Return self

Method PagarConta(nValor) Class Pessoa
    If ::nSaldoConta >= nValor
        ::nSaldoConta -= nValor
        Alert("Conta paga com sucesso!")
    else
        Alert("Saldo insuficiente.")
    EndIf
Return

Method InserirDinheiro(xValor) Class Pessoa
    If Empty(xValor)
        Alert("Por favor, digite um valor válido para depósito!")
    Else 
        ::nSaldoConta += xValor
        Alert("Seu saldo atual é de: R$", + CValToChar(::nSaldoConta))
    EndIf
Return


