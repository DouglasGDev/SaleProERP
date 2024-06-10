unit uConsultaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHerancaConsulta, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmConsultaProduto = class(TfrmTelaHerancaConsulta)
    QryListagemprodutoId: TZIntegerField;
    QryListagemnome: TZUnicodeStringField;
    QryListagemvalor: TZFMTBCDField;
    QryListagemquantidade: TZFMTBCDField;
    QryListagemcodbarras: TZUnicodeStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaProduto: TfrmConsultaProduto;

implementation

{$R *.dfm}

procedure TfrmConsultaProduto.FormCreate(Sender: TObject);
begin
    // ao criar o formul�rio ele ja vai atualizar os campos da tela
   aCampoId := 'produtoId'; // o campo que est� esperando pra retornar no dlbclick
   IndiceAtual := 'nome';// e o label que vai ser mostrado ao abrir na barra de pesquisa
  inherited;

end;

end.