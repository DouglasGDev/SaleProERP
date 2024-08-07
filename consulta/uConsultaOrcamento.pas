unit uConsultaOrcamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHerancaConsulta, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmConsultaOrcamento = class(TfrmTelaHerancaConsulta)
    QryListagemorcamentoId: TZIntegerField;
    QryListagemclienteId: TZIntegerField;
    QryListagemdataOrcamento: TZDateTimeField;
    QryListagemtotalOrcamento: TZFMTBCDField;
    QryListagemnome: TZUnicodeStringField;
    procedure FormCreate(Sender: TObject);
    procedure grdPesquisaDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    aRetornarIdOrcamentoSelecionado:Variant;
end;

var
  frmConsultaOrcamento: TfrmConsultaOrcamento;

implementation

{$R *.dfm}

procedure TfrmConsultaOrcamento.FormCreate(Sender: TObject);
begin
   aPrimarioId := 'orcamentoId';
   aCampoId := 'clienteId'; // o campo que est� esperando pra retornar no dlbclick
   IndiceAtual := 'orcamentoId';// e o label que vai ser mostrado ao abrir na barra de pesquisa
  inherited;

end;



procedure TfrmConsultaOrcamento.grdPesquisaDblClick(Sender: TObject);
begin
     aRetornarIdSelecionado := QryListagem.FieldByName(aCampoId).AsVariant;// quando der 2 cliques no aquivo selecionado do grid ele vai fechar e retornar o id daquele campo selecionado e por ser variant, recebe qualquer tipo de dado
     aRetornarIdOrcamentoSelecionado := QryListagem.FieldByName(aPrimarioId).AsVariant;// quando der 2 cliques no aquivo selecionado do grid ele vai fechar e retornar o id daquele campo selecionado e por ser variant, recebe qualquer tipo de dado
     Close;
end;


end.
