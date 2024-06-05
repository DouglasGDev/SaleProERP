unit cControleEstoque;

interface

uses System.Classes,
     Vcl.Controls,
     Vcl.ExtCtrls,
     Vcl.Dialogs,
     ZAbstractConnection,
     ZConnection,
     ZAbstractRODataset,
     ZAbstractDataset,
     ZDataset,
     System.SysUtils,
     Data.DB,
     Datasnap.DBClient;

type
  TControleEstoque = class // tipo
  private
    ConexaoDB:TZConnection;  // conex�o
    F_ProdutoId:Integer; // pra receber o produto(a pk)
    F_Quantidade:Double; // a quantidade
  public
    constructor Create(aConexao: TZConnection);// recebe uma conex�o
    destructor Destroy; override;
    function BaixarEstoque: Boolean;
    function RetornarEstoque: Boolean;
  published
    property ProdutoId:Integer     read F_ProdutoId    write F_ProdutoId;
    property Quantidade:Double     read F_Quantidade   write F_Quantidade;
  end;

implementation

{$region 'Constructor and Destructor'}
constructor TControleEstoque.Create(aConexao:TZConnection);
begin
  ConexaoDB:=aConexao;
end;

destructor TControleEstoque.Destroy;
begin

  inherited;
end;
{$endRegion}

function TControleEstoque.BaixarEstoque: Boolean;
var Qry:TZQuery;
begin
  try
    Result:=true;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;

    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE produtos '+
                '   SET quantidade = quantidade - :qtdeBaixa '+
                ' WHERE produtoId=:produtoId ');
    Qry.ParamByName('produtoId').AsInteger :=ProdutoId;
    Qry.ParamByName('qtdeBaixa').AsFloat   :=Quantidade;
     Try
       ConexaoDB.StartTransaction;
       Qry.ExecSQL;
       ConexaoDB.Commit;
     Except
       ConexaoDB.Rollback;
       Result := False;
     End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;


function TControleEstoque.RetornarEstoque: Boolean;
var Qry:TZQuery;
begin
  try
    Result:=true;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;

    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE produtos '+
                '   SET quantidade = quantidade + :qtdeRetorno '+
                ' WHERE produtoId=:produtoId ');
    Qry.ParamByName('produtoId').AsInteger :=ProdutoId;
    Qry.ParamByName('qtdeRetorno').AsFloat :=Quantidade;
     Try
       ConexaoDB.StartTransaction;
       Qry.ExecSQL;
       ConexaoDB.Commit;
     Except
       ConexaoDB.Rollback;
       Result := False;
     End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

end.
