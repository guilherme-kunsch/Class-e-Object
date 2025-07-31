#Include "Protheus.ch"

/*/{Protheus.doc} TXT
Como lidar com arquivos TXT.
@author Guilherme Kunsch
@since  30/07/2025
@version 12/Superior
/*/

User Function ArquivoTXT()
    Local aPergs    := {}
    Local aResps    := {}
    Local cTitulo   := "Operando arquivos TXT"
    Local cArquivo  := ""

    aAdd(aPergs, {6, ;
        "Informe o arquivo:" , ; 
        "",                     ; 
        9,                      ; 
        50,                     ; 
        .T.,                    ; 
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
@since 30/07/2025
/*/

Static Function xReadArq(cArquivo)
    Local nHandle   := -1
    Local cLinha    := ""

    nHandle := ft_fUse(cArquivo)
    If nHandle > 0 
        While ! ft_fEOF()
            cLinha := ft_fReadln()
            ft_fSkip()
        EndDo
    EndIf

    fClose(nHandle)
Return
