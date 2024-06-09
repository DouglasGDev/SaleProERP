unit cProOrcamento;

interface

uses
  System.Classes,
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
  uEnum,
  Datasnap.DBClient;

type
  TOrcamento = class
  private
    ConexaoDB: TZConnection;
    F_orcamentoId: Integer;
    F_clienteId: Integer;
    F_dataOrcamento: TDateTime;
    F_totalOrcamento: Double;
    function EsteItemExiste(orcamentoId, produtoId: Integer): Boolean;
    function InNot(cds: TClientDataSet): String;
    function AtualizarItem(cds: TClientDataSet): Boolean;
    function ApagaItens(cds: TClientDataSet): Boolean;
    function InserirItens(cds: TClientDataSet; IdOrcamento: Integer): Boolean;
  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir(cds: TClientDataSet): Integer;
    function Atualizar(cds: TClientDataSet): Boolean;
    function Apagar: Boolean;
    function Selecionar(id: Integer; var cds: TClientDataSet): Boolean;
  published
    property OrcamentoId: Integer read F_orcamentoId write F_orcamentoId;
    property ClienteId: Integer read F_clienteId write F_clienteId;
    property DataOrcamento: TDateTime read F_dataOrcamento write F_dataOrcamento;
    property TotalOrcamento: Double read F_totalOrcamento write F_totalOrcamento;
  end;

implementation

{ TOrcamento }

{$region 'Constructor and Destructor'}
constructor TOrcamento.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TOrcamento.Destroy;
begin
  inherited;
end;
{$endRegion}

{$region 'CRUD'}
function TOrcamento.Apagar: Boolean;
var Qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: ' + #13#13 +
                'Orçamento Nro: ' + IntToStr(F_OrcamentoId), mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Result := False;
    Abort;
  end;

  try
    Result := True;
    ConexaoDB.StartTransaction;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    // Apaga os Itens Primeiro
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM itens_orcamento ' +
                ' WHERE orcamentoId = :orcamentoId ');
    Qry.ParamByName('orcamentoId').AsInteger := F_OrcamentoId;
    try
      Qry.ExecSQL;
      // Apaga a Tabela Master
      Qry.SQL.Clear;
      Qry.SQL.Add('DELETE FROM orcamentos ' +
                  ' WHERE orcamentoId = :orcamentoId ');
      Qry.ParamByName('orcamentoId').AsInteger := F_OrcamentoId;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TOrcamento.InNot(cds: TClientDataSet): String;
var sInNot: String;
begin
  sInNot := EmptyStr;
  cds.First;
  while not cds.Eof do
  begin
    if sInNot = EmptyStr then
      sInNot := cds.FieldByName('produtoId').AsString
    else
      sInNot := sInNot + ',' + cds.FieldByName('produtoId').AsString;

    cds.Next;
  end;
  Result := sInNot;
end;

function TOrcamento.Atualizar(cds: TClientDataSet): Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    ConexaoDB.StartTransaction;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE orcamentos ' +
                '   SET clienteId = :clienteId ' +
                '      ,dataOrcamento = :dataOrcamento ' +
                '      ,totalOrcamento = :totalOrcamento ' +
                ' WHERE orcamentoId = :orcamentoId ');
    Qry.ParamByName('orcamentoId').AsInteger := Self.F_orcamentoId;
    Qry.ParamByName('clienteId').AsInteger := Self.F_clienteId;
    Qry.ParamByName('dataOrcamento').AsDateTime := Self.F_dataOrcamento;
    Qry.ParamByName('totalOrcamento').AsFloat := Self.F_totalOrcamento;

    try
      // Update
      Qry.ExecSQL;

      // Apagar Itens no banco que foram apagados na tela
      ApagaItens(cds);

      cds.First;
      while not cds.Eof do
      begin
        if EsteItemExiste(Self.F_orcamentoId, cds.FieldByName('produtoId').AsInteger) then
        begin
          AtualizarItem(cds);
        end
        else
        begin
          InserirItens(cds, Self.F_orcamentoId);
        end;
        cds.Next;
      end;
      ConexaoDB.Commit;
    except
      Result := False;
      ConexaoDB.Rollback;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TOrcamento.AtualizarItem(cds: TClientDataSet): Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE itens_orcamento ' +
                '   SET ValorUnitario = :ValorUnitario ' +
                '      ,Quantidade = :Quantidade ' +
                '      ,TotalProduto = :TotalProduto ' +
                ' WHERE orcamentoId = :orcamentoId AND produtoId = :produtoId ');
    Qry.ParamByName('orcamentoId').AsInteger := Self.F_orcamentoId;
    Qry.ParamByName('produtoId').AsInteger := cds.FieldByName('produtoId').AsInteger;
    Qry.ParamByName('ValorUnitario').AsFloat := cds.FieldByName('valorUnitario').AsFloat;
    Qry.ParamByName('Quantidade').AsFloat := cds.FieldByName('quantidade').AsFloat;
    Qry.ParamByName('TotalProduto').AsFloat := cds.FieldByName('valorTotalProduto').AsFloat;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TOrcamento.ApagaItens(cds: TClientDataSet): Boolean;
var Qry: TZQuery;
    sCodNoCds: String;
begin
  try
    Result := True;
    // Pega os codigos que estão no Cliente para Selecionar o In Not no Banco de Dados
    sCodNoCds := InNot(cds);

    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(' DELETE ' +
                '   FROM itens_orcamento ' +
                '  WHERE orcamentoId = :orcamentoId ' +
                '    AND produtoId NOT IN (' + sCodNoCds + ') ');
    Qry.ParamByName('orcamentoId').AsInteger := Self.F_orcamentoId;

    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TOrcamento.Inserir(cds: TClientDataSet): Integer;
var Qry: TZQuery;
    IdOrcamentoGerado: Integer;
begin
  try
    ConexaoDB.StartTransaction;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    // Faz a Inclusão no Banco de Dados
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO orcamentos (clienteId, dataOrcamento, totalOrcamento)  ' +
                '            VALUES (:clienteId, :dataOrcamento, :totalOrcamento)');
    Qry.ParamByName('clienteId').AsInteger := Self.F_clienteId;
    Qry.ParamByName('dataOrcamento').AsDateTime := Self.F_dataOrcamento;
    Qry.ParamByName('totalOrcamento').AsFloat := Self.F_totalOrcamento;

    try
      Qry.ExecSQL;
      // Recupera o ID Gerado no Insert
      Qry.SQL.Clear;
      Qry.SQL.Add('SELECT LAST_INSERT_ID() AS ID');
      Qry.Open;

      // Id da tabela Master (Orçamento)
      IdOrcamentoGerado := Qry.FieldByName('ID').AsInteger;

      {$region 'Gravar na tabela Itens_Orcamento'}
      cds.First;
      while not cds.Eof do
      begin
        InserirItens(cds, IdOrcamentoGerado);
        cds.Next;
      end;
      {$endRegion}

      ConexaoDB.Commit;
      Result := IdOrcamentoGerado;
    except
      ConexaoDB.Rollback;
      Result := -1;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TOrcamento.InserirItens(cds: TClientDataSet; IdOrcamento: Integer): Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO itens_orcamento (orcamentoId, produtoId, ValorUnitario, Quantidade, TotalProduto) ' +
                '                 VALUES (:orcamentoId, :produtoId, :ValorUnitario, :Quantidade, :TotalProduto) ');

    Qry.ParamByName('orcamentoId').AsInteger := IdOrcamento;
    Qry.ParamByName('produtoId').AsInteger := cds.FieldByName('produtoId').AsInteger;
    Qry.ParamByName('ValorUnitario').AsFloat := cds.FieldByName('valorUnitario').AsFloat;
    Qry.ParamByName('Quantidade').AsFloat := cds.FieldByName('quantidade').AsFloat;
    Qry.ParamByName('TotalProduto').AsFloat := cds.FieldByName('valorTotalProduto').AsFloat;
    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TOrcamento.Selecionar(id: Integer; var cds: TClientDataSet): Boolean;
var Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT orcamentoId ' +
                '      ,clienteId ' +
                '      ,dataOrcamento ' +
                '      ,totalOrcamento ' +
                '  FROM orcamentos ' +
                ' WHERE orcamentoId = :orcamentoId');
    Qry.ParamByName('orcamentoId').AsInteger := id;
    try
      Qry.Open;

      Self.F_orcamentoId := Qry.FieldByName('orcamentoId').AsInteger;
      Self.F_clienteId := Qry.FieldByName('clienteId').AsInteger;
      Self.F_dataOrcamento := Qry.FieldByName('dataOrcamento').AsDateTime;
      Self.F_totalOrcamento := Qry.FieldByName('totalOrcamento').AsFloat;

      {$region 'SELECIONAR na tabela Itens_Orcamento'}
      // Apaga o ClientDataSet Caso esteja com Registro
      cds.First;
      while not cds.Eof do
      begin
        cds.Delete;
      end;

      // Seleciona os Itens do Banco de dados com a propriedade F_OrcamentoId
      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add('SELECT itens_orcamento.produtoId, ' +
                  '       produtos.Nome, ' +
                  '       itens_orcamento.ValorUnitario, ' +
                  '       itens_orcamento.Quantidade, ' +
                  '       itens_orcamento.TotalProduto ' +
                  '  FROM itens_orcamento  ' +
                  '       INNER JOIN produtos On produtos.produtoId = itens_orcamento.produtoId ' +
                  ' WHERE itens_orcamento.orcamentoId = :orcamentoId ');
      Qry.ParamByName('orcamentoId').AsInteger := Self.F_orcamentoId;
      Qry.Open;

      // Pega da Query e Coloca no ClientDataSet
      Qry.First;
      while not Qry.Eof do
      begin
        cds.Append;
        cds.FieldByName('produtoId').AsInteger := Qry.FieldByName('produtoId').AsInteger;
        cds.FieldByName('nomeProduto').AsString := Qry.FieldByName('Nome').AsString;
        cds.FieldByName('valorUnitario').AsFloat := Qry.FieldByName('ValorUnitario').AsFloat;
        cds.FieldByName('quantidade').AsFloat := Qry.FieldByName('Quantidade').AsFloat;
        cds.FieldByName('valorTotalProduto').AsFloat := Qry.FieldByName('TotalProduto').AsFloat;
        cds.Post;
        Qry.Next;
      end;
      cds.First;
      {$endRegion}
    except
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TOrcamento.EsteItemExiste(orcamentoId: Integer; produtoId: Integer): Boolean;
var Qry: TZQuery;
begin
  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT Count(orcamentoId) AS Qtde ' +
                '  FROM itens_orcamento ' +
                ' WHERE orcamentoId = :orcamentoId and produtoId = :produtoId ');
    Qry.ParamByName('orcamentoId').AsInteger := orcamentoId;
    Qry.ParamByName('produtoId').AsInteger := produtoId;
    try
      Qry.Open;

      if Qry.FieldByName('Qtde').AsInteger > 0 then
        Result := True
      else
        Result := False;
    except
      Result := False;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

{$endregion}

end.

