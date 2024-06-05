unit cAtualizacaoBancoDeDados;

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
  TAtualizaBancoDados = class

  private

  public
    ConexaoDB:TZConnection;
    constructor Create(aConexao:TZConnection);
    procedure ExecutaDiretoBancoDeDados(aScript: String);
end;

Type
  TAtualizaBancoDadosMYSQL = Class
    private
      ConexaoDB: TZConnection;
    public
      function AtualizarBancoDeDadosMYSQL: Boolean;
      constructor Create(aConexao: TZConnection);
  End;

implementation


{ TAtualizaBancoDados }
uses cAtualizacaoTabelaMYSQL , cAtualizacaoCampoMYSQL;

constructor TAtualizaBancoDados.Create(aConexao: TZConnection);
begin
  ConexaoDB:=aConexao;
end;

procedure TAtualizaBancoDados.ExecutaDiretoBancoDeDados(aScript: String);
Var Qry:TZQuery;
Begin
  Try
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(aScript);
    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
    End;
  Finally
    Qry.Close;
    if Assigned(Qry) then
       FreeAndNil(Qry);
  End;
end;



{ TAtualizaBancoDadosMYSQL }

function TAtualizaBancoDadosMYSQL.AtualizarBancoDeDadosMYSQL: Boolean;
var oAtualizarDB:TAtualizaBancoDados;
    oTabela: TAtualizacaoTableMYSQL;
    oCampo : TAtualizacaoCampoMYSQL;
begin
Try
    //Classe Principal de Atualização
    oAtualizarDB := TAtualizaBancoDados.Create(ConexaoDB);

        //Sub-Class de Atualização
    oTabela := TAtualizacaoTableMYSQL.Create(ConexaoDB);
    oCampo  := TAtualizacaoCampoMYSQL.Create(ConexaoDB);

  Finally
  FreeAndNil(oTabela);
  FreeAndNil(oAtualizarDB);
End;

end;

constructor TAtualizaBancoDadosMYSQL.Create(aConexao: TZConnection);
begin
   ConexaoDB:=aConexao;
end;

end.
