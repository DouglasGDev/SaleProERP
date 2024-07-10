unit uDashboard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, VclTee.TeeGDIPlus,
  Data.DB, VCLTee.Series, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.DBChart, uDTMGrafico;

type
  TfrmDashboard = class(TForm)
    pnlHeader: TPanel;
    pnlFooter: TPanel;
    pnlBody: TPanel;
    grdPnlGraficos: TGridPanel;
    DBCProdutoEstoque: TDBChart;
    Series1: TBarSeries;
    DBCValorVendaCliente: TDBChart;
    Series2: TPieSeries;
    DBCTop10ProdutosMaisVendidos: TDBChart;
    PieSeries1: TPieSeries;
    DBChart1: TDBChart;
    Series3: TFastLineSeries;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    procedure IniciarDashBoardEstoque;
    procedure FinalizarDashBoardEstoque;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDashboard: TfrmDashboard;

implementation

{$R *.dfm}

procedure TfrmDashboard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     FinalizarDashBoardEstoque;
     if Assigned(DtmGrafico) then
     FreeAndNil(DtmGrafico);
     Close;
end;

procedure TfrmDashboard.FormCreate(Sender: TObject);
begin
    DtmGrafico := TDtmGrafico.Create(Self);
    IniciarDashBoardEstoque;
end;

procedure TfrmDashboard.IniciarDashBoardEstoque;
begin
  DtmGrafico.QryProdutoEstoque.Open;
  DtmGrafico.QryValorVendaPorCliente.Open;
  DtmGrafico.QryTopProdutosMaisVendidos.Open;
  DtmGrafico.QryVendasUltimaSemana.Open;
end;

procedure TfrmDashboard.FinalizarDashBoardEstoque;
begin
  DtmGrafico.QryProdutoEstoque.Close;
  DtmGrafico.QryValorVendaPorCliente.Close;
  DtmGrafico.QryTopProdutosMaisVendidos.Close;
  DtmGrafico.QryVendasUltimaSemana.Close;
end;

end.
