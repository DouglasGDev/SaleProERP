unit uConsultaCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHerancaConsulta, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmConsultaCategoria = class(TfrmTelaHerancaConsulta)
    QryListagemcategoriaId: TZIntegerField;
    QryListagemdescricao: TZUnicodeStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaCategoria: TfrmConsultaCategoria;

implementation

{$R *.dfm}

procedure TfrmConsultaCategoria.FormCreate(Sender: TObject);
begin
    // ao criar o formul�rio ele ja vai atualizar os campos da tela
   aCampoId := 'categoriaId'; // o campo que est� esperando pra retornar no dlbclick
   IndiceAtual := 'descricao';// e o label que vai ser mostrado ao abrir na barra de pesquisa
  inherited;

end;

end.
