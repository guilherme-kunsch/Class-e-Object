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
    Local cTitulo   := "Operando arquivos TXT"
    Local cArquivo  := ""

    aAdd(aPergs, {6, ;
        "Informe o arquivo:" , ; 
        "",                     ; 
        "",                      ; 
        "",                     ; 
        "",                     ;
        80,                    ; 
        .F.,                    ;
        "Arquivos .TXT |*.TXT", ;
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

    nHandle := ft_fUse(cArquivo)
    If nHandle > 0 
        While ! ft_fEOF()
            cLinha := ft_fReadln()
            If lLinPrim 
                aCabec := Separa(cLinha, ";")
                lLinPrim := .F.
            Else
                aDados := Separa(cLinha, ";")
                xProcessa(aDados)
            EndIf
            ft_fSkip()
        EndDo
    EndIf

    fClose(nHandle)
Return
