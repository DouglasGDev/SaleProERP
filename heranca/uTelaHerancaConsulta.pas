unit uTelaHerancaConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Data.DB, Vcl.Grids, Vcl.DBGrids, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Vcl.Buttons, IniFiles;

type
  TfrmTelaHerancaConsulta = class(TForm)
    pnlHeader: TPanel;
    pnlFooter: TPanel;
    pnlBody: TPanel;
    mskPesquisa: TMaskEdit;
    lblIndice: TLabel;
    grdPesquisa: TDBGrid;
    QryListagem: TZQuery;
    dtsListagem: TDataSource;
    btnFechar: TBitBtn;
    lblTitulo: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdPesquisaTitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure grdPesquisaDblClick(Sender: TObject);
    procedure mskPesquisaChange(Sender: TObject);
  private
    function RetornarCampoTraduzido(Campo: string): string;
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);
    function LoadSwitchState: Boolean;
    { Private declarations }
  public
    { Public declarations }
    aRetornarIdSelecionado:Variant;
    aIniciarPesquisaId:Variant;
    aCampoId:String;
    IndiceAtual:String;
    aPrimarioId : string;
  end;

var
  frmTelaHerancaConsulta: TfrmTelaHerancaConsulta;

implementation

{$R *.dfm}


procedure TfrmTelaHerancaConsulta.btnFecharClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmTelaHerancaConsulta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   if QryListagem.Active then
      QryListagem.Close;
end;

procedure TfrmTelaHerancaConsulta.FormCreate(Sender: TObject);
begin
   if QryListagem.Active then
      QryListagem.Close;
      ExibirLabelIndice(IndiceAtual, lblIndice);
      QryListagem.IndexFieldNames:=IndiceAtual;
      QryListagem.Open;
end;

procedure TfrmTelaHerancaConsulta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  // bloqueia o ctrl+del
begin
     if (Shift = [ssCtrl]) and (Key = 46) then
     Key := 0;

end;

procedure TfrmTelaHerancaConsulta.FormShow(Sender: TObject);
var
SwitchState : Boolean;
begin
if (aIniciarPesquisaId<>Unassigned) then
  begin
    QryListagem.Locate(aCampoId, aIniciarPesquisaId,[loPartialKey])
  end;

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
end;

procedure TfrmTelaHerancaConsulta.grdPesquisaDblClick(Sender: TObject);
begin
  aRetornarIdSelecionado := QryListagem.FieldByName(aCampoId).AsVariant;// quando der 2 cliques no aquivo selecionado do grid ele vai fechar e retornar o id daquele campo selecionado e por ser variant, recebe qualquer tipo de dado
  Close;
end;


procedure TfrmTelaHerancaConsulta.grdPesquisaTitleClick(Column: TColumn);
begin
  IndiceAtual                :=Column.FieldName;// aqui a coluna que der um clique passa o nome para o indice da pesquisa na tela
  QryListagem.IndexFieldNames:=IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;

procedure TfrmTelaHerancaConsulta.mskPesquisaChange(Sender: TObject);
begin
    QryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text,[loPartialKey]) // a cada string digitada ele vai pesquisar a rela��o com aquela string
end;

procedure TfrmTelaHerancaConsulta.ExibirLabelIndice(Campo: string; aLabel:TLabel);
begin
  aLabel.Caption:=RetornarCampoTraduzido(Campo);
end;

function TfrmTelaHerancaConsulta.RetornarCampoTraduzido(Campo: string):string; // � para retornar o indice traduzido na tela encima do pesquisar
var i:Integer;
begin
  for I := 0 to QryListagem.FieldCount-1 do begin
    if LowerCase(QryListagem.Fields[i].FieldName) = LowerCase(Campo) then begin
       Result:=QryListagem.Fields[i].DisplayLabel;
       Break;
    end;
  end;
end;

function TfrmTelaHerancaConsulta.LoadSwitchState: Boolean;
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
