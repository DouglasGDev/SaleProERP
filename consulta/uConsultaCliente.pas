unit uConsultaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHerancaConsulta, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmConsultaCliente = class(TfrmTelaHerancaConsulta)
    QryListagemclienteId: TZIntegerField;
    QryListagemnome: TZUnicodeStringField;
    QryListagemcpf: TZUnicodeStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaCliente: TfrmConsultaCliente;

implementation

{$R *.dfm}

procedure TfrmConsultaCliente.FormCreate(Sender: TObject);
begin
 // ao criar o formulário ele ja vai atualizar os campos da tela
   aCampoId := 'clienteId'; // o campo que está esperando pra retornar no dlbclick
   IndiceAtual := 'nome';// e o label que vai ser mostrado ao abrir na barra de pesquisa
  inherited;

end;

end.
