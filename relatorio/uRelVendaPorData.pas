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
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText6: TRLDBText;
    RLLabel6: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel7: TRLLabel;
    RLBand4: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDraw3: TRLDraw;
    RLLabel10: TRLLabel;
    RLBand5: TRLBand;
    RLLabel8: TRLLabel;
    RLDBResult2: TRLDBResult;
    RLDraw4: TRLDraw;
    QryVendavendaId: TZIntegerField;
    QryVendaclienteId: TZIntegerField;
    QryVendanome: TZUnicodeStringField;
    QryVendadataVenda: TZDateTimeField;
    QryVendaTotalVenda: TZDoubleField;
    rllblDataInicio: TRLLabel;
    rllblDataFim: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLDBText3: TRLDBText;
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
