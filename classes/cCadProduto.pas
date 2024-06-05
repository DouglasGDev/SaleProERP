unit cCadProduto;
interface
uses System.Classes,
     System.SysUtils,
     Vcl.Controls,
     Vcl.ExtCtrls,
     Vcl.Dialogs,
     ZAbstractConnection,
     ZConnection,
     ZAbstractRODataset,
     ZAbstractDataset,
     ZDataset,
     System.StrUtils,
     Vcl.Imaging.jpeg,
     Vcl.Graphics;// lista de Units
type
  TProduto = class // Declara��o do tipo de Classe
  private
      // Variaveis Privada somente dentro da classe
      ConexaoDB : TZConnection;
      F_produtoId : Integer; // no banco � int
      F_nome : String;
      F_descricao : String;
      F_custo : Double;
      F_valor : Double;
      F_qtminima : Double;
      F_codbarras : String;
      F_validade : TDateTime;
      F_foto : TBitmap;
      F_categoriaId: Integer;
  public
    constructor Create(aConexao:TZConnection); //Construtor de Classe
    destructor Destroy; override; //Destroi a Classe usar o override por causa
                                  // de Sobrescrever
    function Inserir : Boolean;
    function Atualizar : Boolean;
    function Apagar : Boolean;
    function Selecionar(id:Integer) : Boolean;
      // Variaveis Publicas que pode ser trabalhadas fora da classe
  published
      // Variaveis Publicas utilizadas para propriedade da classe
      // para fornecer informa��es runtime
      property  codigo     : Integer   read F_produtoId   write F_produtoId;
      property  nome       : string    read F_nome        write F_nome;
      property  descricao  : string    read F_descricao   write F_descricao;
      property  custo      : Double    read F_custo       write F_custo;
      property  valor      : Double    read F_valor       write F_valor;
      property  qtminima   : Double    read F_qtminima    write F_qtminima;
      property  codbarras  : string    read F_codbarras   write F_codbarras;
      property  validade   : TDateTime read F_validade    write F_validade;
      property  foto       : TBitmap   read F_foto        write F_foto;
      property  categoriaId: Integer   read F_categoriaId write F_categoriaId;
  end;

implementation
{$region 'Construtor e Destruidor'}
constructor TProduto.Create(aConexao:TZConnection);
begin
   ConexaoDB := aConexao;
   F_foto := TBitmap.Create; // toda vez que iniciar a conexao do produto, tem que iniciar a imagem tbm
   F_foto.Assign(nil);
end;
destructor TProduto.Destroy;
begin
  if Assigned(F_foto) then begin
    F_foto.Assign(nil);
    F_foto.Free;
  end;
  inherited;
end;
{$endregion}
{$region 'CRUD'}
function TProduto.Apagar : Boolean;
var Qry:TZQuery;// criar a conex�o em tempo de execu��o
begin
   if MessageDlg('Apagar o Registro: '+#13+#13+  // pergunta se quer apagar o registro selecionado e quebra em 2 linha
                 'Codigo: '+IntToStr(F_produtoId)+#13+
                 'Nome: '+F_nome,TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbYes,TMsgDlgBtn.mbNo],0)=mrNo then begin
                   Result:= False; // caso n�o ele da como false e aborta
                   Abort;
   end;
   try
     Result:= True;
     Qry:=TZQuery.Create(nil);// aqui diz que cria algo mas n�o � de ningu�m a cria��o da query
     Qry.Connection:=ConexaoDB;// aqui recebe a conex�o
     Qry.SQL.Clear;// limpa pra evitar impureza
     Qry.SQL.Add('DELETE FROM produtos '+
                 ' WHERE produtoId =:produtoId ');
     Qry.ParamByName('produtoId').AsInteger :=F_produtoId;// aqui armazena a informa��o no parametro com o tipo permitido
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
function TProduto.Atualizar: Boolean;
var Qry:TZQuery;// criar a conex�o em tempo de execu��o
begin
  try
    Result:= True;
    Qry:=TZQuery.Create(nil);// aqui diz que cria algo mas n�o � de ningu�m a cria��o da query
    Qry.Connection:=ConexaoDB;// aqui recebe a conex�o
    Qry.SQL.Clear;// limpa pra evitar impureza
    Qry.SQL.Add('UPDATE produtos ' +
                 ' SET nome  =:nome ' +
                 '    ,descricao  =:descricao ' +
                 '    ,custo =:custo '+
                 '    ,valor  =:valor ' +
                 '    ,qtminima  =:qtminima ' +
                 '    ,codbarras  =:codbarras ' +
                 '    ,validade  =:validade ' +
                 '    ,foto =:foto ' +
                 '    ,categoriaId  =:categoriaId ' +
                 ' WHERE produtoId =:produtoId ');// recebe os campos com o parametro :produtoId
    Qry.ParamByName('produtoId').AsInteger       :=Self.F_produtoId;// aqui armazena a informa��o no parametro com o tipo permitido
    Qry.ParamByName('nome').AsString             :=Self.F_nome;
    Qry.ParamByName('descricao').AsString        :=Self.F_descricao;
    Qry.ParamByName('custo').AsDouble            :=Self.F_custo;
    Qry.ParamByName('valor').AsDouble            :=Self.F_valor;
    Qry.ParamByName('qtminima').AsDouble         :=Self.F_qtminima;
    Qry.ParamByName('codbarras').AsString        :=Self.F_codbarras;
    Qry.ParamByName('validade').AsDateTime       :=Self.F_validade;
    Qry.ParamByName('categoriaId').AsInteger     :=Self.F_categoriaId;
    if Self.F_foto.Empty then
      Qry.ParamByName('foto').Clear
    else
      Qry.ParamByName('foto').Assign(Self.F_foto);

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
function TProduto.Inserir: Boolean;
var Qry:TZQuery;// criar a conex�o em tempo de execu��o
begin
  try
    Result:= True;
    Qry:=TZQuery.Create(nil);// aqui diz que cria algo mas n�o � de ningu�m a cria��o da query
    Qry.Connection:=ConexaoDB;// aqui recebe a conex�o
    Qry.SQL.Clear;// limpa pra evitar impureza
    Qry.SQL.Add('INSERT INTO produtos (nome, '     +
                 '                     descricao, ' +
                 '                     custo, ' +
                 '                     valor, '   +
                 '                     qtminima, '   +
                 '                     codbarras, '   +
                 '                     validade, '      +
                 '                     foto, ' +
                 '                     categoriaId )' +
                 ' VALUES            (:nome, '     +
                 '                    :descricao, ' +
                 '                    :custo, '   +
                 '                    :valor, '   +
                 '                    :qtminima, '   +
                 '                    :codbarras, '   +
                 '                    :validade, '      +
                 '                    :foto, ' +
                 '                    :categoriaId ) ' );
    Qry.ParamByName('nome').AsString             :=Self.F_nome;
    Qry.ParamByName('descricao').AsString        :=Self.F_descricao;
    Qry.ParamByName('custo').AsDouble            :=Self.F_custo;
    Qry.ParamByName('valor').AsDouble            :=Self.F_valor;
    Qry.ParamByName('qtminima').AsDouble       :=Self.F_qtminima;
    Qry.ParamByName('codbarras').AsString           :=Self.F_codbarras;
    Qry.ParamByName('validade').AsDateTime :=Self.F_validade;
    Qry.ParamByName('categoriaId').AsInteger :=Self.F_categoriaId;
    if Self.F_foto.Empty then
      Qry.ParamByName('foto').Clear
    else
      Qry.ParamByName('foto').Assign(Self.F_foto);
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
function TProduto.Selecionar(id: Integer): Boolean;
var Qry:TZQuery;// criar a conex�o em tempo de execu��o
begin
  try
    Result:= True;
    Qry:=TZQuery.Create(nil);// aqui diz que cria algo mas n�o � de ningu�m a cria��o da query
    Qry.Connection:=ConexaoDB;// aqui recebe a conex�o
    Qry.SQL.Clear;// limpa pra evitar impureza
    Qry.SQL.Add('SELECT produtoId, '+
    '                   nome,  '    +
                 '      descricao, ' +
                 '      custo, ' +
                 '      valor, '   +
                 '      qtminima, '   +
                 '      codbarras, '   +
                 '      validade, '      +
                 '      foto, ' +
                 '      categoriaId ' +
    ' FROM produtos '+
    ' WHERE produtoId =:produtoId');// recebe os campos com o parametro :produtoId
    Qry.ParamByName('produtoId').AsInteger:=id;// aqui armazena a informa��o no parametro que pega do id la encima do selecionar
    try
      Qry.Open;// tenta abrir a conex�o
      Self.F_produtoId := Qry.FieldByName('produtoId').AsInteger;// pega o id do campo(interface) e atribui a query com o campo categoriaid e com o tipo em inteiro
      Self.F_nome      := Qry.FieldByName('nome').AsString;
      Self.F_descricao := Qry.FieldByName('descricao').AsString;
      Self.F_custo     := Qry.FieldByName('custo').AsFloat;
      Self.F_valor     := Qry.FieldByName('valor').AsFloat;
      Self.F_qtminima:= Qry.FieldByName('qtminima').AsFloat;
      Self.F_codbarras := Qry.FieldByName('codbarras').AsString;
      Self.F_validade  := Qry.FieldByName('validade').AsDateTime;
      Self.F_foto.Assign(Qry.FieldByName('foto'));
      Self.F_categoriaId := Qry.FieldByName('categoriaId').AsInteger;
    Except
      Result:= False; // se n�o der vai retornar false, vai dar erro
    end;
  finally
     if Assigned(Qry) then // destroi a query da memoria e limpa
        FreeAndNil(Qry);
     end;
  end;
{$endregion}
end.
implementation
end.
