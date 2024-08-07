unit uRelOrcamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, uDTMConexao, RLReport, RLFilters, RLPDFFilter,
  RLRichText, RLPreviewForm, RLXLSXFilter, RLHTMLFilter, RLXLSFilter;

type
  TfrmRelOrcamento = class(TForm)
    QryOrcamento: TZQuery;
    dtsOrcamento: TDataSource;
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
    RLBand1: TRLBand;
    RLDBText2: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText6: TRLDBText;
    RLBand5: TRLBand;
    RLLabel8: TRLLabel;
    RLDBResult2: TRLDBResult;
    RLDraw4: TRLDraw;
    QryOrcamentoItens: TZQuery;
    dtsOrcamentoItens: TDataSource;
    RLLabel9: TRLLabel;
    RLLabel7: TRLLabel;
    RLDBText1: TRLDBText;
    RLSubDetail1: TRLSubDetail;
    RLBand2: TRLBand;
    RLLabel5: TRLLabel;
    RLBand4: TRLBand;
    RLDBText3: TRLDBText;
    RLLabel10: TRLLabel;
    RLDBText5: TRLDBText;
    RLLabel11: TRLLabel;
    RLDBText7: TRLDBText;
    RLLabel13: TRLLabel;
    RLDBText9: TRLDBText;
    RLLabel12: TRLLabel;
    RLDBText8: TRLDBText;
    QryOrcamentoorcamentoId: TZIntegerField;
    QryOrcamentoclienteId: TZIntegerField;
    QryOrcamentonome: TZUnicodeStringField;
    QryOrcamentodataOrcamento: TZDateTimeField;
    QryOrcamentoTotalOrcamento: TZDoubleField;
    RLDBResultDinheiro: TRLDBResult;
    RLLabel6: TRLLabel;
    QryOrcamentoItensorcamentoId: TZIntegerField;
    QryOrcamentoItensprodutoId: TZIntegerField;
    QryOrcamentoItensnome: TZUnicodeStringField;
    QryOrcamentoItensquantidade: TZFMTBCDField;
    QryOrcamentoItensvalorUnitario: TZFMTBCDField;
    QryOrcamentoItensvalorTotalProduto: TZFMTBCDField;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelOrcamento: TfrmRelOrcamento;

implementation

{$R *.dfm}



procedure TfrmRelOrcamento.FormDestroy(Sender: TObject);
begin
   QryOrcamento.Close;
   QryOrcamentoItens.Close;
end;

end.
