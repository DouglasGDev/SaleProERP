unit uDTMGrafico;

interface

uses
  System.SysUtils, System.Classes, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, uDTMConexao;

type
  TDtmGrafico = class(TDataModule)
    QryProdutoEstoque: TZQuery;
    QryProdutoEstoqueLabel: TZUnicodeStringField;
    QryProdutoEstoqueValue: TZFMTBCDField;
    QryValorVendaPorCliente: TZQuery;
    QryValorVendaPorClienteLabel: TZUnicodeStringField;
    QryValorVendaPorClienteValue: TZFMTBCDField;
    QryTopProdutosMaisVendidos: TZQuery;
    QryTopProdutosMaisVendidosLabel: TZUnicodeStringField;
    QryTopProdutosMaisVendidosValue: TZFMTBCDField;
    QryVendasUltimaSemana: TZQuery;
    QryVendasUltimaSemanaLabel: TZDateField;
    QryVendasUltimaSemanaValue: TZFMTBCDField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DtmGrafico: TDtmGrafico;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
