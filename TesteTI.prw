#Include "Protheus.ch"
User Function TesteTI()
    Local cNome := "Guilherme Kunsch"
    Local dNasc := CToD("04/01/1999")
    Local nSldIni := 1000
    Local nValDeposito := 500

    Local oPessoa := Pessoa():New(cNome, dNasc, nSldIni, nValDeposito)

    Alert("Nome: " + oPessoa:cNomPerson)
    Alert("Nascimento: " + DToC(oPessoa:dNascimento))
    Alert("Saldo atual: R$ " + CValToChar(oPessoa:nSaldoConta)) // Deve mostrar 1500

    oPessoa:PagarConta(300) // saldo agora: 1200
    oPessoa:InserirDinheiro(100) // saldo agora: 1300
Return
