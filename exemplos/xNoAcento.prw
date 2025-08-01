#INCLUDE 'Protheus.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} xNoAcento
Remove acentos do texto. Usado para substituir caracteres especiais.
@author  João Leão
@since   28/10/2022
@version 12/Superior
/*/
//-------------------------------------------------------------------
user function xNoAcento(cString, lAllChar, lBlankCl, lDot, lVirg, lDotVir, lBar, lArroub, lHifen, lUnderS, lParente)
Local cChar		:= ""
Local cVogal	:= "aeiouAEIOU"
Local cAgudo	:= "áéíóú"+"ÁÉÍÓÚ"
Local cCircu	:= "âêîôû"+"ÂÊÎÔÛ"
Local cTrema	:= "äëïöü"+"ÄËÏÖÜ"
Local cCrase	:= "àèìòù"+"ÀÈÌÒÙ"
Local cTio		:= "ãõÃÕ"
Local cCecid	:= "çÇ"
Local cMaior	:= "&lt;"
Local cMenor	:= "&gt;"
Local cEComer   := "&"
Local cApostr	:= "'"
Local cAspas	:= '"'
Local cSinMai	:= '>'
Local cSinMen	:= '<'
Local nX		:= 0
Local nY		:= 0

Default lBlankCl := .F.
Default lDot	 := .F.
Default lVirg	 := .F.
Default lDotVir  := .F.
Default lBar  	 := .F.
Default lArroub  := .F.
Default lHifen   := .F.
Default lUnderS  := .F.
Default lParente := .F.
Default lAllChar := .F.

If ValType(cString) == "C"
	If !Empty(cString)
		For nX:= 1 To Len(cString)
			cChar:=SubStr(cString, nX, 1)
			IF cChar$cAgudo+cCircu+cTrema+cCecid+cTio+cCrase
				nY:= At(cChar,cAgudo)
				If nY > 0
					cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
				EndIf
				nY:= At(cChar,cCircu)
				If nY > 0
					cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
				EndIf
				nY:= At(cChar,cTrema)
				If nY > 0
					cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
				EndIf
				nY:= At(cChar,cCrase)
				If nY > 0
					cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
				EndIf
				nY:= At(cChar,cTio)
				If nY > 0
					cString := StrTran(cString,cChar,SubStr("aoAO",nY,1))
				EndIf
				nY:= At(cChar,cCecid)
				If nY > 0
					cString := StrTran(cString,cChar,SubStr("cC",nY,1))
				EndIf
			Endif
		Next

		cString := StrTran( cString, CRLF, " " )

		If lBlankCl
			For nX:=1 To Len(cString)
				cChar:=SubStr(cString, nX, 1)
				If Asc(cChar) == 160 .Or. cChar == " "
					cString:=StrTran(cString,cChar,"")
				Endif
			Next nX
		EndIf

		If lDot
			cString := strTran( cString, ".", "" )
		EndIf

		If lVirg
			cString := strTran( cString, ",", "" )
		EndIf

		If lDotVir
			cString := strTran( cString, ";", "" )
		EndIf

		If lParente
			cString := strTran( cString, "(", "" )
			cString := strTran( cString, ")", "" )
		EndIf

		If lBar
			cString := strTran( cString, "\", "" )
			cString := strTran( cString, "/", "" )
			cString := strTran( cString, "|", "" )
		EndIf

		If lArroub
			cString := strTran( cString, "@", "" )
		EndIf

		If lHifen
			cString := strTran( cString, "-", "" )
		EndIf

		If lUnderS
			cString := strTran( cString, "_", "" )
		EndIf

		If cSinMai $ cString
			cString := strTran( cString, cSinMai, "" )
		EndIf

		If cSinMen $ cString
			cString := strTran( cString, cSinMen, "" )
		EndIf

		If cMaior$ cString
			cString := strTran( cString, cMaior, "" )
		EndIf

		If cMenor$ cString
			cString := strTran( cString, cMenor, "" )
		EndIf

		If cEComer$ cString
			cString := strTran( cString, cEComer, "E" )
		EndIf

		If cApostr $ cString
			cString := StrTran(cString, cApostr, "")
		EndIf

		If cAspas $ cString
			cString := StrTran(cString, cAspas, "")
		EndIf

		If lAllChar
			For nX:=1 To Len(cString)
				cChar:=SubStr(cString, nX, 1)
				If !(	(Asc(cChar) >= 48 .And. Asc(cChar) <= 57); //números de 0 a 9
						.Or. (Asc(cChar) >= 65 .And. Asc(cChar) <= 90); //letras maiúsculas
						.Or. (Asc(cChar) >= 97 .And. Asc(cChar) <= 122) ) //letras minúsculas
					cString:=StrTran(cString,cChar,"")
				Endif
			Next nX
		EndIf
	EndIf
Else
	cString := ""
EndIf

Return cString
