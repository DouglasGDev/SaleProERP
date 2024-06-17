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
  uCEFWinControl, uCEFLinkedWinControlBase, uCEFChromiumWindow, uCEFApplication;
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
    grdPnlGraficos: TGridPanel;
    DBCProdutoEstoque: TDBChart;
    Series1: TBarSeries;
    DBCValorVendaCliente: TDBChart;
    Series2: TPieSeries;
    DBCTop10ProdutosMaisVendidos: TDBChart;
    PieSeries1: TPieSeries;
    DBChart1: TDBChart;
    Series3: TFastLineSeries;
    CategoryButtonsPermissoes: TCategoryButtons;
    ChromiumWindowWhatsapp: TChromiumWindow;
    ChromiumWhatsapp: TChromium;
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
  private
    { Private declarations }
     TeclaEnter : TMREnter;
    VerificarEstoque : TVerificarEstoque;
    procedure AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
    procedure closeSubMenu(Sender: TObject);
    procedure IniciarDashBoardEstoque;
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



procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(TeclaEnter);// limpa da memoria ao fechar
  FreeAndNil(dtmPrincipal);// limpa da memoria ao fechar
  FreeAndNil(DtmGrafico);
  FreeAndNil(GlobalCEFApp);

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
    //TAcaoAcesso.CriarAcoes(TfrmWhatsapp, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadFornecedor, dtmPrincipal.ConexaoDB);



    TAcaoAcesso.PreencherUsuariosVsAcoes(dtmPrincipal.ConexaoDB);
    DtmGrafico := TDtmGrafico.Create(Self);
    IniciarDashBoardEstoque;
    frmAtualizaDB.Free;
    TeclaEnter := TMREnter.Create(Self);
    TeclaEnter.FocusEnabled := True;
    TeclaEnter.FocusColor := clInfoBk;

  end;
end;


procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
// tela de login

 try
   oUsuarioLogado := TUsuarioLogado.Create;

   frmLogin := TfrmLogin.Create(Self);
   frmLogin.ShowModal;
 finally
   frmLogin.Release;
    StbPrincipal.Panels[0].Text := 'USU�RIO: ' + oUsuarioLogado.nome;

    ChromiumWindowWhatsapp.Enabled := True;
    ChromiumWindowWhatsapp.Visible := True;
    ChromiumWhatsapp.DefaultURL := 'https://web.whatsapp.com';
    ChromiumWhatsapp.CreateBrowser(ChromiumWindowWhatsapp);

    // Criar o formul�rio de notifica��o
    frmNotificacao := TfrmNotificacao.Create(Application);

    // Criar e iniciar o verificador de estoque
    VerificarEstoque := TVerificarEstoque.Create(DtmPrincipal.ConexaoDB, frmNotificacao, 60000); // Intervalo de 1 minuto (60000 ms)
    VerificarEstoque.Iniciar;
 end;

 lblBemVindo.Caption :='Bem vindo(a) '+ oUsuarioLogado.nome +' !';

 // menu primcipal e submenu
 SVSubMenu.UseAnimation := False;
 SVMenu.Close;
 SVSubMenu.Close;
 SVSubMenu.UseAnimation := True;
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

procedure TfrmPrincipal.IniciarDashBoardEstoque;
begin
  DtmGrafico.QryProdutoEstoque.Open;
  DtmGrafico.QryValorVendaPorCliente.Open;
  DtmGrafico.QryTopProdutosMaisVendidos.Open;
  DtmGrafico.QryVendasUltimaSemana.Open;
end;


end.
