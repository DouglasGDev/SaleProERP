unit uConfiguracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Inifiles,
  RxSpin, Vcl.NumberBox, RxCombos;

type
  TfrmConfiguracao = class(TForm)
    pnlHeader: TPanel;
    pnlFooter: TPanel;
    pnlBody: TPanel;
    lblCorPrincipal: TLabel;
    ColorBoxPrincipal: TColorBox;
    btnFechar: TBitBtn;
    btnPadrao: TBitBtn;
    lblTempoNotificacao: TLabel;
    edtTempoNotificacao: TRxTimeEdit;
    lblTamanhoFonte: TLabel;
    edtFont: TFontComboBox;
    lblTipoFonte: TLabel;
    btnSalvarConfiguracao: TBitBtn;
    ColorBoxFonte: TColorBox;
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPadraoClick(Sender: TObject);
    procedure btnSalvarConfiguracaoClick(Sender: TObject);
  private
    function LoadSwitchState: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfiguracao: TfrmConfiguracao;

implementation

{$R *.dfm}

uses UPrincipal;



procedure TfrmConfiguracao.btnFecharClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmConfiguracao.btnPadraoClick(Sender: TObject);
begin
     ColorBoxPrincipal.Selected := clTeal;
     ColorBoxFonte.Selected := clWhite;
     edtTempoNotificacao.Hours := 0;
     edtTempoNotificacao.Minutes := 1;
     edtTempoNotificacao.Seconds := 0;
     edtFont.FontName := 'Segoe UI';
end;

procedure TfrmConfiguracao.btnSalvarConfiguracaoClick(Sender: TObject);
var
SwitchState: Boolean;
corPrincipal : TColor;
CorFonte : TColor;
TempoHora : Integer;
TempoMinuto : Integer;
TempoSegundo : Integer;
Fonte : String;
Ini: TIniFile;
FilePath: string;
begin
     corPrincipal := ColorBoxPrincipal.Selected;
     CorFonte := ColorBoxFonte.Selected;
     TempoHora := edtTempoNotificacao.Hours;
     TempoMinuto := edtTempoNotificacao.Minutes;
     TempoSegundo := edtTempoNotificacao.Seconds;
     Fonte := edtFont.FontName;
// Define o caminho do arquivo INI
  FilePath := ExtractFilePath(ParamStr(0)) + 'vendas.ini';
  // Cria a inst�ncia de TIniFile
  Ini := TIniFile.Create(FilePath);
  try
    // Salva os valores no arquivo INI
    Ini.WriteString('Configuracoes', 'CorPrincipal', ColorToString(corPrincipal));
    Ini.WriteString('Configuracoes', 'CorFonte', ColorToString(CorFonte));
    Ini.WriteInteger('Configuracoes', 'TempoHora', TempoHora);
    Ini.WriteInteger('Configuracoes', 'TempoMinuto', TempoMinuto);
    Ini.WriteInteger('Configuracoes', 'TempoSegundo', TempoSegundo);
    Ini.WriteString('Configuracoes', 'Fonte', Fonte);
  finally
    // Libera a inst�ncia de TIniFile
    Ini.Free;
  end;
  // Exibe uma mensagem de confirma��o
  MessageDlg('Configura��es salvas com sucesso!', mtInformation, [mbOK], 0);
  frmPrincipal.switchDarkClick(Self);
  frmPrincipal.switchDarkClick(Self);

     SwitchState := LoadSwitchState;
    if SwitchState.ToInteger = 0 then
    begin
        pnlHeader.Color := corPrincipal;
        pnlFooter.Color := corPrincipal;
    end
        else if SwitchState.ToInteger = 1 then
    begin
        pnlHeader.Color := $001E1E1E;
        pnlFooter.Color :=$001E1E1E;
    end;

end;

procedure TfrmConfiguracao.FormShow(Sender: TObject);
var
SwitchState: Boolean;
  Ini: TIniFile;
  FilePath: string;
  corPrincipal: TColor;
  CorFonte : TColor;
  TempoHora : Integer;
  TempoMinuto : Integer;
  TempoSegundo : Integer;
  Fonte : String;
begin

// Define o caminho do arquivo INI
  FilePath := ExtractFilePath(ParamStr(0)) + 'vendas.ini';
  // Cria a inst�ncia de TIniFile
  Ini := TIniFile.Create(FilePath);
  try
    // L� os valores do arquivo INI
    corPrincipal := StringToColor(Ini.ReadString('Configuracoes', 'CorPrincipal', ''));
    CorFonte := StringToColor(Ini.ReadString('Configuracoes', 'CorFonte', ''));
    TempoHora := StrToInt(Ini.ReadString('Configuracoes', 'TempoHora', ''));
    TempoMinuto := StrToInt(Ini.ReadString('Configuracoes', 'TempoMinuto', ''));
    TempoSegundo := StrToInt(Ini.ReadString('Configuracoes', 'TempoSegundo', ''));
    Fonte := Ini.ReadString('Configuracoes', 'Fonte', '');
  finally
    // Libera a inst�ncia de TIniFile
    Ini.Free;
  end;

     ColorBoxPrincipal.Selected :=  corPrincipal;
     ColorBoxFonte.Selected  :=  CorFonte;
     edtTempoNotificacao.Hours := TempoHora;
     edtTempoNotificacao.Minutes := TempoMinuto;
     edtTempoNotificacao.Seconds := TempoSegundo ;
     edtFont.FontName := Fonte;

     SwitchState := LoadSwitchState;
    if SwitchState.ToInteger = 0 then
    begin
        pnlHeader.Color := corPrincipal;
        //pnlListagemTopo.Color := clTeal;
        pnlFooter.Color := corPrincipal;
    end
    else if SwitchState.ToInteger = 1 then
    begin
        pnlHeader.Color := $001E1E1E;
        //pnlListagemTopo.Color := $001E1E1E;
        pnlFooter.Color :=$001E1E1E;
    end;

end;

function TfrmConfiguracao.LoadSwitchState: Boolean;
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
