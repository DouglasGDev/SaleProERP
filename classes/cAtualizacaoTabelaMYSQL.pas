unit cAtualizacaoTabelaMYSQL;

interface

uses
  System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, cAtualizacaoBancoDeDados, cCadUsuario, uDTMConexao;

type
  TAtualizacaoTableMYSQL = class(TAtualizaBancoDados)
  private
    function TabelaExiste(aNomeTabela: String): Boolean;
    function ProcedureExiste(aNomeProcedure: String): Boolean;
    procedure Categoria;
    procedure Cliente;
    procedure Filial;
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
    procedure CriarTriggersLog;
    function TriggerExiste(aNomeTrigger: String): Boolean;
    procedure Orcamentos;
    procedure Itens_orcamento;

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
  Filial;
  Produto;
  seq_entrada;
  EntradaNota;
  Itens_EntradaNota;
  Orcamentos;
  Itens_orcamento;
  Vendas;
  VendasItens;
  Usuario;
  AcaoAcesso;
  UsuariosAcaoAcesso;
  CriarProcedures; // Adicionado para criar os procedimentos armazenados
  CriarTriggersLog;
end;

destructor TAtualizacaoTableMYSQL.Destroy;
begin
  inherited;
end;

function TAtualizacaoTableMYSQL.TriggerExiste(aNomeTrigger: String): Boolean;
var
  Qry: TZQuery;
begin
  Result := False;
  Qry := TZQuery.Create(nil);
  try
    Qry.Connection := ConexaoDB;
    Qry.SQL.Text := 'SHOW TRIGGERS';
    Qry.Open;

    while not Qry.Eof do
    begin
      if Qry.FieldByName('Trigger').AsString = aNomeTrigger then
      begin
        Result := True;
        Break;
      end;
      Qry.Next;
    end;
  finally
    Qry.Close;
    Qry.Free;
  end;
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
  if not ProcedureExiste('get_next_seq_entrada') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE PROCEDURE get_next_seq_entrada(OUT seq_value VARCHAR(50)) ' +
      'BEGIN ' +
      'DECLARE seq_id INT; ' +
      'INSERT INTO seq_entradanota () VALUES (); ' +
      'SET seq_id = LAST_INSERT_ID(); ' +
      'SET seq_value = LPAD(seq_id, 5, ''0''); ' +
      'END;'
    );
  end;
  if not ProcedureExiste('sp_GravarEntrada') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE PROCEDURE sp_GravarEntrada( ' +
      'IN pEntradaId VARCHAR(50), ' +
      'IN pDataEntrada DATE, ' +
      'IN pNumNotaFiscal VARCHAR(50), ' +
      'IN pNumPedido INT, ' +
      'IN pFornecedorId INT, ' +
      'IN pValorTotalNota DECIMAL(10,2), ' +
      'OUT pNovoEntradaId VARCHAR(50) ' +
      ') ' +
      'BEGIN ' +
      'DECLARE vEntradaId VARCHAR(50); ' +
      'DECLARE vSequencia VARCHAR(50); ' +
      'CALL get_next_seq_entrada(vSequencia); ' +
      'SET pNovoEntradaId = CONCAT(''Entrada'', DATE_FORMAT(pDataEntrada, ''%Y%m%d''), pNumNotaFiscal, pNumPedido, vSequencia); ' +
      'SELECT entradaId INTO vEntradaId ' +
      'FROM entradanota ' +
      'WHERE entradaId = pEntradaId; ' +
      'IF vEntradaId IS NULL THEN ' +
      '    INSERT INTO entradanota (entradaId, dataentrada, numnotafiscal, numpedido, fornecedorId, valorTotalNota) ' +
      '    VALUES (pNovoEntradaId, pDataEntrada, pNumNotaFiscal, pNumPedido, pFornecedorId, pValorTotalNota); ' +
      'ELSE ' +
      '    SET pNovoEntradaId = pEntradaId; ' +
      '    UPDATE entradanota ' +
      '    SET dataentrada = pDataEntrada, ' +
      '        numnotafiscal = pNumNotaFiscal, ' +
      '        numpedido = pNumPedido, ' +
      '        fornecedorId = pFornecedorId, ' +
      '        valorTotalNota = pValorTotalNota ' +
      '    WHERE entradaId = pEntradaId; ' +
      'END IF; ' +
      'END ;'
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
      'CREATE PROCEDURE sp_RemoverItemEntrada( ' +
      'IN pEntradaId VARCHAR(50), ' +
      'IN pProdutoId INT ' +
      ') ' +
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
      'CREATE PROCEDURE sp_VerificarEstoqueAntesExclusao(   ' +
      'IN pEntradaId VARCHAR(50))                           ' +
      'BEGIN                                                ' +
      'DECLARE estoqueNegativo BOOLEAN DEFAULT FALSE;       ' +

      'SELECT IF(SUM(p.quantidade) - SUM(ie.quantidade) < 0, TRUE, FALSE) ' +
      'INTO estoqueNegativo                                               ' +
      'FROM itens_entradanota ie                                          ' +
      'JOIN produtos p ON ie.produtoId = p.produtoId                      ' +
      'WHERE ie.entradaId = pEntradaId;                                   ' +

      'IF estoqueNegativo THEN                                            ' +
      'SIGNAL SQLSTATE ''45000''                                            ' +
      'SET MESSAGE_TEXT = ''A exclus�o desta entrada causar� um estoque negativo.'';'+
      'END IF;'+
      'END'
    );
  end;

  if not ProcedureExiste('sp_ExcluirEntrada') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE PROCEDURE sp_ExcluirEntrada(  ' +
      'IN pEntradaId VARCHAR(50) ' +
      ')  ' +
      'BEGIN ' +
      // Atualiza o estoque antes de remover os itens da entrada
      'UPDATE produtos p ' +
      'JOIN itens_entradanota ie ON p.produtoId = ie.produtoId  ' +
      'SET p.quantidade = p.quantidade - ie.quantidade ' +
      'WHERE ie.entradaId = pEntradaId; ' +
      //Exclui os itens da entrada
      'DELETE FROM itens_entradanota WHERE entradaId = pEntradaId; ' +
      // Exclui a entrada
      'DELETE FROM entradanota WHERE entradaId = pEntradaId; ' +
      'END;'
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

procedure TAtualizacaoTableMYSQL.Filial;
begin
  if not TabelaExiste('filiais') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE `filiais` ( ' +
      '`filialId` INT(11) NOT NULL AUTO_INCREMENT, ' +
      '`numfilial` INT(11) NOT NULL, ' +
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
      'PRIMARY KEY (`filialId`) USING BTREE)'
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
      '`filialId` INT(11) NULL DEFAULT NULL, ' +
      'PRIMARY KEY (`produtoId`) USING BTREE, ' +
      'INDEX `FK_ProdutosCategorias` (`categoriaId`) USING BTREE, ' +
      'INDEX `FK_ProdutosFilial` (`filialId`) USING BTREE, ' +
      'CONSTRAINT `FK_ProdutosCategorias` FOREIGN KEY (`categoriaId`) REFERENCES `vendas`.`categorias` (`categoriaId`) ' +
      'CONSTRAINT `FK_ProdutosFilial` FOREIGN KEY (`filialId`) REFERENCES `vendas`.`filiais` (`filialId`)) '
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

procedure TAtualizacaoTableMYSQL.Orcamentos;
begin
  if not TabelaExiste('orcamentos') then
  begin
    ExecutaDiretoBancoDeDados(
    'CREATE TABLE orcamentos ( ' +
    'orcamentoId INT AUTO_INCREMENT PRIMARY KEY, ' +
    'clienteId INT NOT NULL, ' +
    'dataOrcamento DATETIME NOT NULL, ' +
    'totalOrcamento DECIMAL(18, 5) NOT NULL, ' +
    'CONSTRAINT fk_cliente FOREIGN KEY (clienteId) REFERENCES clientes(clienteId))'
    );
  end;
end;


procedure TAtualizacaoTableMYSQL.Itens_orcamento;
begin
  if not TabelaExiste('itens_orcamento') then
  begin
    ExecutaDiretoBancoDeDados(
    'CREATE TABLE itens_orcamento ( ' +
    'itemOrcamentoId INT(11) NOT NULL AUTO_INCREMENT, ' +
    'orcamentoId INT NOT NULL, ' +
    'produtoId INT NOT NULL, ' +
    'quantidade DECIMAL(18, 5) NOT NULL, ' +
    'valorUnitario DECIMAL(18, 5) NOT NULL, ' +
    'valorTotalProduto DECIMAL(18, 5) NOT NULL, ' +
    'PRIMARY KEY (itemOrcamentoId), ' +
    'CONSTRAINT fk_orcamento FOREIGN KEY (orcamentoId) REFERENCES orcamentos(orcamentoId), ' +
    'CONSTRAINT fk_produto FOREIGN KEY (produtoId) REFERENCES produtos(produtoId))'
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
      'CREATE TABLE seq_entradanota (' +
      'seq_id INT AUTO_INCREMENT PRIMARY KEY'+
      ')'
    );
  end;
end;




{$region 'LOGS'}

procedure TAtualizacaoTableMYSQL.CriarTriggersLog;
begin
  // Cria��o da tabela de logs se n�o existir
  if not TabelaExiste('alteracao_log') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE alteracao_log (' +
      'log_id INT AUTO_INCREMENT PRIMARY KEY, ' +
      'tabela_nome VARCHAR(255), ' +
      'operacao VARCHAR(10), ' +
      'registro_id VARCHAR(50), ' +
      'usuario VARCHAR(255), ' +
      'data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP, ' +
      'detalhes JSON);'
    );
  end;
  // Cria��o dos triggers para a tabela categorias
  if not TriggerExiste('trg_categorias_insert') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_categorias_insert ' +
      'AFTER INSERT ON categorias ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''categorias'', ''INSERT'', NEW.categoriaId, @logged_in_user, JSON_OBJECT(''novo_valor'', NEW.descricao)); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_categorias_update') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_categorias_update ' +
      'AFTER UPDATE ON categorias ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''categorias'', ''UPDATE'', NEW.categoriaId, @logged_in_user, JSON_OBJECT(''antigo_valor'', OLD.descricao, ''novo_valor'', NEW.descricao)); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_categorias_delete') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_categorias_delete ' +
      'AFTER DELETE ON categorias ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''categorias'', ''DELETE'', OLD.categoriaId, @logged_in_user, JSON_OBJECT(''valor_deletado'', OLD.descricao)); ' +
      'END;'
    );
  end;
  // Cria��o dos triggers para a tabela clientes
  if not TriggerExiste('trg_clientes_insert') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_clientes_insert ' +
      'AFTER INSERT ON clientes ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''clientes'', ''INSERT'', NEW.clienteId, @logged_in_user, JSON_OBJECT(''novo_valor'', ' +
      'JSON_OBJECT(''nome'', NEW.nome, ''endereco'', NEW.endereco, ''cidade'', NEW.cidade, ''bairro'', NEW.bairro, ''estado'', NEW.estado, ''cep'', NEW.cep, ''telefone'', NEW.telefone, ''email'', NEW.email, ''cpf'', NEW.cpf, ''dataNascimento'', NEW.dataNascimento))); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_clientes_update') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_clientes_update ' +
      'AFTER UPDATE ON clientes ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''clientes'', ''UPDATE'', NEW.clienteId, @logged_in_user, JSON_OBJECT(''antigo_valor'', ' +
      'JSON_OBJECT(''nome'', OLD.nome, ''endereco'', OLD.endereco, ''cidade'', OLD.cidade, ''bairro'', OLD.bairro, ''estado'', OLD.estado, ''cep'', OLD.cep, ' +
      ' ''telefone'', OLD.telefone, ''email'', OLD.email, ''cpf'', OLD.cpf, ''dataNascimento'', OLD.dataNascimento), ''novo_valor'', JSON_OBJECT(''nome'', NEW.nome, ' +
      ' ''endereco'', NEW.endereco, ''cidade'', NEW.cidade, ''bairro'', NEW.bairro, ''estado'', NEW.estado, ''cep'', NEW.cep, ''telefone'', NEW.telefone, ''email'', NEW.email, ''cpf'', NEW.cpf, ''dataNascimento'', NEW.dataNascimento))); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_clientes_delete') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_clientes_delete ' +
      'AFTER DELETE ON clientes ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''clientes'', ''DELETE'', OLD.clienteId, @logged_in_user, JSON_OBJECT(''valor_deletado'', ' +
      'JSON_OBJECT(''nome'', OLD.nome, ''endereco'', OLD.endereco, ''cidade'', OLD.cidade, ''bairro'', OLD.bairro, ''estado'', OLD.estado, ''cep'', OLD.cep, ''telefone'', OLD.telefone, ''email'', OLD.email, ''cpf'', OLD.cpf, ''dataNascimento'', OLD.dataNascimento))); ' +
      'END;'
    );
  end;
  // Cria��o dos triggers para a tabela produtos
  if not TriggerExiste('trg_produtos_insert') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_produtos_insert ' +
      'AFTER INSERT ON produtos ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''produtos'', ''INSERT'', NEW.produtoId, @logged_in_user, JSON_OBJECT(''novo_valor'', ' +
      'JSON_OBJECT(''nome'', NEW.nome, ''descricao'', NEW.descricao, ''custo'', NEW.custo, ''valor'', NEW.valor, ' +
      '''quantidade'', NEW.quantidade, ''qtminima'', NEW.qtminima, ''codbarras'', NEW.codbarras, ''validade'', NEW.validade, ''foto'', NEW.foto, ''categoriaId'', NEW.categoriaId, ''filialId'', NEW.filialId))); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_produtos_update') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_produtos_update ' +
      'AFTER UPDATE ON produtos ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''produtos'', ''UPDATE'', NEW.produtoId, @logged_in_user, ' +
      'JSON_OBJECT(''antigo_valor'', JSON_OBJECT(''nome'', OLD.nome, ''descricao'', OLD.descricao, ''custo'', OLD.custo, ''valor'', OLD.valor, ' +
      '''quantidade'', OLD.quantidade, ''qtminima'', OLD.qtminima, ''codbarras'', OLD.codbarras, ''validade'', OLD.validade, ''foto'', OLD.foto, ''categoriaId'', OLD.categoriaId, ''filialId'', OLD.filialId), ' +
      '''novo_valor'', JSON_OBJECT(''nome'', NEW.nome, ''descricao'', NEW.descricao, ''custo'', NEW.custo, ''valor'', NEW.valor, ''quantidade'', NEW.quantidade, ''qtminima'', NEW.qtminima, ' +
      '''codbarras'', NEW.codbarras, ''validade'', NEW.validade, ''foto'', NEW.foto, ''categoriaId'', NEW.categoriaId, ''filialId'', NEW.filialId))); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_produtos_delete') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_produtos_delete ' +
      'AFTER DELETE ON produtos ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''produtos'', ''DELETE'', OLD.produtoId, @logged_in_user, JSON_OBJECT(''valor_deletado'', ' +
      'JSON_OBJECT(''nome'', OLD.nome, ''descricao'', OLD.descricao, ''custo'', OLD.custo, ''valor'', OLD.valor, ''quantidade'', OLD.quantidade, ' +
      '''qtminima'', OLD.qtminima, ''codbarras'', OLD.codbarras, ''validade'', OLD.validade, ''foto'', OLD.foto, ''categoriaId'', OLD.categoriaId, ''filialId'', OLD.filialId))); ' +
      'END;'
    );
  end;
  // Cria��o dos triggers para a tabela fornecedores
  if not TriggerExiste('trg_fornecedores_insert') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_fornecedores_insert ' +
      'AFTER INSERT ON fornecedores ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''fornecedores'', ''INSERT'', NEW.fornecedorId, @logged_in_user, ' +
      'JSON_OBJECT(''novo_valor'', JSON_OBJECT(''razaosocial'', NEW.razaosocial, ''fantasia'', NEW.fantasia, ''cnpj'', NEW.cnpj, ''endereco'', NEW.endereco, ' +
      ' ''bairro'', NEW.bairro, ''cep'', NEW.cep, ''cidade'', NEW.cidade, ''estado'', NEW.estado, ''complemento'', NEW.complemento, ' +
      ' ''inscricaoestadual'', NEW.inscricaoestadual, ''inscricaostatus'', NEW.inscricaostatus, ''telefone1'', NEW.telefone1, ''telefone2'', ' +
      'NEW.telefone2, ''situacaocadastral'', NEW.situacaocadastral, ''motivoscad'', NEW.motivoscad, ''email'', NEW.email, ''ramo'', NEW.ramo, ''observacao'', NEW.observacao))); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_fornecedores_update') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_fornecedores_update ' +
      'AFTER UPDATE ON fornecedores ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''fornecedores'', ''UPDATE'', NEW.fornecedorId, @logged_in_user, ' +
      'JSON_OBJECT(''antigo_valor'', JSON_OBJECT(''razaosocial'', OLD.razaosocial, ''fantasia'', OLD.fantasia, ' +
      '''cnpj'', OLD.cnpj, ''endereco'', OLD.endereco, ''bairro'', OLD.bairro, ''cep'', OLD.cep, ''cidade'', OLD.cidade, ' +
      ' ''estado'', OLD.estado, ''complemento'', OLD.complemento, ''inscricaoestadual'', OLD.inscricaoestadual, ' +
      ' ''inscricaostatus'', OLD.inscricaostatus, ''telefone1'', OLD.telefone1, ''telefone2'', OLD.telefone2, ''situacaocadastral'', OLD.situacaocadastral, ' +
      ' ''motivoscad'', OLD.motivoscad, ''email'', OLD.email, ''ramo'', OLD.ramo, ''observacao'', OLD.observacao), ''novo_valor'', JSON_OBJECT(''razaosocial'', NEW.razaosocial, ' +
      '''fantasia'', NEW.fantasia, ''cnpj'', NEW.cnpj, ''endereco'', NEW.endereco, ''bairro'', NEW.bairro, ''cep'', NEW.cep, ''cidade'', NEW.cidade, ''estado'', NEW.estado, ' +
      ' ''complemento'', NEW.complemento, ''inscricaoestadual'', NEW.inscricaoestadual, ''inscricaostatus'', NEW.inscricaostatus, ''telefone1'', NEW.telefone1, ''telefone2'', ' +
      'NEW.telefone2, ''situacaocadastral'', NEW.situacaocadastral, ''motivoscad'', NEW.motivoscad, ''email'', NEW.email, ''ramo'', NEW.ramo, ''observacao'', NEW.observacao))); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_fornecedores_delete') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_fornecedores_delete ' +
      'AFTER DELETE ON fornecedores ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''fornecedores'', ''DELETE'', OLD.fornecedorId, @logged_in_user, ' +
      'JSON_OBJECT(''valor_deletado'', JSON_OBJECT(''razaosocial'', OLD.razaosocial, ''fantasia'', OLD.fantasia, ' +
      ' ''cnpj'', OLD.cnpj, ''endereco'', OLD.endereco, ''bairro'', OLD.bairro, ''cep'', OLD.cep, ''cidade'', OLD.cidade, ' +
      ' ''estado'', OLD.estado, ''complemento'', OLD.complemento, ''inscricaoestadual'', OLD.inscricaoestadual, ''inscricaostatus'', OLD.inscricaostatus, ' +
      ' ''telefone1'', OLD.telefone1, ''telefone2'', OLD.telefone2, ''situacaocadastral'', OLD.situacaocadastral, ''motivoscad'', OLD.motivoscad, ''email'', OLD.email, ''ramo'', OLD.ramo, ''observacao'', OLD.observacao))); ' +
      'END;'
    );
  end;
  // Cria��o dos triggers para a tabela entradanota
  if not TriggerExiste('trg_entradanota_insert') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_entradanota_insert ' +
      'AFTER INSERT ON entradanota ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''entradanota'', ''INSERT'', NEW.entradaId, @logged_in_user, JSON_OBJECT(''novo_valor'', ' +
      'JSON_OBJECT(''dataentrada'', NEW.dataentrada, ''numnotafiscal'', NEW.numnotafiscal, ''numpedido'', NEW.numpedido, ''fornecedorId'', NEW.fornecedorId, ''valorTotalNota'', NEW.valorTotalNota))); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_entradanota_update') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_entradanota_update ' +
      'AFTER UPDATE ON entradanota ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''entradanota'', ''UPDATE'', NEW.entradaId, @logged_in_user, JSON_OBJECT(''antigo_valor'', ' +
      'JSON_OBJECT(''dataentrada'', OLD.dataentrada, ''numnotafiscal'', OLD.numnotafiscal, ''numpedido'', OLD.numpedido, ''fornecedorId'', OLD.fornecedorId, ' +
      ' ''valorTotalNota'', OLD.valorTotalNota), ''novo_valor'', JSON_OBJECT(''dataentrada'', NEW.dataentrada, ''numnotafiscal'', NEW.numnotafiscal, ''numpedido'', NEW.numpedido, ''fornecedorId'', NEW.fornecedorId, ''valorTotalNota'', NEW.valorTotalNota))); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_entradanota_delete') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_entradanota_delete ' +
      'AFTER DELETE ON entradanota ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''entradanota'', ''DELETE'', OLD.entradaId, @logged_in_user, JSON_OBJECT(''valor_deletado'', ' +
      'JSON_OBJECT(''dataentrada'', OLD.dataentrada, ''numnotafiscal'', OLD.numnotafiscal, ''numpedido'', OLD.numpedido, ''fornecedorId'', OLD.fornecedorId, ''valorTotalNota'', OLD.valorTotalNota))); ' +
      'END;'
    );
  end;
  // Cria��o dos triggers para a tabela itens_entradanota
  if not TriggerExiste('trg_itens_entradanota_insert') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_itens_entradanota_insert ' +
      'AFTER INSERT ON itens_entradanota ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''itens_entradanota'', ''INSERT'', CONCAT(NEW.entradaId, ''_'', NEW.produtoId), @logged_in_user, JSON_OBJECT(''novo_valor'', JSON_OBJECT(''entradaId'', NEW.entradaId, ''produtoId'', NEW.produtoId, ''quantidade'', NEW.quantidade))); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_itens_entradanota_update') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_itens_entradanota_update ' +
      'AFTER UPDATE ON itens_entradanota ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''itens_entradanota'', ''UPDATE'', CONCAT(NEW.entradaId, ''_'', NEW.produtoId), @logged_in_user, ' +
      'JSON_OBJECT(''antigo_valor'', JSON_OBJECT(''entradaId'', OLD.entradaId, ''produtoId'', OLD.produtoId, ''quantidade'', OLD.quantidade), ''novo_valor'', JSON_OBJECT(''entradaId'', NEW.entradaId, ''produtoId'', NEW.produtoId, ''quantidade'', NEW.quantidade))); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_itens_entradanota_delete') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_itens_entradanota_delete ' +
      'AFTER DELETE ON itens_entradanota ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''itens_entradanota'', ''DELETE'', CONCAT(OLD.entradaId, ''_'', OLD.produtoId), @logged_in_user, JSON_OBJECT(''valor_deletado'', JSON_OBJECT(''entradaId'', OLD.entradaId, ''produtoId'', OLD.produtoId, ''quantidade'', OLD.quantidade))); ' +
      'END;'
    );
  end;
  // Cria��o dos triggers para a tabela vendas
  if not TriggerExiste('trg_vendas_insert') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_vendas_insert ' +
      'AFTER INSERT ON vendas ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''vendas'', ''INSERT'', NEW.vendaId, @logged_in_user, JSON_OBJECT(''novo_valor'', ' +
      ' JSON_OBJECT(''clienteId'', NEW.clienteId, ''pix'', NEW.pix, ''credito'', NEW.credito, ''debito'', NEW.debito, ''dinheiro'', NEW.dinheiro, ''dataVenda'', NEW.dataVenda, ''totalVenda'', NEW.totalVenda))); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_vendas_update') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_vendas_update ' +
      'AFTER UPDATE ON vendas ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''vendas'', ''UPDATE'', NEW.vendaId, @logged_in_user, JSON_OBJECT(''antigo_valor'', ' +
      'JSON_OBJECT(''clienteId'', OLD.clienteId, ''pix'', OLD.pix, ''credito'', OLD.credito, ''debito'', OLD.debito, ''dinheiro'', OLD.dinheiro, ' +
      '''dataVenda'', OLD.dataVenda, ''totalVenda'', OLD.totalVenda), ''novo_valor'', JSON_OBJECT(''clienteId'', NEW.clienteId, ''pix'', NEW.pix, ''credito'', NEW.credito, ' +
      '''debito'', NEW.debito, ''dinheiro'', NEW.dinheiro, ''dataVenda'', NEW.dataVenda, ''totalVenda'', NEW.totalVenda))); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_vendas_delete') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_vendas_delete ' +
      'AFTER DELETE ON vendas ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''vendas'', ''DELETE'', OLD.vendaId, @logged_in_user, ' +
      'JSON_OBJECT(''valor_deletado'', JSON_OBJECT(''clienteId'', OLD.clienteId, ''pix'', OLD.pix, ''credito'', OLD.credito, ''debito'', OLD.debito, ''dinheiro'', OLD.dinheiro, ''dataVenda'', OLD.dataVenda, ''totalVenda'', OLD.totalVenda))); ' +
      'END;'
    );
  end;
  // Cria��o dos triggers para a tabela vendasitens
  if not TriggerExiste('trg_vendasitens_insert') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_vendasitens_insert ' +
      'AFTER INSERT ON vendasitens ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''vendasitens'', ''INSERT'', CONCAT(NEW.vendaId, ''_'', NEW.produtoId), @logged_in_user, ' +
      'JSON_OBJECT(''novo_valor'', JSON_OBJECT(''vendaId'', NEW.vendaId, ''produtoId'', NEW.produtoId, ''valorUnitario'', NEW.valorUnitario, ''quantidade'', NEW.quantidade, ''totalProduto'', NEW.totalProduto))); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_vendasitens_update') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_vendasitens_update ' +
      'AFTER UPDATE ON vendasitens ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''vendasitens'', ''UPDATE'', CONCAT(NEW.vendaId, ''_'', NEW.produtoId), @logged_in_user, ' +
      'JSON_OBJECT(''antigo_valor'', JSON_OBJECT(''vendaId'', OLD.vendaId, ''produtoId'', OLD.produtoId, ''valorUnitario'', OLD.valorUnitario, ' +
      ' ''quantidade'', OLD.quantidade, ''totalProduto'', OLD.totalProduto), ''novo_valor'', JSON_OBJECT(''vendaId'', NEW.vendaId, ''produtoId'', NEW.produtoId, ''valorUnitario'', NEW.valorUnitario, ''quantidade'', NEW.quantidade, ''totalProduto'', NEW.totalProduto))); ' +
      'END;'
    );
  end;
  if not TriggerExiste('trg_vendasitens_delete') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TRIGGER trg_vendasitens_delete ' +
      'AFTER DELETE ON vendasitens ' +
      'FOR EACH ROW ' +
      'BEGIN ' +
      'INSERT INTO alteracao_log (tabela_nome, operacao, registro_id, usuario, detalhes) ' +
      'VALUES (''vendasitens'', ''DELETE'', CONCAT(OLD.vendaId, ''_'', OLD.produtoId), @logged_in_user, ' +
      'JSON_OBJECT(''valor_deletado'', JSON_OBJECT(''vendaId'', OLD.vendaId, ''produtoId'', OLD.produtoId, ''valorUnitario'', OLD.valorUnitario, ''quantidade'', OLD.quantidade, ''totalProduto'', OLD.totalProduto))); ' +
      'END;'
    );
  end;
end;


{$endregion}

end.

