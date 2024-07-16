unit uConsultaExtratoProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmConsultaExtratoProduto = class(TfrmTelaHeranca)
    dmImageProduto: TDBImage;
    lblFoto: TLabel;
    lblDescricao: TLabel;
    dbMemoDescricaoProduto: TDBMemo;
    lblQuantidade: TLabel;
    dbedtQuantidade: TDBEdit;
    lblValor: TLabel;
    dbedtValor: TDBEdit;
    Label1: TLabel;
    edtCodProduto: TDBEdit;
    Label2: TLabel;
    edtNome: TDBEdit;
    Label3: TLabel;
    edtCodBarras: TDBEdit;
    dtsFilial: TDataSource;
    QryFilial: TZQuery;
    QryFilialfilialId: TZIntegerField;
    QryFilialnumfilial: TZIntegerField;
    QryFilialfantasia: TZUnicodeStringField;
    QryFilialcnpj: TZUnicodeStringField;
    lblFilial: TLabel;
    lkpFilial: TDBLookupComboBox;
    QryListagemprodutoId: TZIntegerField;
    QryListagemnome: TZUnicodeStringField;
    QryListagemdescricao: TZUnicodeStringField;
    QryListagemvalor: TZFMTBCDField;
    QryListagemcodbarras: TZUnicodeStringField;
    QryListagemfoto: TZBlobField;
    QryListagemquantidade: TZFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lkpFilialExit(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
    var
    lkpFilial_old : Integer;
  end;

var
  frmConsultaExtratoProduto: TfrmConsultaExtratoProduto;


implementation



{$R *.dfm}

procedure TfrmConsultaExtratoProduto.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if not VarIsNull(lkpFilial.KeyValue) then
  lkpFilial_old := lkpFilial.KeyValue;
  lkpFilial.KeyValue := lkpFilial_old
end;

procedure TfrmConsultaExtratoProduto.btnPesquisarClick(Sender: TObject);
var
  QryListagem_old: TStringList;
begin
  QryListagem_old := TStringList.Create;
  lkpFilial_old :=  lkpFilial.KeyValue;
  try
    QryListagem_old.Text := QryListagem.SQL.Text;

    if Trim(mskPesquisar.Text) <> '' then
    begin
      QryListagem.Close;
      QryListagem.SQL.Clear;
      QryListagem.SQL.Add('SELECT produtoId, nome, descricao, valor, codbarras, foto, quantidade FROM produtos WHERE filialId = :filialId AND ' + lblIndice.Caption + ' = :Pesquisa');
      QryListagem.Params.ParamByName('filialId').AsInteger := lkpFilial.KeyValue;
      QryListagem.Params.ParamByName('Pesquisa').AsString := Trim(mskPesquisar.Text);
      QryListagem.Open;
      mskPesquisar.Clear;
    end
    else if Trim(mskPesquisar.Text) = '' then
    begin
      lkpFilial_old :=  lkpFilial.KeyValue;
      QryListagem.Close;
      QryListagem.SQL.Text := QryListagem_old.Text;
      QryListagem.Params.ParamByName('filialId').AsInteger := lkpFilial.KeyValue;
      QryListagem.Open;
    end;
  finally
    QryListagem_old.Free;
  end;
  if QryListagem.IsEmpty then
  begin
    btnAlterar.Enabled := false;
  end
  else
    btnAlterar.Enabled := True;

    mskPesquisar.Clear;

end;


procedure TfrmConsultaExtratoProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
    QryListagem.Close;
    QryFilial.Close;
end;

procedure TfrmConsultaExtratoProduto.FormCreate(Sender: TObject);
begin
  inherited;
     IndiceAtual := 'nome';
end;

procedure TfrmConsultaExtratoProduto.FormShow(Sender: TObject);
begin
  inherited;
  QryFilial.Open;
  lkpFilial.KeyValue := poFirst;
  // Verifique se o valor de KeyValue � nulo antes de us�-lo
  if not VarIsNull(lkpFilial.KeyValue) then
  begin
    QryListagem.Close;
    QryListagem.Params.ParamByName('filialId').AsInteger := lkpFilial.KeyValue;
    QryListagem.Open;
  end;
end;


procedure TfrmConsultaExtratoProduto.lkpFilialExit(Sender: TObject);
begin
  inherited;
    QryListagem.Close;
    QryListagem.Params.ParamByName('filialId').AsInteger := lkpFilial.KeyValue;
    QryListagem.Open;
end;


end.
