unit UPrincipal;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao, Enter, Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.VirtualImage, Vcl.WinXCtrls, Vcl.CategoryButtons, System.ImageList,
  Vcl.ImgList, Vcl.BaseImageCollection, Vcl.ImageCollection,uFrmAtualizaDB,
  Vcl.VirtualImageList, uAlterarSenha, cUsuarioLogado, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.WinXPickers, IdBaseComponent, IdComponent,ZDbcIntfs,cAtualizacaoBancoDeDados, RLReport, cFuncao,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, VclTee.TeeGDIPlus,
  VCLTee.TeEngine, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart,cVerificarEstoque, uNotificacao,
  uCadFornecedor, uEntrada, uCalculadora, ZConnection, uConsultaOrcamento, uCEFChromiumCore, uCEFChromium,
  uCEFWinControl, uCEFLinkedWinControlBase, uCEFChromiumWindow, uCEFApplication,
  uDashboard, Vcl.WinXCalendars, IdTCPConnection, IdTCPClient, IdTime,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,System.JSON,
  Vcl.Grids, uConsultaProduto, Vcl.Mask, IniFiles;
type
  TfrmPrincipal = class(TForm)
    pnlTopMenu: TPanel;
    mnuLateral: TSpeedButton;
    SVMenu: TSplitView;
    CategoryButtonsPrincipal: TCategoryButtons;
    CategoryButtonsSair: TCategoryButtons;
    ListaVirtualImg: TVirtualImageList;
    ColecaoImg: TImageCollection;
    SVSubMenu: TSplitView;
    CategoryButtonsCadastro: TCategoryButtons;
    CategoryButtonsMovimentacao: TCategoryButtons;
    CategoryButtonsRelatorios: TCategoryButtons;
    StbPrincipal: TStatusBar;
    lblBemVindo: TLabel;
    CategoryButtonsPermissoes: TCategoryButtons;
    ChromiumWindowWhatsapp: TChromiumWindow;
    ChromiumWhatsapp: TChromium;
    pnlbody: TPanel;
    memoPensamento: TMemo;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    QryProdutos: TZQuery;
    QryProdutosprodutoId: TZIntegerField;
    QryProdutosnome: TZUnicodeStringField;
    QryProdutosdescricao: TZUnicodeStringField;
    QryProdutosvalor: TZFMTBCDField;
    QryProdutoscodbarras: TZUnicodeStringField;
    QryProdutosfoto: TZBlobField;
    dtsProdutos: TDataSource;
    lkpProdutoSelecionado: TDBLookupComboBox;
    dmImageProduto: TDBImage;
    lblProduto: TLabel;
    lblFoto: TLabel;
    lblDescricao: TLabel;
    dbMemoDescricaoProduto: TDBMemo;
    btnPesquisarProduto: TSpeedButton;
    lblExtrato: TLabel;
    lblQuantidade: TLabel;
    lblValor: TLabel;
    dbedtQuantidade: TDBEdit;
    QryProdutosquantidade: TZFMTBCDField;
    dbedtValor: TDBEdit;
    switchDark: TToggleSwitch;
    Label5: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuLateralClick(Sender: TObject);
    procedure CategoryButtons1Categories0Items0Click(Sender: TObject);
    procedure CategoryButtonsPrincipalCategories0Items0Click(Sender: TObject);
    procedure CategoryButtonsPrincipalCategories0Items1Click(Sender: TObject);
    procedure CategoryButtonsPrincipalCategories0Items2Click(Sender: TObject);
    procedure CategoryButtonsCadastroCategories0Items0Click(Sender: TObject);
    procedure CategoryButtonsCadastroCategories0Items1Click(Sender: TObject);
    procedure CategoryButtonsCadastroCategories0Items2Click(Sender: TObject);
    procedure CategoryButtonsCadastroCategories0Items3Click(Sender: TObject);
    procedure CategoryButtonsMovimentacaoCategories0Items0Click(Sender: TObject);
    procedure CategoryButtonsRelatoriosCategories0Items0Click(Sender: TObject);
    procedure CategoryButtonsRelatoriosCategories0Items1Click(Sender: TObject);
    procedure CategoryButtonsRelatoriosCategories0Items2Click(Sender: TObject);
    procedure CategoryButtonsRelatoriosCategories0Items3Click(Sender: TObject);
    procedure CategoryButtonsRelatoriosCategories0Items4Click(Sender: TObject);
    procedure CategoryButtonsRelatoriosCategories0Items5Click(Sender: TObject);
    procedure CategoryButtonsCadastroCategories0Items4Click(Sender: TObject);
    procedure CategoryButtonsCadastroCategories0Items5Click(Sender: TObject);
    procedure CategoryButtonsCadastroCategories0Items6Click(Sender: TObject);
    procedure CategoryButtonsCadastroCategories0Items7Click(Sender: TObject);
    procedure CategoryButtonsMovimentacaoCategories0Items1Click(
      Sender: TObject);
    procedure CategoryButtonsPrincipalCategories0Items3Click(Sender: TObject);
    procedure CategoryButtonsPermissoesCategories0Items1Click(Sender: TObject);
    procedure CategoryButtonsPermissoesCategories0Items0Click(Sender: TObject);
    procedure CategoryButtonsRelatoriosCategories0Items6Click(Sender: TObject);
    procedure btnPesquisarProdutoClick(Sender: TObject);
    procedure lkpProdutoSelecionadoEnter(Sender: TObject);
    procedure switchDarkClick(Sender: TObject);
  private
    { Private declarations }
    TeclaEnter : TMREnter;
    VerificarEstoque : TVerificarEstoque;
    procedure AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
    procedure closeSubMenu(Sender: TObject);
    procedure SaveSwitchState(AState: Boolean);
    function LoadSwitchState: Boolean;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  oUsuarioLogado : TUsuarioLogado;
  frmNotificacao : TfrmNotificacao;


implementation
{$R *.dfm}

uses cArquivoIni, uCadCategoria,
  uCadCliente, uCadProduto, uProVenda, uRelCategoria, uRelCadClientes, uRelCadClienteFicha,
  uRelCadProduto, uRelCadProdutoComGrupoCategoria, uSelecionarData,
  uRelVendaPorData, uCadUsuario, uLogin, cAcaoAcesso, uCadAcaoAcesso,
  uUsuarioVsAcoes, uTelaHeranca, uDTMGrafico, uConsultarCEP;

procedure TfrmPrincipal.btnPesquisarProdutoClick(Sender: TObject);
begin
TRY
  frmConsultaProduto:=TfrmConsultaProduto.Create(Self);

  if lkpProdutoSelecionado.KeyValue<>Null then
     frmConsultaProduto.aIniciarPesquisaId:=lkpProdutoSelecionado.KeyValue;

  frmConsultaProduto.ShowModal;

  if frmConsultaProduto.aRetornarIdSelecionado<>Unassigned then  //N�o Atribuido
     lkpProdutoSelecionado.KeyValue:=frmConsultaProduto.aRetornarIdSelecionado;
  FINALLY
       frmConsultaProduto.Release;
  END;
end;

procedure TfrmPrincipal.CategoryButtons1Categories0Items0Click(Sender: TObject);

begin
  case MessageDlg('Deseja sair da aplica��o?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) of
  mrYes :
    begin
    Application.Terminate;
    end;
  mrNo :
    begin
      ShowMessage('Obrigado por continuar utilizando nossa aplica��o.')
    end;
  end;

end;

procedure TfrmPrincipal.CategoryButtonsCadastroCategories0Items0Click(
  Sender: TObject);
begin// cadastro de cliente
   TFuncao.CriarForm(TfrmCadCliente, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoryButtonsCadastroCategories0Items1Click(
  Sender: TObject);
begin// cadastro de categoria
   TFuncao.CriarForm(TfrmCadCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoryButtonsCadastroCategories0Items2Click(
  Sender: TObject);
begin // cadastro de produto
   TFuncao.CriarForm(TfrmCadProduto, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoryButtonsCadastroCategories0Items3Click(
  Sender: TObject);
begin // cadastro de usu�rio
   TFuncao.CriarForm(TfrmCadUsuario, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoryButtonsCadastroCategories0Items4Click(
  Sender: TObject);
begin// Alterar a senha
  TFuncao.CriarForm(TfrmAlterarSenha, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoryButtonsCadastroCategories0Items5Click(
  Sender: TObject);
begin// A��o de acesso
  TFuncao.CriarForm(TfrmCadAcaoAcesso, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoryButtonsCadastroCategories0Items6Click(
  Sender: TObject);
begin// a��es de usu�rios
  TFuncao.CriarForm(TfrmUsuarioVsAcoes, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoryButtonsCadastroCategories0Items7Click(
  Sender: TObject);
begin // cadastro de fornecedores
  TFuncao.CriarForm(TfrmCadFornecedor, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoryButtonsMovimentacaoCategories0Items0Click(
  Sender: TObject);
begin// Vendas
  TFuncao.CriarForm(TfrmProVenda, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoryButtonsMovimentacaoCategories0Items1Click(
  Sender: TObject);
begin
  TFuncao.CriarForm(TfrmEntrada, oUsuarioLogado, dtmPrincipal.ConexaoDB);//
end;

procedure TfrmPrincipal.CategoryButtonsPermissoesCategories0Items0Click(
  Sender: TObject);
begin
    TFuncao.CriarForm(TfrmCadAcaoAcesso, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoryButtonsPermissoesCategories0Items1Click(
  Sender: TObject);
begin
     TFuncao.CriarForm(TfrmUsuarioVsAcoes, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoryButtonsPrincipalCategories0Items0Click(
  Sender: TObject);
begin//aqui expande o menu de cadastro e deixa visivel os itens dele
   CloseSubMenu(SVSubMenu);
   CategoryButtonsCadastro.Visible := True;
   CategoryButtonsCadastro.Enabled := True;
end;

procedure TfrmPrincipal.CategoryButtonsPrincipalCategories0Items1Click(
  Sender: TObject);
begin
   CloseSubMenu(SVSubMenu);//aqui expande o menu de vendas e deixa visivel os itens dele
   CategoryButtonsMovimentacao.Visible := True;
   CategoryButtonsMovimentacao.Enabled := True;
end;

procedure TfrmPrincipal.CategoryButtonsPrincipalCategories0Items2Click(
  Sender: TObject);
begin
   CloseSubMenu(SVSubMenu);//aqui expande o menu de relatorios e deixa visivel os itens dele
   CategoryButtonsRelatorios.Visible := True;
   CategoryButtonsRelatorios.Enabled := True;
end;

procedure TfrmPrincipal.CategoryButtonsPrincipalCategories0Items3Click(
  Sender: TObject);
begin
   CloseSubMenu(SVSubMenu);//aqui expande o menu de relatorios e deixa visivel os itens dele
   CategoryButtonsPermissoes.Visible := True;
   CategoryButtonsPermissoes.Enabled := True;
end;

procedure TfrmPrincipal.CategoryButtonsRelatoriosCategories0Items0Click(
  Sender: TObject);
begin// chama relatorio de categorias
  TFuncao.CriarRelatorio(TfrmRelCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoryButtonsRelatoriosCategories0Items1Click(
  Sender: TObject);
begin// chama o relatorio de clientes
   TFuncao.CriarRelatorio(TfrmRelCadClientes, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoryButtonsRelatoriosCategories0Items2Click(
  Sender: TObject);
begin// chama o relatorio de ficha de clientes
    TFuncao.CriarRelatorio(TfrmRelCadClienteFicha, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoryButtonsRelatoriosCategories0Items3Click(
  Sender: TObject);
begin// chama o relatorio de cadastro de produtos
   TFuncao.CriarRelatorio(TfrmRelCadProduto, oUsuarioLogado, dtmPrincipal.ConexaoDB)
end;

procedure TfrmPrincipal.CategoryButtonsRelatoriosCategories0Items4Click(
  Sender: TObject);
begin// chama o relatorio de cadastro de produto com as categorias
    TFuncao.CriarRelatorio(tfrmRelCadProdutoComGrupoCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CategoryButtonsRelatoriosCategories0Items5Click(
  Sender: TObject);
begin
   TFuncao.CriarRelatorioPorData(TfrmRelVendaPorData, oUsuarioLogado, dtmPrincipal.ConexaoDB);  // para criar a tela de relat�rio venda por data, foi criada uma fun��o apenas para poder aceitar permiss�o nessa tela
end;



procedure TfrmPrincipal.CategoryButtonsRelatoriosCategories0Items6Click(
  Sender: TObject);
begin
    TFuncao.CriarForm(TfrmDashboard, oUsuarioLogado, dtmPrincipal.ConexaoDB);//
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(TeclaEnter);// limpa da memoria ao fechar
  FreeAndNil(dtmPrincipal);// limpa da memoria ao fechar
  FreeAndNil(DtmGrafico);
  QryProdutos.Close;
   // Parar e liberar o verificador de estoque
  VerificarEstoque.Parar;
  FreeAndNil(VerificarEstoque);

  // Liberar o formul�rio de notifica��o
  FreeAndNil(frmNotificacao);

  if Assigned(oUsuarioLogado) then
     FreeAndNil(oUsuarioLogado);
end;




procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
// Inicialize a aplica��o CEF
  if not Assigned(GlobalCEFApp) then
  begin
    GlobalCEFApp := TCefApplication.Create;
    GlobalCEFApp.FrameworkDirPath := ExtractFilePath(ParamStr(0)) + 'integracao\';
    GlobalCEFApp.ResourcesDirPath := GlobalCEFApp.FrameworkDirPath;
    GlobalCEFApp.LocalesDirPath := GlobalCEFApp.FrameworkDirPath + 'locales';
    GlobalCEFApp.Cache := ExtractFilePath(ParamStr(0)) + 'cookies';
    GlobalCEFApp.PersistSessionCookies := True;
    GlobalCEFApp.PersistUserPreferences := True;
    GlobalCEFApp.AcceptLanguageList := 'pt-BR';
    //GlobalCEFApp.StartMainProcess;
  if GlobalCEFApp.StartMainProcess then
  begin
    Application.Initialize;
    //Application.MainFormOnTaskbar := True;
  end
  else
  begin
    Application.Terminate;
  end;
  end;

 if not FileExists(TArquivoIni.ArquivoIni) then // se n�o existe o arquivo vendas.ini ele vai criar um com as seguintes configura��es abaixo
 begin
    TArquivoIni.AtualizarIni('SERVER', 'TipoDataBase', 'MYSQL'); // tipo gerenciador de banco de dados
    TArquivoIni.AtualizarIni('SERVER', 'HostName', 'localhost'); // qual o servidor
    TArquivoIni.AtualizarIni('SERVER', 'Port', '3306'); // a porta
    TArquivoIni.AtualizarIni('SERVER', 'User', 'root'); // o usu�rio
    TArquivoIni.AtualizarIni('SERVER', 'Password', ''); // senha
    TArquivoIni.AtualizarIni('SERVER', 'Database', 'vendas'); // e qual banco de dados vai utilizar
    if MessageDlg('Arquivo ' + TArquivoIni.ArquivoIni + ' criado com sucesso' + #13 +
                  'Configure o arquivo antes de inicializar a aplica��o', mtInformation, [mbOK], 0) = mrOk then
    begin
      Application.Terminate;
    end;
 end
 else
 begin

   frmAtualizaDB := TfrmAtualizaDB.Create(Self);
   frmAtualizaDB.Show;
   frmAtualizaDB.Refresh;

   dtmPrincipal := TdtmPrincipal.Create(Self);// o proprio formulario � o dono da conex�o realizada com o banco
       with DtmPrincipal.ConexaoDB do begin
      SQLHourGlass:=True;    //Habilita o Cursor em cada transa��o no banco de dados
      LibraryLocation:=ExtractFilePath(Application.ExeName)+'libmysql.dll';  //Seta a DLL para conexao do SQL
      if TArquivoIni.LerIni('SERVER','TipoDataBase')='MYSQL' then
         Protocol:='mysql';  //Protocolo do banco de dados

      HostName:= TArquivoIni.LerIni('SERVER','HostName'); //Instancia do MYSQLServer
      Port    := StrToInt(TArquivoIni.LerIni('SERVER','Port'));  //Porta do MYSQLServer
      User    := TArquivoIni.LerIni('SERVER','User');  //Usuario do Banco de Dados
      Password:= TArquivoIni.LerIni('SERVER','Password');  //Senha do Usu�rio do banco
      Database:= TArquivoIni.LerIni('SERVER','DataBase');;  //Nome do Banco de Dados
      AutoCommit:= True;
      TransactIsolationLevel:=tiReadCommitted;
      Connected:=True;  //Faz a Conex�o do Banco
    end;
   AtualizacaoBancoDados(frmAtualizaDB);
    // para criar as permiss�es de acesso aos campos de cada tela do sistema
    TAcaoAcesso.CriarAcoes(TfrmCadCategoria,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadCliente,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadProduto,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadUsuario,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadAcaoAcesso,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmAlterarSenha,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmProVenda,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmConsultaOrcamento, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCalculadora, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmEntrada,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelVendaPorData,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadClienteFicha,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadClientes,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadProdutoComGrupoCategoria,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadProduto,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCategoria,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmUsuarioVsAcoes,DtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmConsultarCEP, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmDashboard, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadFornecedor, dtmPrincipal.ConexaoDB);



    TAcaoAcesso.PreencherUsuariosVsAcoes(dtmPrincipal.ConexaoDB);
    frmAtualizaDB.Free;
    TeclaEnter := TMREnter.Create(Self);
    TeclaEnter.FocusEnabled := True;
    TeclaEnter.FocusColor := clInfoBk;



  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
var
  RESTClientQuote, RESTClientTranslate: TRESTClient;
  RESTRequestQuote, RESTRequestTranslate: TRESTRequest;
  RESTResponseQuote, RESTResponseTranslate: TRESTResponse;
  JSONObjQuote, JSONObjTranslate: TJSONObject;
  Frase, Autor, FraseTraduzida: string;
  SwitchState: Boolean;
begin
// tela de login

 try
   oUsuarioLogado := TUsuarioLogado.Create;

   frmLogin := TfrmLogin.Create(Self);
   frmLogin.ShowModal;
 finally
   frmLogin.Release;
    StbPrincipal.Panels[0].Text := 'USU�RIO: ' + oUsuarioLogado.nome;
    QryProdutos.Open;
    ChromiumWindowWhatsapp.Enabled := True;
    ChromiumWindowWhatsapp.Visible := True;
    ChromiumWhatsapp.DefaultURL := 'https://web.whatsapp.com';
    ChromiumWhatsapp.CreateBrowser(ChromiumWindowWhatsapp);

    SwitchState := LoadSwitchState;
    if SwitchState then
    switchDark.State := tssOn
    else
    switchDark.State := tssOff;
    // Aplicar o estado inicial das cores baseado no estado carregado
    switchDarkClick(switchDark);

  // Aplicar o estado inicial das cores baseado no estado carregado
  switchDarkClick(switchDark);

    lkpProdutoSelecionado.KeyValue := 1;
    // Criar o formul�rio de notifica��o
    frmNotificacao := TfrmNotificacao.Create(Application);

    // Criar e iniciar o verificador de estoque
    VerificarEstoque := TVerificarEstoque.Create(DtmPrincipal.ConexaoDB, frmNotificacao, 60000); // Intervalo de 1 minuto (60000 ms)
    VerificarEstoque.Iniciar;
    lblBemVindo.Caption :='Bem vindo(a) '+ oUsuarioLogado.nome +' !';

     // menu primcipal e submenu
     SVSubMenu.UseAnimation := False;
     SVMenu.Close;
     SVSubMenu.Close;
     SVSubMenu.UseAnimation := True;

    RESTClientQuote := TRESTClient.Create(nil);
    RESTRequestQuote := TRESTRequest.Create(nil);
    RESTResponseQuote := TRESTResponse.Create(nil);
    RESTClientTranslate := TRESTClient.Create(nil);
    RESTRequestTranslate := TRESTRequest.Create(nil);
    RESTResponseTranslate := TRESTResponse.Create(nil);
  try
    // Configurar RESTClient para obter a cita��o
    RESTClientQuote.BaseURL := 'https://api.quotable.io';
    RESTRequestQuote.Client := RESTClientQuote;
    RESTRequestQuote.Response := RESTResponseQuote;
    RESTRequestQuote.Resource := 'random';
    RESTRequestQuote.Method := rmGET;
    // Executar solicita��o para obter a cita��o
    RESTRequestQuote.Execute;
    // Processar resposta da cita��o
    if RESTResponseQuote.StatusCode = 200 then
    begin
      JSONObjQuote := TJSONObject.ParseJSONValue(RESTResponseQuote.Content) as TJSONObject;
      try
        Frase := JSONObjQuote.GetValue<string>('content');
        Autor := JSONObjQuote.GetValue<string>('author');
      finally
        JSONObjQuote.Free;
      end;
    end
    else
    begin
      memoPensamento.Lines.Add('Erro ao obter a frase do dia: ' + RESTResponseQuote.Content);
    end;
    // Configurar RESTClient para traduzir a cita��o
    RESTClientTranslate.BaseURL := 'https://api.mymemory.translated.net';
    RESTRequestTranslate.Client := RESTClientTranslate;
    RESTRequestTranslate.Response := RESTResponseTranslate;
    RESTRequestTranslate.Resource := 'get';
    RESTRequestTranslate.Method := rmGET;
    RESTRequestTranslate.AddParameter('q', Frase, pkGETorPOST);
    RESTRequestTranslate.AddParameter('langpair', 'en|pt', pkGETorPOST);
    // Executar solicita��o para traduzir a cita��o
    RESTRequestTranslate.Execute;
    // Processar resposta da tradu��o
    if RESTResponseTranslate.StatusCode = 200 then
    begin
      JSONObjTranslate := TJSONObject.ParseJSONValue(RESTResponseTranslate.Content) as TJSONObject;
      try
        FraseTraduzida := JSONObjTranslate.GetValue<TJSONObject>('responseData').GetValue<string>('translatedText');
      finally
        JSONObjTranslate.Free;
      end;
    end
    else
    begin
      memoPensamento.Lines.Add('Erro ao traduzir a frase: ' + RESTResponseTranslate.Content);
    end;
    // Exibir a frase traduzida no Memo
    memoPensamento.Lines.Add('Frase do Dia: ' + FraseTraduzida + ' - ' + Autor);
  finally
    RESTClientQuote.Free;
    RESTRequestQuote.Free;
    RESTResponseQuote.Free;
    RESTClientTranslate.Free;
    RESTRequestTranslate.Free;
    RESTResponseTranslate.Free;
  end

end;
end;


procedure TfrmPrincipal.lkpProdutoSelecionadoEnter(Sender: TObject);
begin
     QryProdutos.Refresh;
end;

procedure TfrmPrincipal.AtualizacaoBancoDados(aForm:TfrmAtualizaDB);  // caso n�o exista a tabela no db ele cria com essa anima��o
begin
var oAtualizarMYSQL : TAtualizaBancoDadosMYSQL;


try
  oAtualizarMYSQL := TAtualizaBancoDadosMYSQL.Create(dtmPrincipal.ConexaoDB);
  oAtualizarMYSQL.AtualizarBancoDeDadosMYSQL;
finally
   if Assigned(oAtualizarMYSQL) then
      FreeAndNil(oAtualizarMYSQL)
end;

end;



procedure TfrmPrincipal.mnuLateralClick(Sender: TObject); // menu lateral abrir e fechar ele com esse if else
begin
   if SVMenu.Opened then begin
     SVMenu.Close;
     SVSubMenu.Close;
   end else
     SVMenu.Open;

end;

procedure TfrmPrincipal.switchDarkClick(Sender: TObject);
var
  i: Integer;
begin
  SaveSwitchState(switchDark.State = tssOn);

  if switchDark.State = tssoff then
  begin
    for i := 0 to ComponentCount - 1 do
    begin
      if pnlTopMenu is TPanel then
      begin
        pnlTopMenu.Color := clTeal;
        SVMenu.Color := clTeal;
        SVSubMenu.Color := clTeal;
        memoPensamento.Color := clWhite;
        memoPensamento.Font.Color := clBlack;
        pnlbody.Color := clWhite;
        lblExtrato.Font.Color := clBlack;
        lblProduto.Font.Color := clBlack;
        lblFoto.Font.Color := clBlack;
        lblDescricao.Font.Color := clBlack;
        lblQuantidade.Font.Color := clBlack;
        lblValor.Font.Color := clBlack;
      end;
    end;
  end
  else
  begin
    if pnlTopMenu is TPanel then
    begin
      pnlTopMenu.Color := $001E1E1E;
      SVMenu.Color := $001E1E1E;
      SVSubMenu.Color := $001E1E1E;
      memoPensamento.Color := $00616161;
      memoPensamento.Font.Color := clWhite;
      pnlbody.Color := $00616161;
      lblExtrato.Font.Color := clWhite;
      lblProduto.Font.Color := clWhite;
      lblFoto.Font.Color := clWhite;
      lblDescricao.Font.Color := clWhite;
      lblQuantidade.Font.Color := clWhite;
      lblValor.Font.Color := clWhite;
    end;
  end;
end;


procedure TfrmPrincipal.closeSubMenu(Sender: TObject);// anima��o submenu
begin
  CategoryButtonsCadastro.Visible     := False;
  CategoryButtonsMovimentacao.Visible := False;
  CategoryButtonsRelatorios.Visible   := False;
  CategoryButtonsPermissoes.Visible   := False;
  CategoryButtonsCadastro.Enabled     := False;
  CategoryButtonsMovimentacao.Enabled := False;
  CategoryButtonsRelatorios.Enabled   := False;
  CategoryButtonsPermissoes.Enabled   := False;
  if TSplitView(Sender).Opened then
     TSplitView(Sender).Close
  else
     TSplitView(Sender).Open;
end;


procedure TfrmPrincipal.SaveSwitchState(AState: Boolean);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'vendas.ini');
  try
    Ini.WriteBool('Settings', 'SwitchState', AState);
  finally
    Ini.Free;
  end;
end;
function TfrmPrincipal.LoadSwitchState: Boolean;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'vendas.ini');
  try
    Result := Ini.ReadBool('Settings', 'SwitchState', False);
  finally
    Ini.Free;
  end;
end;


end.

