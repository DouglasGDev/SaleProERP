unit uCadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  cCadUsuario, uEnum, uDTMConexao, cAcaoAcesso;

type
  TfrmCadUsuario = class(TfrmTelaHeranca)
    QryListagemusuarioId: TZIntegerField;
    QryListagemnome: TZUnicodeStringField;
    QryListagemsenha: TZUnicodeStringField;
    edtUsuarioId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtSenha: TLabeledEdit;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    oUsuario : TUsuario;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadUsuario: TfrmCadUsuario;

implementation

{$R *.dfm}


{ TfrmCadUsuario }

function TfrmCadUsuario.Apagar: Boolean;
begin
    if oUsuario.Selecionar(QryListagem.FieldByName('usuarioId').AsInteger) then begin // aqui quando seleciona no grid o usuario e manda apagar
      Result := oUsuario.Apagar;
    end;

end;



procedure TfrmCadUsuario.btnAlterarClick(Sender: TObject);
begin
  if oUsuario.Selecionar(QryListagem.FieldByName('usuarioId').AsInteger) then begin// ao selecionar ele pega do db e alimenta cada campo da aba manuten��o
    edtUsuarioId.Text :=IntToStr(oUsuario.codigo);
    edtNome.Text      := oUsuario.nome;
    edtSenha.Text     := oUsuario.senha;
  end
  else begin
    btnCancelar.Click;// se n�o encontrar o registro automaticamente cancela e aborta a opera��o
    Abort;
  end;
  inherited;

end;

procedure TfrmCadUsuario.btnGravarClick(Sender: TObject);
begin
  if oUsuario.UsuarioExiste(edtNome.Text) then begin
    MessageDlg('Usu�rio j� cadastrado', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    edtNome.SetFocus;
    Abort;
  end;

  if edtUsuarioId.Text<>EmptyStr then // se o campo do id for diferente de vazio
         oUsuario.codigo:=StrToInt(edtUsuarioId.Text)// atribui pro campo c�digo o texto convertido em numero inteiro
  else
     oUsuario.codigo:=0;
     oUsuario.nome:= edtNome.Text;
     oUsuario.senha:= edtSenha.Text;
  inherited;

end;

procedure TfrmCadUsuario.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;

procedure TfrmCadUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oUsuario) then
     FreeAndNil(oUsuario);

end;

procedure TfrmCadUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  oUsuario := TUsuario.Create(DtmPrincipal.ConexaoDB);
  IndiceAtual := 'nome';
end;

function TfrmCadUsuario.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
    if EstadoDoCadastro = ecInserir then
       Result := oUsuario.Inserir
    else if
       EstadoDoCadastro = ecAlterar then
       Result := oUsuario.Atualizar;

       TAcaoAcesso.PreencherUsuariosVsAcoes(dtmPrincipal.ConexaoDB);// pra criar automatico a atualiza��o no banco de dados, para puxar os acessos na tabela
end;

end.
