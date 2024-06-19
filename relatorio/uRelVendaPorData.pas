unit uRelVendaPorData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, uDTMConexao, RLReport, RLFilters, RLPDFFilter,
  RLRichText, RLPreviewForm, RLXLSXFilter, RLHTMLFilter, RLXLSFilter;

type
  TfrmRelVendaPorData = class(TForm)
    QryVenda: TZQuery;
    dtsVenda: TDataSource;
    Relatorio: TRLReport;
    Cabecalho: TRLBand;
    RLLabel1: TRLLabel;
    RLDraw1: TRLDraw;
    Rodape: TRLBand;
    RLDraw2: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLPDFFilter1: TRLPDFFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    RLHTMLFilter1: TRLHTMLFilter;
    BandaDoGrupo: TRLGroup;
    RLBand3: TRLBand;
    RLBand2: TRLBand;
    RLBand1: TRLBand;
    RLDBText6: TRLDBText;
    RLLabel6: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLBand4: TRLBand;
    rllblDataInicio: TRLLabel;
    rllblDataFim: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLDBText3: TRLDBText;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLDBResultPix: TRLDBResult;
    RLLabel16: TRLLabel;
    RLDBResultCredito: TRLDBResult;
    RLLabel17: TRLLabel;
    RLDBResultDebito: TRLDBResult;
    RLDBResultDinheiro: TRLDBResult;
    RLLabel18: TRLLabel;
    QryVendavendaId: TZIntegerField;
    QryVendaclienteId: TZIntegerField;
    QryVendanome: TZUnicodeStringField;
    QryVendaprodutoId: TZIntegerField;
    QryVendanome_1: TZUnicodeStringField;
    QryVendavalorUnitario: TZFMTBCDField;
    QryVendaquantidade: TZFMTBCDField;
    QryVendatotalProduto: TZFMTBCDField;
    QryVendaTotalVenda: TZDoubleField;
    QryVendadataVenda: TZDateTimeField;
    QryVendaPPIX: TZDoubleField;
    QryVendaCCREDITO: TZDoubleField;
    QryVendaDDEBITO: TZDoubleField;
    QryVendaDDINHEIRO: TZDoubleField;
    RLLabel13: TRLLabel;
    RLDBText5: TRLDBText;
    RLLabel19: TRLLabel;
    RLDBText7: TRLDBText;
    RLLabel20: TRLLabel;
    RLDBText8: TRLDBText;
    RLLabel21: TRLLabel;
    RLDBText9: TRLDBText;
    RLLabel22: TRLLabel;
    RLDBText10: TRLDBText;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLLabel7: TRLLabel;
    RLDBText4: TRLDBText;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelVendaPorData: TfrmRelVendaPorData;

implementation

{$R *.dfm}



procedure TfrmRelVendaPorData.FormDestroy(Sender: TObject);
begin
   QryVenda.Close;
end;

end.
