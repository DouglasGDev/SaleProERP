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
    QryListagemprodutoId: TZIntegerField;
    QryListagemnome: TZUnicodeStringField;
    QryListagemdescricao: TZUnicodeStringField;
    QryListagemvalor: TZFMTBCDField;
    QryListagemcodbarras: TZUnicodeStringField;
    QryListagemfoto: TZBlobField;
    QryListagemquantidade: TZFMTBCDField;
    Label3: TLabel;
    edtCodBarras: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaExtratoProduto: TfrmConsultaExtratoProduto;

implementation

{$R *.dfm}

procedure TfrmConsultaExtratoProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
    QryListagem.Close;

end;

procedure TfrmConsultaExtratoProduto.FormCreate(Sender: TObject);
begin
  inherited;
     IndiceAtual := 'nome';
end;

procedure TfrmConsultaExtratoProduto.FormShow(Sender: TObject);
begin
  inherited;
   QryListagem.Open;
end;

end.