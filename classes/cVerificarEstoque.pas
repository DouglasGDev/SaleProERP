unit cVerificarEstoque;

interface

uses
  SysUtils,
  Classes,
  ZConnection,
  ZDataset,
  ExtCtrls,
  uNotificacao,
  Vcl.Buttons;

type
  TVerificarEstoque = class(TObject)
  private
    Conexao: TZConnection;
    Tempo: TTimer;
    Notificacao: TfrmNotificacao; // Adicionando uma refer�ncia para o formul�rio de notifica��o
    procedure VerificarEstoqueBaixo(Sender: TObject);
  public
    constructor Create(AConexao: TZConnection; ANotificacao: TfrmNotificacao; AInterval: Integer);
    destructor Destroy; override;
    procedure Iniciar;
    procedure Parar;
  end;

implementation

constructor TVerificarEstoque.Create(AConexao: TZConnection; ANotificacao: TfrmNotificacao; AInterval: Integer);
begin
  inherited Create;
  Conexao := AConexao;
  Notificacao := ANotificacao; // Atribuindo a refer�ncia do formul�rio de notifica��o

  // Configurar o timer
  Tempo := TTimer.Create(nil);
  Tempo.Interval := AInterval;
  Tempo.OnTimer := VerificarEstoqueBaixo;
end;

destructor TVerificarEstoque.Destroy;
begin
  Tempo.Free;
  inherited Destroy;
end;

procedure TVerificarEstoque.Iniciar;
begin
  Tempo.Enabled := True;
end;

procedure TVerificarEstoque.Parar;
begin
  Tempo.Enabled := False;
end;

procedure TVerificarEstoque.VerificarEstoqueBaixo(Sender: TObject);
var
  Query: TZQuery;
begin
  Query := TZQuery.Create(nil);
  try
    Query.Connection := Conexao;
    Query.SQL.Text := 'SELECT produtoId, nome, quantidade, qtminima FROM produtos WHERE quantidade <= qtminima';
    Query.Open;

    while not Query.EOF do // todo fim de arquivo, no caso tabela ele varre at� achar a correspondencia de query
    begin
      Notificacao.MostrarNotificacao('Produto com Estoque Baixo',
                                      Format('Produto: %s (ID: %d) est� com quantidade baixa (%d unidades).',
                                      [Query.FieldByName('nome').AsString,
                                       Query.FieldByName('produtoId').AsInteger,
                                       Query.FieldByName('quantidade').AsInteger,
                                       Query.FieldByName('qtminima').AsInteger]));

      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;


end.

