unit uEntrada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  RxToolEdit, uDTMConexao, uDTMEntrada, cFuncao, uEnum, uConsultaFornecedor,
  uConsultaProduto, RxCurrEdit;

type
  TfrmEntrada = class(TfrmTelaHeranca)
    pnlHeader: TPanel;
    edtEntradaId: TLabeledEdit;
    lkpFornecedor: TDBLookupComboBox;
    lblCategoria: TLabel;
    btnAdicionarFornecedor: TSpeedButton;
    btnPesquisarFornecedor: TSpeedButton;
    edtNumNota: TLabeledEdit;
    edtNumPedido: TLabeledEdit;
    edtDataEntrada: TDateEdit;
    lblDataVenda: TLabel;
    lkpProduto: TDBLookupComboBox;
    lblProduto: TLabel;
    btnAdicionarProduto: TSpeedButton;
    btnPesquisarProduto: TSpeedButton;
    pnlAdicionar: TPanel;
    btnAdicionar: TSpeedButton;
    pnlRemover: TPanel;
    btnRemover: TSpeedButton;
    DBGrid1: TDBGrid;
    QryFornecedor: TZQuery;
    dtsFornecedor: TDataSource;
    QryProduto: TZQuery;
    dtsProduto: TDataSource;
    QryFornecedorfornecedorId: TZIntegerField;
    QryFornecedorrazaosocial: TZUnicodeStringField;
    edtQuantidade: TLabeledEdit;
    QryListagementradaId: TZUnicodeStringField;
    QryListagemdataentrada: TZDateTimeField;
    QryListagemnumnotafiscal: TZUnicodeStringField;
    QryListagemnumpedido: TZIntegerField;
    QryListagemfornecedorId: TZIntegerField;
    QryListagemrazaosocial: TZUnicodeStringField;
    QryListagemprodutoId: TZIntegerField;
    QryListagemnome_produto: TZUnicodeStringField;
    QryListagemquantidade: TZFMTBCDField;
    QryProdutoprodutoId: TZIntegerField;
    QryProdutonome: TZUnicodeStringField;
    pnlValorNota: TPanel;
    lblValorVenda: TLabel;
    edtTotalNota: TCurrencyEdit;
    QryProdutocusto: TZFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure btnAdicionarFornecedorClick(Sender: TObject);
    procedure btnAdicionarProdutoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure grdListagemCellClick(Column: TColumn);
    procedure btnPesquisarFornecedorClick(Sender: TObject);
    procedure btnPesquisarProdutoClick(Sender: TObject);
  private
    procedure LimparCampos;
    procedure ExcluirPedido(numpedido: Integer; numnotafiscal: string; fornecedorId: Integer);
    function GerarNovoEntradaId(data: TDateTime; numNotaFiscal, numPedido: string): string;
    function ObterProximaSequencia: Integer;
    function Apagar: Boolean; override;
    procedure CarregarProdutosRelacionados(entradaId: string);
    function GravarEntradaNota: string;
    procedure GravarItensEntradaNota(const novoEntradaId: string);
    function GerarNovoEntradaIdCompleto(data: TDateTime; numNotaFiscal,
      numPedido: string): string;
    function ObterProximaSequenciaItensEntrada: Integer;
    procedure ExcluirEntrada(entradaId: string);
    procedure RemoverItem;
  public
    { Public declarations }
  end;

var
  frmEntrada: TfrmEntrada;

implementation

{$R *.dfm}

uses uCadFornecedor, UPrincipal, uCadProduto;

procedure TfrmEntrada.btnAdicionarClick(Sender: TObject);
var
  produtoId: Integer;
  nomeProduto: string;
  quantidade: Double;
  custo: Double;
  valorTotal: Double;
  ProdutoJaAdicionado: Boolean;
  TotalNota: Double;
begin
  if lkpProduto.KeyValue <> Null then
  begin
    produtoId := lkpProduto.KeyValue;
    if QryProduto.Locate('produtoId', produtoId, []) then
    begin
      nomeProduto := QryProduto.FieldByName('nome').AsString;
      quantidade := StrToFloatDef(edtQuantidade.Text, 0);
      custo := QryProduto.FieldByName('custo').AsFloat;
      valorTotal := quantidade * custo;

      ProdutoJaAdicionado := dtmEntrada.cdsGridEntradaProdutoVirtual.Locate('produtoId', produtoId, []);
      if ProdutoJaAdicionado then
      begin
        dtmEntrada.cdsGridEntradaProdutoVirtual.Edit;
        dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('quantidade').AsFloat :=
          dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('quantidade').AsFloat + quantidade;
        dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('valorTotal').AsFloat :=
          dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('quantidade').AsFloat * dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('custo').AsFloat;
        dtmEntrada.cdsGridEntradaProdutoVirtual.Post;
      end
      else
      begin
        try
          if not dtmEntrada.cdsGridEntradaProdutoVirtual.Active then
            dtmEntrada.cdsGridEntradaProdutoVirtual.Open;
          dtmEntrada.cdsGridEntradaProdutoVirtual.Append;
          dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('produtoId').AsInteger := produtoId;
          dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('nome').AsString := nomeProduto;
          dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('quantidade').AsFloat := quantidade;
          dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('custo').AsFloat := custo;
          dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('valorTotal').AsFloat := valorTotal;
          dtmEntrada.cdsGridEntradaProdutoVirtual.Post;
          lkpFornecedor.Enabled := False;
        except
          on E: Exception do
          begin
            ShowMessage('Erro ao adicionar produto: ' + E.Message);
            dtmEntrada.cdsGridEntradaProdutoVirtual.Cancel;
          end;
        end;
      end;

      // Calcula o valor total da nota
      TotalNota := 0;
      dtmEntrada.cdsGridEntradaProdutoVirtual.DisableControls;
      try
        dtmEntrada.cdsGridEntradaProdutoVirtual.First;
        while not dtmEntrada.cdsGridEntradaProdutoVirtual.Eof do
        begin
          TotalNota := TotalNota + dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('valorTotal').AsFloat;
          dtmEntrada.cdsGridEntradaProdutoVirtual.Next;
        end;
      finally
        dtmEntrada.cdsGridEntradaProdutoVirtual.EnableControls;
      end;

      // Atualiza o campo com o valor total da nota
      edtTotalNota.Text := FormatFloat('0.00', TotalNota);

    end
    else
      ShowMessage('Erro: Produto n�o encontrado.');
  end
  else
    ShowMessage('Erro: Nenhum produto selecionado.');
end;


procedure TfrmEntrada.btnAdicionarFornecedorClick(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadFornecedor, oUsuarioLogado, DtmPrincipal.ConexaoDB);
  QryFornecedor.Refresh;
end;

procedure TfrmEntrada.btnAdicionarProdutoClick(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadProduto, oUsuarioLogado, DtmPrincipal.ConexaoDB);
  QryProduto.Refresh;
end;

procedure TfrmEntrada.btnAlterarClick(Sender: TObject);
var
  entradaId: string;
  QryDetalhes: TZQuery;
begin
  inherited;
  edtDataEntrada.Date := Date;

  if not QryListagem.IsEmpty then
  begin
    entradaId := QryListagem.FieldByName('entradaId').AsString;

    QryDetalhes := TZQuery.Create(nil);
    try
      QryDetalhes.Connection := DtmPrincipal.ConexaoDB;
      QryDetalhes.SQL.Text := 'SELECT * FROM entradanota WHERE entradaId = :entradaId';
      QryDetalhes.Params.ParamByName('entradaId').AsString := entradaId;
      QryDetalhes.Open;

      if not QryDetalhes.IsEmpty then
      begin
        edtEntradaId.Text := QryDetalhes.FieldByName('entradaId').AsString;
        edtDataEntrada.Text := DateToStr(QryDetalhes.FieldByName('dataentrada').AsDateTime);
        edtNumNota.Text := QryDetalhes.FieldByName('numnotafiscal').AsString;
        edtNumPedido.Text := QryDetalhes.FieldByName('numpedido').AsString;
        lkpFornecedor.KeyValue := QryDetalhes.FieldByName('fornecedorId').AsString;
        edtTotalNota.Text := QryDetalhes.FieldByName('valorTotalNota').AsString;
        CarregarProdutosRelacionados(entradaId);

        if EstadoDoCadastro = ecAlterar then
        begin
          if not dtmEntrada.cdsGridEntradaProdutoVirtual.IsEmpty then
            lkpFornecedor.Enabled := False
          else
            lkpFornecedor.Enabled := True;
        end;
      end;
    finally
      QryDetalhes.Free;
    end;
  end;
end;

procedure TfrmEntrada.RemoverItem;
begin
  if not dtmEntrada.cdsGridEntradaProdutoVirtual.IsEmpty then
  begin
    // Remover o item da tabela virtual
    dtmEntrada.cdsGridEntradaProdutoVirtual.Delete;

    if dtmEntrada.cdsGridEntradaProdutoVirtual.IsEmpty then
      lkpFornecedor.Enabled := True;
  end;
end;

procedure TfrmEntrada.ExcluirPedido(numpedido: Integer; numnotafiscal: string; fornecedorId: Integer);
var
  QryDelete: TZQuery;
begin
  try
    DtmPrincipal.ConexaoDB.StartTransaction;

    QryDelete := TZQuery.Create(nil);
    QryDelete.Connection := DtmPrincipal.ConexaoDB;
    QryDelete.SQL.Text := 'SELECT entradaId FROM entradanota WHERE numpedido = :numpedido AND numnotafiscal = :numnotafiscal AND fornecedorId = :fornecedorId';
    QryDelete.Params.ParamByName('numpedido').Value := numpedido;
    QryDelete.Params.ParamByName('numnotafiscal').Value := numnotafiscal;
    QryDelete.Params.ParamByName('fornecedorId').Value := fornecedorId;
    QryDelete.Open;

    if QryDelete.IsEmpty then
    begin
      ShowMessage('Nenhum registro foi encontrado para o pedido, nota fiscal e fornecedor selecionados.');
      Exit;
    end;

    if MessageDlg('Deseja realmente excluir o pedido n�mero ' + IntToStr(numpedido) + ' para o fornecedor com ID ' + IntToStr(fornecedorId) + ' e n�mero da nota fiscal ' + numnotafiscal + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      QryDelete.Close;
      QryDelete.SQL.Text := 'DELETE FROM entradanota WHERE numpedido = :numpedido AND numnotafiscal = :numnotafiscal AND fornecedorId = :fornecedorId';
      QryDelete.Params.ParamByName('numpedido').Value := numpedido;
      QryDelete.Params.ParamByName('numnotafiscal').Value := numnotafiscal;
      QryDelete.Params.ParamByName('fornecedorId').Value := fornecedorId;
      QryDelete.ExecSQL;

      if QryDelete.RowsAffected > 0 then
      begin
        DtmPrincipal.ConexaoDB.Commit;

        QryListagem.Close;
        QryListagem.Open;

        ShowMessage('Pedido exclu�do com sucesso.');
      end
      else
      begin
        DtmPrincipal.ConexaoDB.Rollback;
        ShowMessage('Nenhum registro foi exclu�do.');
      end;
    end
    else
    begin
      DtmPrincipal.ConexaoDB.Rollback;
    end;

    QryDelete.Free;
  except
    on E: Exception do
    begin
      DtmPrincipal.ConexaoDB.Rollback;
      ShowMessage('Erro ao excluir o pedido: ' + E.Message);
    end;
  end;
end;

procedure TfrmEntrada.btnApagarClick(Sender: TObject);
begin
  if not QryListagem.IsEmpty then
  begin
    var entradaId := QryListagem.FieldByName('entradaId').AsString;

    try
      var QryCheck := TZQuery.Create(nil);
      try
        QryCheck.Connection := DtmPrincipal.ConexaoDB;
        QryCheck.SQL.Text := 'CALL sp_VerificarEstoqueAntesExclusao(:entradaId)';
        QryCheck.Params.ParamByName('entradaId').AsString := entradaId;
        QryCheck.ExecSQL;

        // Se a verifica��o passar sem erro, prossegue com a exclus�o
        if MessageDlg('Deseja realmente excluir a entrada com o ID ' + entradaId + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          ExcluirEntrada(entradaId);
        end;
      finally
        QryCheck.Free;
      end;
    except
      on E: Exception do
        ShowMessage('Erro ao verificar o estoque: ' + E.Message);
    end;
  end
  else
    ShowMessage('Nenhum registro selecionado para exclus�o.');
end;


procedure TfrmEntrada.ExcluirEntrada(entradaId: string);
var
  Query: TZQuery;
begin
  try
    Query := TZQuery.Create(nil);
    try
      Query.Connection := DtmPrincipal.ConexaoDB;
      Query.SQL.Text := 'CALL sp_ExcluirEntrada(:entradaId)';
      Query.Params.ParamByName('entradaId').AsString := entradaId;
      Query.ExecSQL;
      // Fecha e abre novamente o DataSet
      QryListagem.Close;
      QryListagem.Open;
    finally
      Query.Free;
    end;
  except
    on E: Exception do
      ShowMessage('Ocorreu um erro ao excluir a entrada: ' + E.Message);
  end;
end;




function TfrmEntrada.GerarNovoEntradaId(data: TDateTime; numNotaFiscal, numPedido: string): string;
var
  QrySequencia: TZQuery;
  sequencia: Integer;
begin
  QrySequencia := TZQuery.Create(nil);
  try
    QrySequencia.Connection := DtmPrincipal.ConexaoDB;
    QrySequencia.SQL.Text := 'SELECT NEXT VALUE FOR seq_entradanota';
    QrySequencia.Open;
    sequencia := QrySequencia.FieldByName('NEXT VALUE FOR seq_entradanota').AsInteger;
  finally
    QrySequencia.Free;
  end;

  Result := 'Entrada' + FormatDateTime('yyyymmdd', data) + numNotaFiscal + numPedido + Format('%.*d', [5, sequencia]);
end;

function TfrmEntrada.GerarNovoEntradaIdCompleto(data: TDateTime; numNotaFiscal, numPedido: string): string;
begin
  Result := 'Entrada' + FormatDateTime('yyyymmdd', data) + numNotaFiscal + numPedido + GerarNovoEntradaId(data, numNotaFiscal, numPedido);
end;

procedure TfrmEntrada.grdListagemCellClick(Column: TColumn);
begin
  inherited;
  if not QryListagem.IsEmpty then
  begin
    var entradaIdSelecionado := QryListagem.FieldByName('entradaId').AsString;
    CarregarProdutosRelacionados(entradaIdSelecionado);
  end;
end;

procedure TfrmEntrada.CarregarProdutosRelacionados(entradaId: string);
var
  QryProdutos: TZQuery;
  Custo : Double;
begin
  dtmEntrada.cdsGridEntradaProdutoVirtual.Close;
  dtmEntrada.cdsGridEntradaProdutoVirtual.Open;
  dtmEntrada.cdsGridEntradaProdutoVirtual.EmptyDataSet;

  QryProdutos := TZQuery.Create(nil);
  try
    QryProdutos.Connection := DtmPrincipal.ConexaoDB;
    QryProdutos.SQL.Text := 'SELECT ie.*, p.nome FROM itens_entradanota ie ' +
                            'JOIN produtos p ON ie.produtoId = p.produtoId ' +
                            'WHERE ie.entradaId = :entradaId';
    QryProdutos.Params.ParamByName('entradaId').AsString := entradaId;
    QryProdutos.Open;

    while not QryProdutos.Eof do
    begin
      dtmEntrada.cdsGridEntradaProdutoVirtual.Append;
      dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('entradaId').AsString := QryProdutos.FieldByName('entradaId').AsString;
      dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('produtoId').AsInteger := QryProdutos.FieldByName('produtoId').AsInteger;
      dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('quantidade').AsFloat := QryProdutos.FieldByName('quantidade').AsFloat;
      dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('nome').AsString := QryProdutos.FieldByName('nome').AsString;
      dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('custo').AsFloat := QryProduto.FieldByName('custo').AsFloat;
      dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('valorTotal').AsFloat := (QryProdutos.FieldByName('quantidade').AsFloat) * (QryProduto.FieldByName('custo').AsFloat);
      dtmEntrada.cdsGridEntradaProdutoVirtual.Post;
      QryProdutos.Next;
    end;
  finally
    QryProdutos.Free;
  end;
end;


function TfrmEntrada.ObterProximaSequencia: Integer;
var
  QrySequencia: TZQuery;
begin
  QrySequencia := TZQuery.Create(nil);
  QrySequencia.Connection := DtmPrincipal.ConexaoDB;
  QrySequencia.SQL.Text := 'SELECT MAX(CAST(SUBSTRING(entradaId, LOCATE(entradaId) + 1) AS SIGNED)) + 1 AS proximoValor FROM entradanota';

  try
    QrySequencia.Open;
    Result := QrySequencia.FieldByName('proximoValor').AsInteger;
  finally
    QrySequencia.Free;
  end;
end;

procedure TfrmEntrada.btnGravarClick(Sender: TObject);
var
  novoEntradaId: string;
  QryDeleteItem: TZQuery;
  QryInsertItem: TZQuery;
  QryUpdateItem: TZQuery;
begin
  if not dtmEntrada.cdsGridEntradaProdutoVirtual.IsEmpty then
  begin
    try
      DtmPrincipal.ConexaoDB.StartTransaction;

      if edtEntradaId.Text = '' then
        novoEntradaId := GravarEntradaNota
      else
        novoEntradaId := edtEntradaId.Text;

      // Processar todos os itens na tabela virtual
      dtmEntrada.cdsGridEntradaProdutoVirtual.First;
      while not dtmEntrada.cdsGridEntradaProdutoVirtual.Eof do
      begin
        if dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('Status').AsString = 'Deleted' then
        begin
          // Remove o item do banco de dados
          QryDeleteItem := TZQuery.Create(nil);
          try
            QryDeleteItem.Connection := DtmPrincipal.ConexaoDB;
            QryDeleteItem.SQL.Text := 'CALL sp_RemoverItemEntrada(:entradaId, :produtoId)';
            QryDeleteItem.Params.ParamByName('entradaId').AsString := novoEntradaId;
            QryDeleteItem.Params.ParamByName('produtoId').AsInteger := dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('produtoId').AsInteger;
            QryDeleteItem.ExecSQL;
          finally
            QryDeleteItem.Free;
          end;
        end
        else if dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('Status').AsString = 'Modified' then
        begin
          // Atualiza o item no banco de dados
          QryUpdateItem := TZQuery.Create(nil);
          try
            QryUpdateItem.Connection := DtmPrincipal.ConexaoDB;
            QryUpdateItem.SQL.Text := 'CALL sp_AtualizarItemEntrada(:entradaId, :produtoId, :quantidade)';
            QryUpdateItem.Params.ParamByName('entradaId').AsString := novoEntradaId;
            QryUpdateItem.Params.ParamByName('produtoId').AsInteger := dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('produtoId').AsInteger;
            QryUpdateItem.Params.ParamByName('quantidade').AsFloat := dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('quantidade').AsFloat;
            QryUpdateItem.ExecSQL;
          finally
            QryUpdateItem.Free;
          end;
        end
        else
        begin
          // Insere o novo item no banco de dados
          QryInsertItem := TZQuery.Create(nil);
          try
            QryInsertItem.Connection := DtmPrincipal.ConexaoDB;
            QryInsertItem.SQL.Text := 'CALL sp_GravarItensEntrada(:entradaId, :produtoId, :quantidade)';
            QryInsertItem.Params.ParamByName('entradaId').AsString := novoEntradaId;
            QryInsertItem.Params.ParamByName('produtoId').AsInteger := dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('produtoId').AsInteger;
            QryInsertItem.Params.ParamByName('quantidade').AsFloat := dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('quantidade').AsFloat;
            QryInsertItem.ExecSQL;
          finally
            QryInsertItem.Free;
          end;
        end;
        dtmEntrada.cdsGridEntradaProdutoVirtual.Next;
      end;

      DtmPrincipal.ConexaoDB.Commit;

      ShowMessage('Entrada de mercadoria gravada com sucesso.');
      lkpFornecedor.Enabled := True;

      QryListagem.Close;
      QryListagem.Open;

      dtmEntrada.cdsGridEntradaProdutoVirtual.EmptyDataSet;
      LimparCampos;

      QryListagem.Close;
      QryListagem.Open;
    except
      on E: Exception do
      begin
        DtmPrincipal.ConexaoDB.Rollback;
        ShowMessage('Erro ao gravar a entrada de mercadoria: ' + E.Message);
      end;
    end;
  end
  else
    ShowMessage('N�o h� produtos adicionados para gravar a entrada de mercadoria.');
end;



function TfrmEntrada.GravarEntradaNota: string;
var
  QryInsert: TZQuery;
  novoEntradaId: string;
begin
  Result := '';
  QryInsert := TZQuery.Create(nil);
  try
    QryInsert.Connection := DtmPrincipal.ConexaoDB;
    QryInsert.SQL.Text := 'CALL sp_GravarEntrada(:entradaId, :dataentrada, :numnotafiscal, :numpedido, :fornecedorId, :valorTotalNota, @novoEntradaId)';
    QryInsert.Params.ParamByName('entradaId').AsString := GerarNovoEntradaId(edtDataEntrada.Date, edtNumNota.Text, edtNumPedido.Text);
    QryInsert.Params.ParamByName('dataentrada').Value := edtDataEntrada.Date;
    QryInsert.Params.ParamByName('numnotafiscal').Value := edtNumNota.Text;
    QryInsert.Params.ParamByName('numpedido').Value := StrToIntDef(edtNumPedido.Text, 0);
    QryInsert.Params.ParamByName('fornecedorId').Value := lkpFornecedor.KeyValue;
    QryInsert.Params.ParamByName('valorTotalNota').Value := edtTotalNota.Text;
    QryInsert.ExecSQL;

    // Capturar o valor da vari�vel de sa�da
    QryInsert.SQL.Text := 'SELECT @novoEntradaId AS novoEntradaId';
    QryInsert.Open;
    novoEntradaId := QryInsert.FieldByName('novoEntradaId').AsString;

    Result := novoEntradaId;
  finally
    QryInsert.Free;
  end;
end;





procedure TfrmEntrada.GravarItensEntradaNota(const novoEntradaId: string);
var
  QryInsertItem: TZQuery;
begin
  QryInsertItem := TZQuery.Create(nil);
  try
    QryInsertItem.Connection := DtmPrincipal.ConexaoDB;

    dtmEntrada.cdsGridEntradaProdutoVirtual.First;
    while not dtmEntrada.cdsGridEntradaProdutoVirtual.Eof do
    begin
      QryInsertItem.SQL.Text := 'CALL sp_GravarItensEntrada(:entradaId, :produtoId, :quantidade)';
      QryInsertItem.Params.ParamByName('entradaId').AsString := novoEntradaId;
      QryInsertItem.Params.ParamByName('produtoId').AsInteger := dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('produtoId').AsInteger;
      QryInsertItem.Params.ParamByName('quantidade').AsFloat := dtmEntrada.cdsGridEntradaProdutoVirtual.FieldByName('quantidade').AsFloat;
      QryInsertItem.ExecSQL;

      dtmEntrada.cdsGridEntradaProdutoVirtual.Next;
    end;
  finally
    QryInsertItem.Free;
  end;
end;





function TfrmEntrada.ObterProximaSequenciaItensEntrada: Integer;
var
  QrySequencia: TZQuery;
begin
  QrySequencia := TZQuery.Create(nil);
  QrySequencia.Connection := DtmPrincipal.ConexaoDB;
  QrySequencia.SQL.Text := 'SELECT MAX(CAST(SUBSTRING(itemEntradaId, LOCATE("ItemEntrada_", itemEntradaId) + 1) AS SIGNED)) + 1 AS proximoValor FROM itens_entradanota';

  try
    QrySequencia.Open;
    Result := QrySequencia.FieldByName('proximoValor').AsInteger;
  finally
    QrySequencia.Free;
  end;
end;

procedure TfrmEntrada.btnNovoClick(Sender: TObject);
begin
  inherited;
  lkpFornecedor.Enabled := True;
  LimparCampos;
  edtDataEntrada.Date := Date;
end;


procedure TfrmEntrada.btnPesquisarFornecedorClick(Sender: TObject);
begin
  inherited;
    TRY
  frmConsultaFornecedor:= TfrmConsultaFornecedor.Create(Self);

  if lkpFornecedor.KeyValue<>Null then
     frmConsultaFornecedor.aIniciarPesquisaId:=lkpFornecedor.KeyValue;

  frmConsultaFornecedor.ShowModal;

  if frmConsultaFornecedor.aRetornarIdSelecionado<>Unassigned then  //N�o Atribuido
     lkpFornecedor.KeyValue:=frmConsultaFornecedor.aRetornarIdSelecionado;
  FINALLY
       frmConsultaFornecedor.Release;
  END;

end;

procedure TfrmEntrada.btnPesquisarProdutoClick(Sender: TObject);
begin
  inherited;
    TRY
  frmConsultaProduto:= TfrmConsultaProduto.Create(Self);

  if lkpProduto.KeyValue<>Null then
     frmConsultaProduto.aIniciarPesquisaId:=lkpProduto.KeyValue;

  frmConsultaProduto.ShowModal;

  if frmConsultaProduto.aRetornarIdSelecionado<>Unassigned then  //N�o Atribuido
     lkpProduto.KeyValue:=frmConsultaProduto.aRetornarIdSelecionado;
  FINALLY
       frmConsultaProduto.Release;
  END;
end;

procedure TfrmEntrada.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(dtmEntrada) then
    FreeAndNil(dtmEntrada);
end;

procedure TfrmEntrada.FormCreate(Sender: TObject);
begin
  inherited;
  dtmEntrada := TdtmEntrada.Create(Self);
  IndiceAtual := 'entradaId';
  edtDataEntrada.Date := Date;
end;

procedure TfrmEntrada.FormShow(Sender: TObject);
begin
  inherited;
  QryFornecedor.Open;
  QryProduto.Open;
  edtDataEntrada.Date := Date;
end;


function TfrmEntrada.Apagar: Boolean;
begin
  // Implementa��o da fun��o Apagar
end;


procedure TfrmEntrada.LimparCampos;
begin
  edtEntradaId.Text := '';
  lkpFornecedor.KeyValue := Null;
  edtNumNota.Text := '';
  edtNumPedido.Text := '';
  edtDataEntrada.Date := Date;
  lkpProduto.KeyValue := Null;
  edtQuantidade.Text := '';
  dtmEntrada.cdsGridEntradaProdutoVirtual.EmptyDataSet;
end;


procedure TfrmEntrada.btnRemoverClick(Sender: TObject);
begin
  RemoverItem;
end;


end.
