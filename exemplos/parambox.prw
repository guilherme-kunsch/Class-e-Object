#Include "Protheus.ch"

/*/{Protheus.doc} xParambox
Função para explicar a função Parambox.

@author João Leão
@since  03/05/2023
@version 12/Superior
/*/
User Function xParambox()

    Local aPergs        := {}
    Local aResps        := {}
    Local aOpcoes       := {"1-Ruim", "2-Regular", "3-Bom", "4-Ótimo"}

    //[1]-Tipo 1 - MsGet
    //[2]-Descricao
    //[3]-String contendo o inicializador do campo
    //[4]-String contendo a Picture do campo
    //[5]-String contendo a validacao
    //[6]-Consulta F3
    //[7]-String contendo a validacao When
    //[8]-Tamanho do MsGet
    //[9]-Flag .T./.F. Parametro Obrigatorio ?
    aAdd(aPergs, {1, "Produto", CriaVar("B1_COD",.F.), X3Picture("B1_COD"), "ExistCpo('SB1', mv_par01)",  "SB1", "", 50, .f.}) // Tipo caractere
    aAdd(aPergs, {1, "Valor", CriaVar("C6_PRCVEN",.F.), X3Picture("C6_PRCVEN"), "mv_par02>0", "", "", 20, .F.}) // Tipo numérico
    aAdd(aPergs, {1, "Data", CriaVar("C5_EMISSAO",.F.), "", "", "", "", 50, .f.}) // Tipo data

    //[1]-Tipo 2 - Combo
    //[2]-Descricao
    //[3]-Numerico contendo a opcao inicial do combo
    //[4]-Array contendo as opcoes do Combo
    //[5]-Tamanho do Combo
    //[6]-Validacao
    //[7]-Flag .T./.F. Parametro Obrigatorio ?
    aAdd(aPergs, {2,"Escolha uma opção", "1-Ruim", aOpcoes, 50, "",.F.})

    //[1]-Tipo 3 - Rádio
    //[2]-Descricao
    //[3]-Numerico contendo a opcao inicial do Radio
    //[4]-Array contendo as opcoes do Radio
    //[5]-Tamanho do Radio
    //[6]-Validacao
    //[7]-Flag .T./.F. Parametro Obrigatorio ?
    aAdd(aPergs, {3,"Mostra deletados", 1, {"Sim","Não"}, 50, "", .F.})

    //[1]-Tipo 4 - Say + Checkbox
    //[2]-Descricao
    //[3]-Indicador Logico contendo o inicial do Check
    //[4]-Texto do CheckBox
    //[5]-Tamanho do Radio
    //[6]-Validacao
    //[7]-Flag .T./.F. Parametro Obrigatorio ?
    aAdd(aPergs, {4, "Marca todos ?", .F., "Marque todos se necessário.",90,"",.F.})

    //[1]-Tipo 5 - Somente checkbox
    //[2]-Descricao
    //[3]-Indicador Logico contendo o inicial do Check
    //[4]-Tamanho do Radio
    //[5]-Validacao
    //[6]-Flag .T./.F. Parametro Obrigatorio ?    
    aAdd(aPergs, {5, "Marca todos ?", .F., 50, "", .F.})

    //[1]-Tipo 6 - Arquivo
    //[2]-Descricao
    //[3]-String contendo o inicializador do campo
    //[4]-String contendo a Picture do campo
    //[5]-String contendo a validacao
    //[6]-String contendo a validacao When
    //[7]-Tamanho do MsGet
    //[8]-Flag .T./.F. Parametro Obrigatorio ?
    //[9]-Texto contendo os tipos de arquivo, exemplo: "Arquivos .CSV |*.CSV"
    //[10]-Diretorio inicial do cGetFile
    //[11]-Número relativo a visualização, podendo ser por diretório ou por arquivo (0,1,2,4,8,16,32,64,128)
    aAdd(aPergs, {6, "Informe o Arquivo:" , "", "", "", "", 80, .F., "Arquivos .CSV |*.CSV", "", GETF_LOCALHARD+GETF_NETWORKDRIVE})

    //[1]-Tipo 7 -> Montagem de expressao de filtro
    //[2]-Descricao
    //[3]-Alias da tabela
    //[4]-Filtro inicial
    aAdd(aPergs, {7, "Monte o filtro", "SX5", "X5_FILIAL==xFilial('SX5')"})

    //[1]-Tipo 8 -> MsGet Password
    //[2]-Descricao
    //[3]-String contendo o inicializador do campo
    //[4]-String contendo a Picture do campo
    //[5]-String contendo a validacao
    //[6]-Consulta F3
    //[7]-String contendo a validacao When
    //[8]-Tamanho do MsGet
    //[9]-Flag .T./.F. Parametro Obrigatorio ?
    aAdd(aPergs, {8, "Digite a senha", Space(15), "", "", "", "", 80, .F.})

    //[1]-Tipo 9 -> Somente uma mensagem, formato de um título
    //[2]-Texto descritivo
    //[3]-Largura do texto
    //[4]-Altura do texto
    //[5]-Valor lógico sendo: .T. => fonte tipo VERDANA e .F. => fonte tipo ARIAL
    aAdd(aPergs, {9, "Texto aleatório, apenas demonstrativo.", 150, 7, .f.})

    //[1]-Tipo 10 -> Range de busca
    //[2]-Título
    //[3]-Inicializador padrão
    //[4]-Consulta F3
    //[5]-Tamanho do GET
    //[6]-Tipo do dado, somente (C=caractere e D=data)
    //[7]-Tamanho do espaço
    //[8]-Condição When    
    aAdd(aPergs, {10, "Cliente", Space(6), "SA1", 40, "C", 6, ".f."})

    //[1]-Tipo 11 -> MultiGet (Memo)
    //[2]-Descrição
    //[3]-Inicializador padrão
    //[4]-Validação
    //[5]-When
    //[6]-Campo com preenchimento obrigatório .T.=Sim .F.=Não (incluir a validação na função ParamOk)
    aAdd(aPergs, {11, "Informe o motivo", "", ".T.", ".T.", .f.})

    // Parametros da função Parambox()
    // -------------------------------
    // 1 - < aParametros > - Vetor com as configurações
    // 2 - < cTitle >      - Título da janela
    // 3 - < aRet >        - Vetor passador por referencia que contém o retorno dos parâmetros
    // 4 - < bOk >         - Code block para validar o botão Ok
    // 5 - < aButtons >    - Vetor com mais botões além dos botões de Ok e Cancel
    // 6 - < lCentered >   - Centralizar a janela
    // 7 - < nPosX >       - Se não centralizar janela coordenada X para início
    // 8 - < nPosY >       - Se não centralizar janela coordenada Y para início
    // 9 - < oDlgWizard >  - Utiliza o objeto da janela ativa
    //10 - < cLoad >       - Nome do perfil se caso for carregar
    //11 - < lCanSave >    - Salvar os dados informados nos parâmetros por perfil
    //12 - < lUserSave >   - Configuração por usuário

    // Caso alguns parâmetros para a função não seja passada será considerado DEFAULT as seguintes abaixo:
    // DEFAULT bOk   := {|| (.T.)}
    // DEFAULT aButtons := {}
    // DEFAULT lCentered := .T.
    // DEFAULT nPosX  := 0
    // DEFAULT nPosY  := 0
    // DEFAULT cLoad     := ProcName(1)
    // DEFAULT lCanSave := .T.
    // DEFAULT lUserSave := .F
    If Parambox(aPergs, "Meu Input Box", @aResps)
        Help(,, "Falha",, "Usuário clicou no OK.", 1, 0,,,,,, {""})
        CPYS2T( aResps[8], "c:\temp",.T. )
    Else
        Help(,, "Falha",, "Operação cancelada pelo usuário", 1, 0,,,,,, {""})
    EndIf

Return
