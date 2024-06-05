unit cCadCliente;

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
     ZDataset;// lista de Units

type
  TCliente = class // Declaração do tipo de Classe
  private
      // Variaveis Privada somente dentro da classe
      ConexaoDB : TZConnection;
      F_clienteId : Integer; // no banco é int
      F_nome : String;
      F_endereco : String;
      F_cidade : String;
      F_bairro : String;
      F_estado : String;
      F_cep : String;
      F_telefone : String;
      F_email : String;
      F_cpf : String;
      F_dataNascimento : TDateTime;

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
      // para fornecer informações runtime
      property  codigo :Integer read F_clienteId write F_clienteId;
      property  nome   :string  read F_nome      write F_nome;
      property  endereco:string read F_endereco  write F_endereco;
      property  cidade :string  read F_cidade    write F_cidade;
      property  bairro :string  read F_bairro    write F_bairro;
      property  estado :string  read F_estado    write F_estado;
      property  cep    :string  read F_cep       write F_cep;
      property  telefone:string read F_telefone  write F_telefone;
      property  email  :string  read F_email     write F_email;
      property  cpf    :string  read F_cpf       write F_cpf;
      property  dataNascimento:TDateTime  read F_dataNascimento      write F_dataNascimento;
  end;


implementation

{$region 'Construtor e Destruidor'}
constructor TCliente.Create(aConexao:TZConnection);
begin
   ConexaoDB := aConexao;
end;

destructor TCliente.Destroy;
begin
  inherited;
end;

{$endregion}

{$region 'CRUD'}
function TCliente.Apagar : Boolean;
var Qry:TZQuery;// criar a conexão em tempo de execução
begin
   if MessageDlg('Apagar o Registro: '+#13+#13+  // pergunta se quer apagar o registro selecionado e quebra em 2 linha
                 'Codigo: '+IntToStr(F_clienteId)+#13+
                 'Nome: '+F_nome,TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbYes,TMsgDlgBtn.mbNo],0)=mrNo then begin
                   Result:= False; // caso não ele da como false e aborta
                   Abort;
   end;
   try
     Result:= True;
     Qry:=TZQuery.Create(nil);// aqui diz que cria algo mas não é de ninguém a criação da query
     Qry.Connection:=ConexaoDB;// aqui recebe a conexão
     Qry.SQL.Clear;// limpa pra evitar impureza
     Qry.SQL.Add('DELETE FROM clientes '+
                 ' WHERE clienteId =:clienteId ');
     Qry.ParamByName('clienteId').AsInteger :=F_clienteId;// aqui armazena a informação no parametro com o tipo permitido
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

function TCliente.Atualizar: Boolean;
var Qry:TZQuery;// criar a conexão em tempo de execução
begin
  try
    Result:= True;
    Qry:=TZQuery.Create(nil);// aqui diz que cria algo mas não é de ninguém a criação da query
    Qry.Connection:=ConexaoDB;// aqui recebe a conexão
    Qry.SQL.Clear;// limpa pra evitar impureza
    Qry.SQL.Add('UPDATE clientes ' +
                 ' SET nome  =:nome ' +
                 '    ,endereco  =:endereco ' +
                 '    ,cidade  =:cidade ' +
                 '    ,bairro  =:bairro ' +
                 '    ,estado  =:estado ' +
                 '    ,cep  =:cep ' +
                 '    ,telefone  =:telefone ' +
                 '    ,email  =:email ' +
                 '    ,cpf  =:cpf ' +
                 '    ,dataNascimento  =:dataNascimento ' +
                 ' WHERE clienteId =:clienteId ');// recebe os campos com o parametro :clienteId
    Qry.ParamByName('clienteId').AsInteger       :=Self.F_clienteId;// aqui armazena a informação no parametro com o tipo permitido
    Qry.ParamByName('nome').AsString             :=Self.F_nome;
    Qry.ParamByName('endereco').AsString         :=Self.F_endereco;
    Qry.ParamByName('cidade').AsString           :=Self.F_cidade;
    Qry.ParamByName('bairro').AsString           :=Self.F_bairro;
    Qry.ParamByName('estado').AsString           :=Self.F_estado;
    Qry.ParamByName('cep').AsString              :=Self.F_cep;
    Qry.ParamByName('telefone').AsString         :=Self.F_telefone;
    Qry.ParamByName('email').AsString            :=Self.F_email;
    Qry.ParamByName('cpf').AsString              :=Self.F_cpf;
    Qry.ParamByName('dataNascimento').AsDateTime :=Self.F_dataNascimento;
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

function TCliente.Inserir: Boolean;
var Qry:TZQuery;// criar a conexão em tempo de execução
begin
  try
    Result:= True;
    Qry:=TZQuery.Create(nil);// aqui diz que cria algo mas não é de ninguém a criação da query
    Qry.Connection:=ConexaoDB;// aqui recebe a conexão
    Qry.SQL.Clear;// limpa pra evitar impureza
    Qry.SQL.Add('INSERT INTO clientes (nome, '     +
                 '                     endereco, ' +
                 '                     cidade, '   +
                 '                     bairro, '   +
                 '                     estado, '   +
                 '                     cep, '      +
                 '                     telefone, ' +
                 '                     email, '    +
                 '                     cpf, '      +
                 '               dataNascimento) ' +
                 ' VALUES            (:nome, '     +
                 '                    :endereco, ' +
                 '                    :cidade, '   +
                 '                    :bairro, '   +
                 '                    :estado, '   +
                 '                    :cep, '      +
                 '                    :telefone, ' +
                 '                    :email, '    +
                 '                    :cpf, '      +
                 '               :dataNascimento)' );

    Qry.ParamByName('nome').AsString             :=Self.F_nome;
    Qry.ParamByName('endereco').AsString         :=Self.F_endereco;
    Qry.ParamByName('cidade').AsString           :=Self.F_cidade;
    Qry.ParamByName('bairro').AsString           :=Self.F_bairro;
    Qry.ParamByName('estado').AsString           :=Self.F_estado;
    Qry.ParamByName('cep').AsString              :=Self.F_cep;
    Qry.ParamByName('telefone').AsString         :=Self.F_telefone;
    Qry.ParamByName('email').AsString            :=Self.F_email;
    Qry.ParamByName('cpf').AsString              :=Self.F_cpf;
    Qry.ParamByName('dataNascimento').AsDateTime :=Self.F_dataNascimento;
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

function TCliente.Selecionar(id: Integer): Boolean;
var Qry:TZQuery;// criar a conexão em tempo de execução
begin
  try
    Result:= True;
    Qry:=TZQuery.Create(nil);// aqui diz que cria algo mas não é de ninguém a criação da query
    Qry.Connection:=ConexaoDB;// aqui recebe a conexão
    Qry.SQL.Clear;// limpa pra evitar impureza
    Qry.SQL.Add('SELECT clienteId, '+
    '                   nome,  '    +
                 '      endereco, ' +
                 '      cidade, '   +
                 '      bairro, '   +
                 '      estado, '   +
                 '      cep, '      +
                 '      telefone, ' +
                 '      email, '    +
                 '      cpf, '      +
                 '      dataNascimento ' +
    ' FROM clientes '+
    ' WHERE clienteId =:clienteId');// recebe os campos com o parametro :clienteId
    Qry.ParamByName('clienteId').AsInteger:=id;// aqui armazena a informação no parametro que pega do id la encima do selecionar
    try
      Qry.Open;// tenta abrir a conexão
      Self.F_clienteId := Qry.FieldByName('clienteId').AsInteger;// pega o id do campo(interface) e atribui a query com o campo categoriaid e com o tipo em inteiro
      Self.F_nome      := Qry.FieldByName('nome').AsString;
      Self.F_endereco  := Qry.FieldByName('endereco').AsString;
      Self.F_cidade    := Qry.FieldByName('cidade').AsString;
      Self.F_bairro    := Qry.FieldByName('bairro').AsString;
      Self.F_estado    := Qry.FieldByName('estado').AsString;
      Self.F_cep       := Qry.FieldByName('cep').AsString;
      Self.F_telefone  := Qry.FieldByName('telefone').AsString;
      Self.F_email     := Qry.FieldByName('email').AsString;
      Self.F_cpf       := Qry.FieldByName('cpf').AsString;
      Self.F_dataNascimento   := Qry.FieldByName('dataNascimento').AsDateTime;
    Except
      Result:= False; // se não der vai retornar false, vai dar erro
    end;
  finally
     if Assigned(Qry) then // destroi a query da memoria e limpa
        FreeAndNil(Qry);
     end;
  end;

{$endregion}

end.
