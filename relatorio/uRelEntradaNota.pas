unit uRelEntradaNota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, uDTMConexao, RLReport, RLFilters, RLPDFFilter,
  RLRichText, RLPreviewForm, RLXLSXFilter, RLHTMLFilter, RLXLSFilter;

type
  TfrmRelEntradaNota = class(TForm)
    QryEntradaNota: TZQuery;
    dtsEntradaNota: TDataSource;
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
    RLLabel6: TRLLabel;
    RLBand5: TRLBand;
    RLDraw4: TRLDraw;
    QryEntradaNotaItens: TZQuery;
    dtsEntradaNotaItens: TDataSource;
    RLLabel9: TRLLabel;
    RLLabel7: TRLLabel;
    RLDBText1: TRLDBText;
    RLLabel4: TRLLabel;
    RLSubDetail1: TRLSubDetail;
    RLBand2: TRLBand;
    RLLabel5: TRLLabel;
    RLBand4: TRLBand;
    RLDBText3: TRLDBText;
    RLLabel10: TRLLabel;
    RLDBText5: TRLDBText;
    RLLabel11: TRLLabel;
    RLDBText7: TRLDBText;
    RLLabel12: TRLLabel;
    RLDBText8: TRLDBText;
    RLLabel21: TRLLabel;
    RLDBText10: TRLDBText;
    QryEntradaNotaItensentradaId: TZUnicodeStringField;
    QryEntradaNotaItensprodutoId: TZIntegerField;
    QryEntradaNotaItensnome: TZUnicodeStringField;
    QryEntradaNotaItensquantidade: TZFMTBCDField;
    QryEntradaNotaItenscusto: TZFMTBCDField;
    QryEntradaNotaentradaId: TZUnicodeStringField;
    QryEntradaNotafornecedorId: TZIntegerField;
    QryEntradaNotarazaosocial: TZUnicodeStringField;
    QryEntradaNotanumnotafiscal: TZUnicodeStringField;
    QryEntradaNotanumpedido: TZIntegerField;
    QryEntradaNotadataEntrada: TZDateTimeField;
    QryEntradaNotaTotalNota: TZDoubleField;
    RLLabel13: TRLLabel;
    RLDBText11: TRLDBText;
    RLLabel14: TRLLabel;
    RLDBText9: TRLDBText;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelEntradaNota: TfrmRelEntradaNota;

implementation

{$R *.dfm}



procedure TfrmRelEntradaNota.FormDestroy(Sender: TObject);
begin
   QryEntradaNota.Close;
   QryEntradaNotaItens.Close;
end;

end.
