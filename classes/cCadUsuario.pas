unit cCadUsuario;

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
     uFuncaoCriptografia;// lista de Units
type
  TUsuario = class // Declara��o do tipo de Classe
  private
      // Variaveis Privada somente dentro da classe
      ConexaoDB : TZConnection;
      F_usuarioId : Integer; // no banco � int
      F_nome : String;
      F_senha : String;
      function getSenha : String;
      procedure setSenha(const Value : String);



  public
    constructor Create(aConexao:TZConnection); //Construtor de Classe
    destructor Destroy; override; //Destroi a Classe usar o override por causa
                                  // de Sobrescrever
    function Inserir : Boolean;
    function Atualizar : Boolean;
    function Apagar : Boolean;
    function Selecionar(id:Integer) : Boolean;
    function Logar(aUsuario, aSenha: String): Boolean;
    function UsuarioExiste(aUsuario: String): Boolean;
    function AlterarSenha: Boolean;
      // Variaveis Publicas que pode ser trabalhadas fora da classe
  published
      // Variaveis Publicas utilizadas para propriedade da classe
      // para fornecer informa��es runtime
      property  codigo :Integer read F_usuarioId write F_usuarioId;
      property  nome   :string  read F_nome      write F_nome;
      property  senha  :string  read getSenha     write setSenha;
  end;

implementation

{ TUsuario }

{$region 'Construtor e Destruidor'}
constructor TUsuario.Create(aConexao:TZConnection);
begin
   ConexaoDB := aConexao;
end;
destructor TUsuario.Destroy;
begin
  inherited;
end;
{$endregion}


{$region 'CRUD'}
function TUsuario.Apagar : Boolean;
var Qry:TZQuery;// criar a conex�o em tempo de execu��o
begin
   if MessageDlg('Apagar o Registro: '+#13+#13+  // pergunta se quer apagar o registro selecionado e quebra em 2 linha
                 'Codigo: '+IntToStr(F_usuarioId)+#13+
                 'Nome: '+F_nome,TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbYes,TMsgDlgBtn.mbNo],0)=mrNo then begin
                   Result:= False; // caso n�o ele da como false e aborta
                   Abort;
   end;
   try
     Result:= True;
     Qry:=TZQuery.Create(nil);// aqui diz que cria algo mas n�o � de ningu�m a cria��o da query
     Qry.Connection:=ConexaoDB;// aqui recebe a conex�o
     Qry.SQL.Clear;// limpa pra evitar impureza
     Qry.SQL.Add('DELETE FROM usuarios '+
                 ' WHERE usuarioId =:usuarioId ');
     Qry.ParamByName('usuarioId').AsInteger :=F_usuarioId;// aqui armazena a informa��o no parametro com o tipo permitido
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
function TUsuario.Atualizar: Boolean;
var Qry:TZQuery;// criar a conex�o em tempo de execu��o
begin
  try
    Result:= True;
    Qry:=TZQuery.Create(nil);// aqui diz que cria algo mas n�o � de ningu�m a cria��o da query
    Qry.Connection:=ConexaoDB;// aqui recebe a conex�o
    Qry.SQL.Clear;// limpa pra evitar impureza
    Qry.SQL.Add('UPDATE usuarios ' +
                 ' SET nome   =:nome ' +
                 '    ,senha  =:senha ' +
                 ' WHERE usuarioId =:usuarioId ');// recebe os campos com o parametro :usuarioId
    Qry.ParamByName('usuarioId').AsInteger       :=Self.F_usuarioId;// aqui armazena a informa��o no parametro com o tipo permitido
    Qry.ParamByName('nome').AsString             :=Self.F_nome;
    Qry.ParamByName('senha').AsString            :=Self.F_senha;
    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;// tenta executar a grava��o
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result:= False; // se n�o der vai retornar false, vai dar erro
    end;
  finally
     if Assigned(Qry) then
        FreeAndNil(Qry);
  end;
end;
function TUsuario.Inserir: Boolean;
var Qry:TZQuery;// criar a conex�o em tempo de execu��o
begin
  try
    Result:= True;
    Qry:=TZQuery.Create(nil);// aqui diz que cria algo mas n�o � de ningu�m a cria��o da query
    Qry.Connection:=ConexaoDB;// aqui recebe a conex�o
    Qry.SQL.Clear;// limpa pra evitar impureza
    Qry.SQL.Add('INSERT INTO usuarios (nome, '     +
                 '                     senha ) ' +
                 ' VALUES             (:nome, '     +
                 '                    :senha ) ' );
    Qry.ParamByName('nome').AsString             :=Self.F_nome;
    Qry.ParamByName('senha').AsString            :=Self.F_senha;
    try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;// tenta executar a grava��o
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result:= False; // se n�o der vai retornar false, vai dar erro
    end;
  finally
     if Assigned(Qry) then
        FreeAndNil(Qry);
  end;
end;
function TUsuario.Selecionar(id: Integer): Boolean;
var Qry:TZQuery;// criar a conex�o em tempo de execu��o
begin
  try
    Result:= True;
    Qry:=TZQuery.Create(nil);// aqui diz que cria algo mas n�o � de ningu�m a cria��o da query
    Qry.Connection:=ConexaoDB;// aqui recebe a conex�o
    Qry.SQL.Clear;// limpa pra evitar impureza
    Qry.SQL.Add('SELECT usuarioId, '+
    '                   nome,  '    +
                 '      senha ' +
    ' FROM usuarios '+
    ' WHERE usuarioId =:usuarioId');// recebe os campos com o parametro :usuarioId
    Qry.ParamByName('usuarioId').AsInteger:=id;// aqui armazena a informa��o no parametro que pega do id la encima do selecionar
    try
      Qry.Open;// tenta abrir a conex�o
      Self.F_usuarioId := Qry.FieldByName('usuarioId').AsInteger;// pega da resposta do banco de dados os campos
      Self.F_nome      := Qry.FieldByName('nome').AsString;
      Self.F_senha     := Qry.FieldByName('senha').AsString;
    Except
      Result:= False; // se n�o der vai retornar false, vai dar erro
    end;
  finally
     if Assigned(Qry) then // destroi a query da memoria e limpa
        FreeAndNil(Qry);
     end;
  end;

function TUsuario.UsuarioExiste(aUsuario:String):Boolean;
var Qry:TZQuery;
begin
  try
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT COUNT(usuarioId) AS Qtde '+
                '  FROM usuarios '+
                ' WHERE nome =:nome ');
    Qry.ParamByName('nome').AsString :=aUsuario;
    Try
      Qry.Open;

      if Qry.FieldByName('Qtde').AsInteger>0 then
         result := true
      else
         result := false;

    Except
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

{$endregion}
{$region 'GET E SET'}
function TUsuario.getSenha: String; // quando ele pega a senha, ele criptografa ela na heran�a fun��o de criptografar, ou quando manda pro db ele criptografa
begin
  Result := Descriptografar(Self.F_senha);
end;
procedure TUsuario.setSenha(const Value: String); // quando ele pega a senha, ele descriptografa ela na heran�a fun��o de descriptografar, ou quando ele le do db ele desciptografa
begin
  Self.F_senha := Criptografar(Value);
end;
{$endregion}

{$region 'LOGIN'}
function TUsuario.Logar(aUsuario:String; aSenha:String):Boolean;
var Qry:TZQuery;
begin
  try
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT usuarioId, '+
                '       nome, '+
                '       senha '+
                '  FROM usuarios '+
                ' WHERE nome =:nome '+
                '   AND senha=:senha');
    Qry.ParamByName('nome').AsString :=aUsuario;
    Qry.ParamByName('senha').AsString:=Criptografar(aSenha);
    Try
      Qry.Open;

      if Qry.FieldByName('usuarioId').AsInteger>0 then begin
         F_usuarioId:= Qry.FieldByName('usuarioId').AsInteger;
         F_nome     := Qry.FieldByName('nome').AsString;
         F_senha    := Qry.FieldByName('senha').AsString;
         result     := true;
      end
      else
         result := false;

    Except
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;
{$endregion}

{$region 'ALTERA��O DE SENHA'}
function TUsuario.AlterarSenha: Boolean;
var Qry:TZQuery;
begin
  try
    Result:=true;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE usuarios '+
                '   SET senha =:senha '+
                ' WHERE usuarioId=:usuarioId ');
    Qry.ParamByName('usuarioId').AsInteger       :=Self.F_usuarioId;
    Qry.ParamByName('senha').AsString            :=Self.F_Senha;

    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

{$endregion}


end.
