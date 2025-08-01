#Include "Protheus.ch"

/*/{Protheus.doc} TXT
Como lidar com arquivos CSV.
@author Guilherme Kunsch
@since  31/07/2025
@version 12/Superior
/*/

User Function ArquivoCSV()
	Local aPergs    := {}
	Local aResps    := {}
	Local cTitulo   := "Operando arquivos CSV"
	Local cArquivo  := ""

	aAdd(aPergs, {6, ;
		"Informe o arquivo:" , ;
		"",                     ;
		"",                      ;
		"",                     ;
		"",                     ;
		80,                    ;
		.F.,                    ;
		"Arquivos .CSV |*.CSV", ;
		"",                     ;
		GETF_LOCALHARD + GETF_NETWORKDRIVE ;
		})

	If ParamBox(aPergs, cTitulo, @aResps)
		cArquivo := AllTrim(aResps[1])
		If File(cArquivo)
			xReadArq(@cArquivo)
		Else
			Help(,, "Help",,, "Caminho do arquivo a ser importado é inválido", 1, 0,,,,, .F., {"Verifique se o arquivo está correto!"} )
		EndIf
	EndIf
Return

/*/{Protheus.doc} xReadArq
Leitura de arquivo de dado
@author Guilherme Kunsch
@since 31/07/2025
/*/

Static Function xReadArq(cArquivo)
	Local nHandle   := -1
	Local cLinha    := ""
	Local aCabec    := {}
	Local aDados    := {}
	Local lLinPrim  := .T.
	Local cArqLog   := "LogProc" + DToS(Date()) + StrTran(Time(), ":", "") + ".log"
	Local cDir      := "C:\Log_Protheus\"
	Local nDir      := -1
	Local cLogProc  := ""
	Local nCount    := 0

	If ! ExistDir(cDir)
		nDir := MakeDir(cDir)
		If nDir != 0
			Help(NIL, NIL, "Falha", NIL, "Não foi possivel criar o diretório. Erro " + cValToChar( fError() ), 1, 0, NIL, NIL, NIL, NIL, NIL, {"Fale com um técnico"})
		EndIf
	EndIf

	nHandle := ft_fUse(cArquivo)
	If nHandle > 0
		While ! ft_fEOF()
			nCount ++
			cLinha := ft_fReadln()
			If lLinPrim
				aCabec := Separa(cLinha, ";")
				lLinPrim := .F.
			Else
				aDados := Separa(cLinha, ";")
				If ! Empty(aDados[1])
					xProcessa(aDados, @cLogProc)
				Else
					cLogProc += "Linha" + cValToChar(nCount) + " vazia!" + CRLF
				EndIf
			EndIf
			ft_fSkip()
		EndDo
	EndIf

	fClose(nHandle)

	iF ! Empty(cLogProc)
		cLogProc := "Log de processamento do arquivo CSV de inclusão de Produtos" + CRLF + cLogProc
		nHandle := fCreate(cDir, cArqLog, 0)
		fWrite(nHandle, cLogProc)
		fClose(nHandle)
		Help(NIL, NIL, "Atenção", NIL, "Arquivo processado", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Fale com um técnico"})
		shellExecute("Open","NOTEPAD.EXE", cDir + cArqLog, "", 1)
	EndIf
Return


/*/{Protheus.doc} xReadArq
Leitura de arquivo de dado
@author Guilherme Kunsch
@since 01/08/2025
/*/

//Nome;Sobrenome;Idade;Estado;Bairro;Numero
Static Function xProcessa(aDados, cLogProc)
	Local cNome := xNoAcento(aDados[1])
	Local cSobNome  := xNoAcento(aDados[2])
	Local nIdade  := Val(aDados[3])
	Local cEstado   := xNoAcento(aDados[4])
	Local cBairro   := xNoAcento(aDados[5])
	Local nNum  := Val(aDados[6])
Return
