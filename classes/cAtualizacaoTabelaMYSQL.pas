unit cAtualizacaoTabelaMYSQL;

interface

uses
  System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, cAtualizacaoBancoDeDados, cCadUsuario;

type
  TAtualizacaoTableMYSQL = class(TAtualizaBancoDados)
  private
    function TabelaExiste(aNomeTabela: String): Boolean;
    function ProcedureExiste(aNomeProcedure: String): Boolean;
    procedure Categoria;
    procedure Cliente;
    procedure Produto;
    procedure Vendas;
    procedure VendasItens;
    procedure Usuario;
    procedure AcaoAcesso;
    procedure UsuariosAcaoAcesso;
    procedure Fornecedor;
    procedure EntradaNota;
    procedure Itens_EntradaNota;
    procedure seq_entrada;
    procedure CriarProcedures;

  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
  end;

implementation

{ TAtualizacaoTableMYSQL }

constructor TAtualizacaoTableMYSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
  Categoria;
  Cliente;
  Fornecedor;
  Produto;
  seq_entrada;
  EntradaNota;
  Itens_EntradaNota;
  Vendas;
  VendasItens;
  Usuario;
  AcaoAcesso;
  UsuariosAcaoAcesso;
  CriarProcedures; // Adicionado para criar os procedimentos armazenados
end;

destructor TAtualizacaoTableMYSQL.Destroy;
begin
  inherited;
end;

function TAtualizacaoTableMYSQL.TabelaExiste(aNomeTabela: String): Boolean; // adaptado pro mysql
var
  Qry: TZQuery;
begin
  try
    Result := False;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SHOW TABLES LIKE :NomeTabela');
    Qry.ParamByName('NomeTabela').AsString := aNomeTabela;
    Qry.Open;

    Result := not Qry.IsEmpty;
  finally
    Qry.Close;
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TAtualizacaoTableMYSQL.ProcedureExiste(aNomeProcedure: String): Boolean; // adaptado pro mysql
var
  Qry: TZQuery;
begin
  try
    Result := False;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SHOW PROCEDURE STATUS WHERE Name = :NomeProcedure');
    Qry.ParamByName('NomeProcedure').AsString := aNomeProcedure;
    Qry.Open;

    Result := not Qry.IsEmpty;
  finally
    Qry.Close;
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

procedure TAtualizacaoTableMYSQL.CriarProcedures;
begin
  if not ProcedureExiste('sp_GravarEntrada') then
  begin
    ExecutaDiretoBancoDeDados(
    'CREATE PROCEDURE sp_GravarEntrada(  '+
    'IN pEntradaId VARCHAR(50),          '+
    'IN pDataEntrada DATE,               '+
    'IN pNumNotaFiscal VARCHAR(50),      '+
    'IN pNumPedido INT,                  '+
    'IN pFornecedorId INT,               '+
    'IN pValorTotalNota DECIMAL,         '+
    'OUT pNovoEntradaId VARCHAR(50)      '+
    ')                                   '+
    'BEGIN                               '+
    'DECLARE vEntradaId VARCHAR(50);     '+
    'DECLARE vSequencia INT;             '+

    'SELECT entradaId INTO vEntradaId FROM entradanota WHERE entradaId = pEntradaId; '+

    'IF vEntradaId IS NULL THEN                                                      '+
    '    SELECT NEXT VALUE FOR seq_entradanota INTO vSequencia; '+
    '    SET pNovoEntradaId = CONCAT(''Entrada'' , DATE_FORMAT(pDataEntrada, ''%Y%m%d''), pNumNotaFiscal, pNumPedido, LPAD(vSequencia, 5, ''0''));'+
    '    INSERT INTO entradanota (entradaId, dataentrada, numnotafiscal, numpedido, fornecedorId, valorTotalNota)'+
    '    VALUES (pNovoEntradaId, pDataEntrada, pNumNotaFiscal, pNumPedido, pFornecedorId, pValorTotalNota);'+
    'ELSE  '+
    '    SET pNovoEntradaId = pEntradaId;'+
    '    UPDATE entradanota  '+
    '    SET dataentrada = pDataEntrada,'+
    '        numnotafiscal = pNumNotaFiscal, '+
    '        numpedido = pNumPedido, '+
    '        fornecedorId = pFornecedorId, '+
    '        valorTotalNota = pValorTotalNota '+
    '    WHERE entradaId = pEntradaId;'+
    'END IF; '+
'END;'
    );
  end;

  if not ProcedureExiste('sp_GravarItensEntrada') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE PROCEDURE sp_GravarItensEntrada(' +
      'IN pEntradaId VARCHAR(50), ' +
      'IN pProdutoId INT, ' +
      'IN pQuantidade DOUBLE) ' +
      'BEGIN ' +
      'DECLARE vQuantidadeAtual DOUBLE; ' +
      'SELECT quantidade INTO vQuantidadeAtual ' +
      'FROM itens_entradanota ' +
      'WHERE entradaId = pEntradaId AND produtoId = pProdutoId; ' +
      'IF vQuantidadeAtual IS NULL THEN ' +
      'INSERT INTO itens_entradanota (entradaId, produtoId, quantidade) ' +
      'VALUES (pEntradaId, pProdutoId, pQuantidade); ' +
      'UPDATE produtos ' +
      'SET quantidade = quantidade + pQuantidade ' +
      'WHERE produtoId = pProdutoId; ' +
      'ELSE ' +
      'UPDATE itens_entradanota ' +
      'SET quantidade = pQuantidade ' +
      'WHERE entradaId = pEntradaId AND produtoId = pProdutoId; ' +
      'UPDATE produtos ' +
      'SET quantidade = quantidade + (pQuantidade - vQuantidadeAtual) ' +
      'WHERE produtoId = pProdutoId; ' +
      'END IF; ' +
      'END;'
    );
  end;

  if not ProcedureExiste('sp_RemoverItemEntrada') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE PROCEDURE sp_RemoverItemEntrada(' +
      'IN pEntradaId VARCHAR(50), ' +
      'IN pProdutoId INT) ' +
      'BEGIN ' +
      'DECLARE vQuantidade DOUBLE; ' +
      'SELECT quantidade INTO vQuantidade ' +
      'FROM itens_entradanota ' +
      'WHERE entradaId = pEntradaId AND produtoId = pProdutoId; ' +
      'DELETE FROM itens_entradanota ' +
      'WHERE entradaId = pEntradaId AND produtoId = pProdutoId; ' +
      'UPDATE produtos ' +
      'SET quantidade = quantidade - vQuantidade ' +
      'WHERE produtoId = pProdutoId; ' +
      'END;'
    );
  end;


  if not ProcedureExiste('sp_VerificarEstoqueAntesExclusao') then
  begin
    ExecutaDiretoBancoDeDados(
     'CREATE PROCEDURE sp_VerificarEstoqueAntesExclusao(   '+
     'IN pEntradaId VARCHAR(50))                           '+
     'BEGIN                                                '+
     'DECLARE estoqueNegativo BOOLEAN DEFAULT FALSE;       '+

     'SELECT IF(SUM(p.quantidade) - SUM(ie.quantidade) < 0, TRUE, FALSE) '+
     'INTO estoqueNegativo                                               '+
     'FROM itens_entradanota ie                                          '+
     'JOIN produtos p ON ie.produtoId = p.produtoId                      '+
     'WHERE ie.entradaId = pEntradaId;                                   '+

     'IF estoqueNegativo THEN                                            '+
     'SIGNAL SQLSTATE ''45000''                                            '+
     'SET MESSAGE_TEXT = ''A exclus�o desta entrada causar� um estoque negativo.'';'+
     'END IF;'+
     'END'
   );
  end;

if not ProcedureExiste('sp_ExcluirEntrada') then
begin
  ExecutaDiretoBancoDeDados(
    'CREATE PROCEDURE sp_ExcluirEntrada( ' +
    'IN pEntradaId VARCHAR(50)) ' +
    'BEGIN ' +
    // Atualiza o estoque antes de remover os itens da entrada
    'UPDATE produtos p '+
    'JOIN itens_entradanota ie ON p.produtoId = ie.produtoId '+
    'SET p.quantidade = p.quantidade - ie.quantidade '+
    'WHERE ie.entradaId = pEntradaId; '+

    // Exclui os itens da entrada
    'DELETE FROM itens_entradanota WHERE entradaId = pEntradaId; '+

   // Exclui a entrada
    'DELETE FROM entradanota WHERE entradaId = pEntradaId; '+
    'END'
  );
end;




end;

procedure TAtualizacaoTableMYSQL.AcaoAcesso;
begin
  if not TabelaExiste('acaoAcesso') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE `acaoAcesso` ( ' +
      'acaoAcessoId INT(11) NOT NULL AUTO_INCREMENT, ' +
      '`descricao` VARCHAR(100) NOT NULL, ' +
      '`chave` VARCHAR(60) NOT NULL, ' +
      'PRIMARY KEY (acaoAcessoId) USING BTREE )'
    );
  end;
end;

procedure TAtualizacaoTableMYSQL.Categoria;
begin
  if not TabelaExiste('categorias') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE `categorias` ( ' +
      '`categoriaId` INT(11) NOT NULL AUTO_INCREMENT, ' +
      '`descricao` VARCHAR(100) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      'PRIMARY KEY (`categoriaId`) USING BTREE )'
    );
  end;
end;

procedure TAtualizacaoTableMYSQL.Cliente;
begin
  if not TabelaExiste('clientes') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE `clientes` ( ' +
      '`clienteId` INT(11) NOT NULL AUTO_INCREMENT, ' +
      '`nome` VARCHAR(60) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`endereco` VARCHAR(60) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`cidade` VARCHAR(50) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`bairro` VARCHAR(40) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`estado` VARCHAR(2) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`cep` VARCHAR(10) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`telefone` VARCHAR(14) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`email` VARCHAR(100) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`cpf` VARCHAR(14) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`dataNascimento` DATETIME NULL DEFAULT NULL, ' +
      'PRIMARY KEY (`clienteId`) USING BTREE )'
    );
  end;
end;

procedure TAtualizacaoTableMYSQL.Fornecedor;
begin
  if not TabelaExiste('fornecedores') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE `fornecedores` ( ' +
      '`fornecedorId` INT(11) NOT NULL AUTO_INCREMENT, ' +
      '`razaosocial` VARCHAR(255) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`fantasia` VARCHAR(255) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`cnpj` VARCHAR(18) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`endereco` VARCHAR(255) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`bairro` VARCHAR(255) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`cep` VARCHAR(10) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`cidade` VARCHAR(255) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`estado` VARCHAR(2) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`complemento` VARCHAR(255) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`inscricaoestadual` VARCHAR(255) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`inscricaostatus` VARCHAR(255) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`telefone1` VARCHAR(15) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`telefone2` VARCHAR(15) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`situacaocadastral` VARCHAR(255) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`motivoscad` VARCHAR(255) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`email` VARCHAR(255) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`ramo` VARCHAR(255) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`observacao` VARCHAR(255) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      'PRIMARY KEY (`fornecedorId`) USING BTREE)'
    );
  end;
end;

procedure TAtualizacaoTableMYSQL.Produto;
begin
  if not TabelaExiste('produtos') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE `produtos` ( ' +
      '`produtoId` INT(11) NOT NULL AUTO_INCREMENT, ' +
      '`nome` VARCHAR(60) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`descricao` VARCHAR(255) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`custo` DECIMAL(18,5) NULL DEFAULT ''0.00000'', ' +
      '`valor` DECIMAL(18,5) NULL DEFAULT ''0.00000'', ' +
      '`quantidade` DECIMAL(18,5) NULL DEFAULT ''0.00000'', ' +
      '`qtminima` DECIMAL(18,5) NULL DEFAULT ''0.00000'', ' +
      '`codbarras` VARCHAR(13) NULL DEFAULT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`validade` DATETIME NULL DEFAULT NULL, ' +
      '`foto` LONGBLOB NULL DEFAULT NULL, ' +
      '`categoriaId` INT(11) NULL DEFAULT NULL, ' +
      'PRIMARY KEY (`produtoId`) USING BTREE, ' +
      'INDEX `FK_ProdutosCategorias` (`categoriaId`) USING BTREE, ' +
      'CONSTRAINT `FK_ProdutosCategorias` FOREIGN KEY (`categoriaId`) REFERENCES `vendas`.`categorias` (`categoriaId`)) '
    );
  end;
end;

procedure TAtualizacaoTableMYSQL.EntradaNota;
begin
  if not TabelaExiste('entradanota') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE entradanota (' +
      'entradaId VARCHAR(50) NOT NULL DEFAULT '''', ' +
      'dataentrada DATETIME NOT NULL DEFAULT current_timestamp(), ' +
      'numnotafiscal VARCHAR(50) NULL DEFAULT NULL, ' +
      'numpedido INT(11) NULL DEFAULT NULL, ' +
      'fornecedorId INT(11) NOT NULL, ' +
      '`valorTotalNota` DECIMAL(18,5) NULL DEFAULT NULL, ' +
      'PRIMARY KEY (entradaId) USING BTREE, ' +
      'INDEX FK_fornecedorId (fornecedorId) USING BTREE, ' +
      'CONSTRAINT FK_fornecedorId FOREIGN KEY (fornecedorId) REFERENCES fornecedores (fornecedorId) ON UPDATE NO ACTION ON DELETE NO ACTION)'
    );
  end;
end;

procedure TAtualizacaoTableMYSQL.Itens_EntradaNota;
begin
  if not TabelaExiste('itens_entradanota') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE itens_entradanota (' +
      'entradaId VARCHAR(50) NOT NULL, ' +
      'produtoId INT(11) NOT NULL, ' +
      'quantidade DECIMAL(18,5) NULL DEFAULT ''0.00000'', ' +
      'INDEX FK_produtoId (produtoId) USING BTREE, ' +
      'CONSTRAINT FK_produtoId FOREIGN KEY (produtoId) REFERENCES produtos (produtoId) ON UPDATE NO ACTION ON DELETE NO ACTION, ' +
      'CONSTRAINT FK_entradaId FOREIGN KEY (entradaId) REFERENCES entradanota (entradaId) ON UPDATE NO ACTION ON DELETE CASCADE)'
    );
  end;
end;

procedure TAtualizacaoTableMYSQL.Vendas;
begin
  if not TabelaExiste('vendas') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE `vendas` ( ' +
      '`vendaId` INT(11) NOT NULL AUTO_INCREMENT, ' +
      '`clienteId` INT(11) NOT NULL, ' +
      '`pix` DECIMAL(18,5) NOT NULL DEFAULT ''0.00000'', ' +
      '`credito` DECIMAL(18,5) NOT NULL DEFAULT ''0.00000'', ' +
      '`debito` DECIMAL(18,5) NOT NULL DEFAULT ''0.00000'', ' +
      '`dinheiro` DECIMAL(18,5) NOT NULL DEFAULT ''0.00000'', ' +
      '`dataVenda` DATETIME NOT NULL DEFAULT current_timestamp(), ' +
      '`totalVenda` DECIMAL(18,5) NOT NULL DEFAULT ''0.00000'', ' +
      'PRIMARY KEY (`vendaId`) USING BTREE, ' +
      'INDEX `FK_VendasClientes` (`clienteId`) USING BTREE, ' +
      'CONSTRAINT `FK_VendasClientes` FOREIGN KEY (`clienteId`) REFERENCES `vendas`.`clientes` (`clienteId`) ON UPDATE RESTRICT ON DELETE RESTRICT)'
    );
  end;
end;

procedure TAtualizacaoTableMYSQL.VendasItens;
begin
  if not TabelaExiste('vendasItens') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE `vendasitens` ( ' +
      '`vendaId` INT(11) NOT NULL, ' +
      '`produtoId` INT(11) NOT NULL, ' +
      '`valorUnitario` DECIMAL(18,5) NULL DEFAULT ''0.00000'', ' +
      '`quantidade` DECIMAL(18,5) NULL DEFAULT ''0.00000'', ' +
      '`totalProduto` DECIMAL(18,5) NULL DEFAULT ''0.00000'', ' +
      'PRIMARY KEY (`vendaId`, `produtoId`) USING BTREE, ' +
      'INDEX `FK_VendasItensProdutos` (`produtoId`) USING BTREE, ' +
      'CONSTRAINT `FK_VendasItensProdutos` FOREIGN KEY (`produtoId`) REFERENCES `vendas`.`produtos` (`produtoId`) )'
    );
  end;
end;

procedure TAtualizacaoTableMYSQL.Usuario;
var
  oUsuario: TUsuario;
begin
  if not TabelaExiste('usuarios') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE `usuarios` ( ' +
      '`usuarioId` INT(11) NOT NULL AUTO_INCREMENT, ' +
      '`nome` VARCHAR(50) NOT NULL COLLATE ''utf8mb4_general_ci'', ' +
      '`senha` VARCHAR(40) NOT NULL COLLATE ''utf8mb4_general_ci'', ' +
      'PRIMARY KEY (`usuarioId`) USING BTREE)'
    );
  end;

  try
    oUsuario := TUsuario.Create(ConexaoDB);
    oUsuario.nome := 'ADMIN';
    oUsuario.senha := 'padrao';
    if not oUsuario.UsuarioExiste(oUsuario.nome) then
      oUsuario.Inserir;
  finally
    if Assigned(oUsuario) then
      FreeAndNil(oUsuario);
  end;
end;

procedure TAtualizacaoTableMYSQL.UsuariosAcaoAcesso;
begin
  if not TabelaExiste('usuariosAcaoAcesso') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE `usuariosacaoacesso` ( ' +
      '`usuarioId` INT(11) NOT NULL, ' +
      '`acaoAcessoId` INT(11) NOT NULL, ' +
      '`ativo` BIT(1) NOT NULL DEFAULT b''1'', ' +
      'PRIMARY KEY (`usuarioId`, `acaoAcessoId`) USING BTREE, ' +
      'INDEX `FK_UsuarioAcaoAcessoAcaoAcesso` (`acaoAcessoId`) USING BTREE, ' +
      'CONSTRAINT `FK_UsuarioAcaoAcessoAcaoAcesso` FOREIGN KEY (`acaoAcessoId`) REFERENCES `vendas`.`acaoacesso` (`acaoAcessoId`) ON UPDATE RESTRICT ON DELETE RESTRICT, ' +
      'CONSTRAINT `FK_UsuarioAcaoAcessoUsuario` FOREIGN KEY (`usuarioId`) REFERENCES `vendas`.`usuarios` (`usuarioId`) ON UPDATE RESTRICT ON DELETE RESTRICT)'
    );
  end;
end;

procedure TAtualizacaoTableMYSQL.seq_entrada;
begin
  if not TabelaExiste('seq_entradanota') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE SEQUENCE seq_entradanota ' +
      'START WITH 1 ' +
      'INCREMENT BY 1 ' +
      'CACHE 10 ' +
      'CYCLE'
    );
  end;
end;

end.

