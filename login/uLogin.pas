unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage, ZConnection, ZDataset;

type
  TfrmLogin = class(TForm)
    pnlFundo: TPanel;
    pnlLateral: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image1: TImage;
    lblTitulo: TLabel;
    lblSolicitacao: TLabel;
    pnlUsuario: TPanel;
    lblUsuario: TLabel;
    edtUsuario: TEdit;
    pnlSenha: TPanel;
    lblSenha: TLabel;
    edtSenha: TEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    pnlEntrar: TPanel;
    btnEntrar: TSpeedButton;
    pnlFechar: TPanel;
    lblFechar: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnAcessarClick(Sender: TObject);
    procedure btnEntrarClick(Sender: TObject);
    procedure lblFecharClick(Sender: TObject);
  private
    { Private declarations }
    bFechar: Boolean;
    procedure FecharAplicacao;
    procedure FecharFormulario;
    procedure ConfigurarUsuarioLogado(const aUserName: string; aConexao: TZConnection);
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses UPrincipal, cCadUsuario, uDTMConexao;

procedure TfrmLogin.btnAcessarClick(Sender: TObject);
var
  oUsuario: TUsuario;
begin
  try
    oUsuario := TUsuario.Create(dtmPrincipal.ConexaoDB); // objeto do usuario conexao
    if oUsuario.Logar(edtUsuario.Text, edtSenha.Text) then
    begin
      FecharFormulario; // fecha o formulario do login
    end
    else
    begin
      MessageDlg('Usuário ou senha inválidos.', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
      edtUsuario.SetFocus;
    end;
  finally
    if Assigned(oUsuario) then
      FreeAndNil(oUsuario);
  end;
end;

procedure TfrmLogin.FecharAplicacao;
begin
  bFechar := True;
  Application.Terminate;
end;

procedure TfrmLogin.FecharFormulario;
begin
  bFechar := True;
  Close;
end;

procedure TfrmLogin.btnFecharClick(Sender: TObject);
begin
  FecharAplicacao; // fecha a aplicação
end;

procedure TfrmLogin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := bFechar;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  bFechar := False;
end;

procedure TfrmLogin.lblFecharClick(Sender: TObject);
begin
  FecharAplicacao; // fecha a aplicação
end;

procedure TfrmLogin.ConfigurarUsuarioLogado(const aUserName: string; aConexao: TZConnection);
var
  Qry: TZQuery;
begin
  Qry := TZQuery.Create(nil);
  try
    Qry.Connection := aConexao;
    Qry.SQL.Text := 'SET @logged_in_user = :UserName';
    Qry.ParamByName('UserName').AsString := aUserName;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
var
  oUsuario: TUsuario;
begin
  try
    oUsuario := TUsuario.Create(dtmPrincipal.ConexaoDB); // objeto do usuario conexao
    if oUsuario.Logar(edtUsuario.Text, edtSenha.Text) then
    begin
      oUsuarioLogado.codigo := oUsuario.codigo; // pra possuir as informações de qual usuário está logado
      oUsuarioLogado.nome := oUsuario.nome;
      oUsuarioLogado.senha := oUsuario.senha;

      // Configure a variável de sessão no banco de dados
      ConfigurarUsuarioLogado(oUsuarioLogado.nome, dtmPrincipal.ConexaoDB);

      FecharFormulario; // fecha o formulario do login
    end
    else
    begin
      MessageDlg('Usuário ou senha inválidos.', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
      edtUsuario.SetFocus;
    end;
  finally
    if Assigned(oUsuario) then
      FreeAndNil(oUsuario);
  end;
end;

end.

