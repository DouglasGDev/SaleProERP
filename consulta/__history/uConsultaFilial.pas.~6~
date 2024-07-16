unit uConsultaFilial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHerancaConsulta, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmConsultaFilial = class(TfrmTelaHerancaConsulta)
    QryListagemfilialId: TZIntegerField;
    QryListagemnumfilial: TZIntegerField;
    QryListagemfantasia: TZUnicodeStringField;
    QryListagemcnpj: TZUnicodeStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaFilial: TfrmConsultaFilial;

implementation

{$R *.dfm}

procedure TfrmConsultaFilial.FormCreate(Sender: TObject);
begin
   aCampoId := 'filialId'; // o campo que está esperando pra retornar no dlbclick
   IndiceAtual := 'fantasia';// e o label que vai ser mostrado ao abrir na barra de pesquisa
  inherited;
end;

end.
