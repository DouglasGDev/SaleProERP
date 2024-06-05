unit cAtualizacaoCampoMYSQL;

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
     cAtualizacaoBancoDeDados;

type
  TAtualizacaoCampoMYSQL = class(TAtualizaBancoDados)

  private
    function CampoExisteNaTabela(aNomeTabela, aCampo: String): Boolean;
    //procedure Versao1;

  protected

  public
    constructor Create(aConexao:TZConnection);
    destructor Destroy; override;

end;

implementation

{ TAtualizacaoTableMYSQL }

constructor TAtualizacaoCampoMYSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
  //Versao1;
end;

destructor TAtualizacaoCampoMYSQL.Destroy;
begin
  inherited;
end;

function TAtualizacaoCampoMYSQL.CampoExisteNaTabela(aNomeTabela: String; aCampo:String): Boolean; // verifica se tem tabela com tal nome e campo tbm e isso retorna um numero do que existe, essa classe utiliza-se para atualização de tabela, onde tem que adicionar mais campos e vai mudando conforme a versão
// tem um exemplo comentado abaixo, onde vai executar na hora que abrir a aplicação
Var Qry:TZQuery;
Begin
  Try
    Result:=False;
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(' SELECT COUNT(COLUMN_NAME) AS Qtde ');
    Qry.SQL.Add('   FROM INFORMATION_SCHEMA.COLUMNS ');
    Qry.SQL.Add('  WHERE TABLE_NAME =:Tabela ');
    Qry.SQL.Add('    AND COLUMN_NAME=:Campo ');
    Qry.ParamByName('Tabela').AsString:=aNomeTabela;
    Qry.ParamByName('Campo').AsString :=aCampo;
    Qry.Open;

    if Qry.FieldByName('Qtde').AsInteger>0 then
       Result:=True;

  Finally
    Qry.Close;
    if Assigned(Qry) then
       FreeAndNil(Qry);
  End;
end;

{procedure TAtualizacaoCampoMYSQL.Versao1;
begin
  if not CampoExisteNaTabela('categorias','teste') then
  begin
    ExecutaDiretoBancoDeDados('ALTER TABLE categorias ADD teste varchar(30) NULL ');
  end;

  if CampoExisteNaTabela('categorias','teste') then
  begin
    ExecutaDiretoBancoDeDados('ALTER TABLE categorias DROP COLUMN teste ');
  end;

end;}


end.
