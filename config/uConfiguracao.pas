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
    edtTamanhoFonte: TNumberBox;
    edtFont: TFontComboBox;
    lblTipoFonte: TLabel;
    btnSalvarConfiguracao: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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

procedure TfrmConfiguracao.btnFecharClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmConfiguracao.FormShow(Sender: TObject);
var
SwitchState: Boolean;
begin
     SwitchState := LoadSwitchState;
    if SwitchState.ToInteger = 0 then
    begin
        pnlHeader.Color := clTeal;
        //pnlListagemTopo.Color := clTeal;
        pnlFooter.Color := clTeal;
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