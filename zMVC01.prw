//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

//Variveis Estaticas
Static cTitulo := "Cadastro de jogos"
Static cAliasMVC := "SZ3"

/*/{Protheus.doc} User Function zMVC01
Cadastro de jogadores na tabela SZ3
@author Guilherme 
@since 13/08/2025
@version 12 superior
@type function
/*/

User Function zMVC01()
	Local aArea   := FWGetArea()
	Local oBrowse
	Private aRotina := {}

	//Definicao do menu
	aRotina := MenuDef()

	//Instanciando o browse
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias(cAliasMVC)
	oBrowse:SetDescription(cTitulo)
	oBrowse:DisableDetails()

	//Ativa a Browse
	oBrowse:Activate()

	FWRestArea(aArea)
Return Nil


Static Function MenuDef()
	Local aRotina   := {}

	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.zMVC01" OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.zMVC01" OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE "Editar" ACTION "VIEWDEF.zMVC01" OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.zMVC01" OPERATION 5 ACCESS 0

Return aRotina


Static Function ModelDef()
	Local oStruct    := FWFormStruct(1,cAliasMVC)//formulário padrão Protheus
	Local oModel

	oModel  := MPFormModel():New("zMVC01M")
	oModel:AddFields("SZ3MASTER", /*cOwner*/, oStruct)
	oModel:SetDescription("Modelo de dados - " + cTitulo)
	oModel:GetModel("SZ3MASTER"):SetDescription("Dados de - " + cTitulo)
	oModel:SetPrimaryKey({ "Z3_FILIAL", "Z3_CODJG" })

Return oModel


Static Function ViewDef()
    Local oModel    := FWLoadModel("zMVC01")
    Local oStruct   := FWFormStruct(2, cAliasMVC)
    Local oView

    oView   := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEW_SZ3", oStruct, "SZ3MASTER")
    oView:CreateHorizontalBox( "TELA", 100 )
    oView:SetOwnerView( "VIEW_SZ3", "TELA" )
Return oView
