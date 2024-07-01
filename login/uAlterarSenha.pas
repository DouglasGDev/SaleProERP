unit uAlterarSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, IniFiles;

type
  TfrmAlterarSenha = class(TForm)
    pnlHeader: TPanel;
    pnlFooter: TPanel;
    pnlBody: TPanel;
    lblTituloAlterarSenha: TLabel;
    edtSenhaAtual: TEdit;
    edtSenhaNova: TEdit;
    edtRepetirNovaSenha: TEdit;
    Panel5: TPanel;
    btnAlterar: TSpeedButton;
    Panel1: TPanel;
    btnFechar: TSpeedButton;
    lblSenhaAtual: TLabel;
    lblNovaSenha: TLabel;
    lblRepetirNovaSenha: TLabel;
    lblUsuarioLogado: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    procedure LimparEdits;
    function LoadSwitchState: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlterarSenha: TfrmAlterarSenha;

implementation

{$R *.dfm}

uses cCadUsuario, uDTMConexao, UPrincipal;

procedure TfrmAlterarSenha.btnAlterarClick(Sender: TObject);
var oUsuario:TUsuario;
begin

 if (edtSenhaAtual.Text=oUsuarioLogado.senha) then begin
    if (edtSenhaNova.Text=edtRepetirNovaSenha.Text) then begin
      try
        oUsuario:=TUsuario.Create(DtmPrincipal.ConexaoDB);
        oUsuario.codigo := oUsuarioLogado.codigo;
        oUsuario.senha  := edtSenhaNova.Text;
        oUsuario.AlterarSenha;
        oUsuarioLogado.senha := edtSenhaNova.Text;
        MessageDlg('Senha Alterada',MtInformation,[mbok],0);
        LimparEdits;
      finally
        FreeAndNil(oUsuario);
      end;
    end
    else begin
      MessageDlg('Senhas digitadas n�o coincidem,',mtinformation,[mbok],0);
      edtSenhaNova.SetFocus;
    end;

  end
  else begin
    MessageDlg('Senha Atual est� inv�lida',mtinformation,[mbok],0);
  end;
end;

procedure TfrmAlterarSenha.btnFecharClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmAlterarSenha.FormShow(Sender: TObject);
var
SwitchState : Boolean;
begin
  SwitchState := LoadSwitchState;
    if SwitchState.ToInteger = 0 then
    begin
        pnlHeader.Color := clTeal;
        pnlFooter.Color := clTeal;
    end
    else if SwitchState.ToInteger = 1 then
    begin
        pnlHeader.Color := $001E1E1E;
        pnlFooter.Color := $001E1E1E;
    end;
  LimparEdits;
end;

procedure TfrmAlterarSenha.LimparEdits;
begin
  edtSenhaAtual.Clear;
  edtSenhaNova.Clear;
  edtRepetirNovaSenha.Clear;
  lblUsuarioLogado.Caption := oUsuarioLogado.nome;
end;

function TfrmAlterarSenha.LoadSwitchState: Boolean;
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
