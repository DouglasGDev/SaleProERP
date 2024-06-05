unit uCadProduto;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  RxToolEdit, RxCurrEdit, cCadProduto, uEnum, uDTMConexao, uCadCategoria, cFuncao, uConsultaCategoria,
  Vcl.Menus;
type
  TfrmCadProduto = class(TfrmTelaHeranca)
    edtProdutoId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtDescricao: TMemo;
    lblDescricao: TLabel;
    edtValor: TCurrencyEdit;
    edtQuantidadeMinima: TCurrencyEdit;
    lblValor: TLabel;
    lblQuantidadeMinima: TLabel;
    lkpCategoria: TDBLookupComboBox;
    QryCategoria: TZQuery;
    dtsCategoria: TDataSource;
    QryCategoriacategoriaId: TZIntegerField;
    QryCategoriadescricao: TZUnicodeStringField;
    edtValidade: TDateEdit;
    lblValidade: TLabel;
    edtCodBarras: TLabeledEdit;
    btnIncluirCategoria: TSpeedButton;
    btnPesquisarCategoria: TSpeedButton;
    edtCusto: TCurrencyEdit;
    lblCusto: TLabel;
    pnlImagem: TPanel;
    imgImagem: TImage;
    ppmImagem: TPopupMenu;
    CarregarImagem1: TMenuItem;
    LimparImagem1: TMenuItem;
    Label1: TLabel;
    QryFornecedor: TZQuery;
    dtsFornecedor: TDataSource;
    QryFornecedorfornecedorId: TZIntegerField;
    QryFornecedorrazaosocial: TZUnicodeStringField;
    QryListagemprodutoId: TZIntegerField;
    QryListagemnome: TZUnicodeStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnIncluirCategoriaClick(Sender: TObject);
    procedure btnPesquisarCategoriaClick(Sender: TObject);
    procedure LimparImagem1Click(Sender: TObject);
    procedure CarregarImagem1Click(Sender: TObject);
  private
    { Private declarations }
    oProduto:TProduto;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
  public
    { Public declarations }
  end;
var
  frmCadProduto: TfrmCadProduto;
implementation
{$R *.dfm}

uses UPrincipal;
{$region 'override'}

function TfrmCadProduto.Apagar: Boolean;
begin
    if oProduto.Selecionar(QryListagem.FieldByName('produtoId').AsInteger) then begin
       Result := oProduto.Apagar;
    end;
end;


procedure TfrmCadProduto.FormCreate(Sender: TObject);
begin
  inherited;
   oProduto := TProduto.Create(dtmPrincipal.ConexaoDB);
   IndiceAtual := 'nome';// apenas para mostrar o campo label da pesquisa em categoria, ele puxa do banc
end;

procedure TfrmCadProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
    BloqueiaCTRL_DEL_DBGrid(Key,Shift);
end;
procedure TfrmCadProduto.FormShow(Sender: TObject);
begin
  inherited;
   QryCategoria.Open;
   //QryFornecedor.Open;
end;
function TfrmCadProduto.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtProdutoId.Text<>EmptyStr then // se o campo do id for diferente de vazio
         oProduto.codigo:=StrToInt(edtProdutoId.Text)// atribui pro campo código o texto convertido em numero inteiro
  else
     oProduto.codigo:=0;
     oProduto.nome:= edtNome.Text;
     oProduto.descricao:= edtDescricao.Text;
     oProduto.custo:= edtCusto.Value;
     oProduto.valor:= edtValor.Value;
     oProduto.qtminima:= edtQuantidadeMinima.Value;
     oProduto.codbarras:= edtCodBarras.Text;
     oProduto.validade:= edtValidade.Date;

     if imgImagem.Picture.Bitmap.Empty then
        oProduto.foto.Assign(nil)
     else
        oProduto.foto.Assign(imgImagem.Picture);

     oProduto.categoriaId:= lkpCategoria.KeyValue;
     //oProduto.fornecedorId:= lkpFornecedor.KeyValue;

    if (EstadoDoCadastro=ecInserir) then
        Result := oProduto.Inserir
    else if(EstadoDoCadastro=ecAlterar) then
        Result := oProduto.Atualizar;
end;

procedure TfrmCadProduto.LimparImagem1Click(Sender: TObject);
begin
  inherited;
  TFuncao.LimparImagem(imgImagem);
end;

procedure TfrmCadProduto.btnIncluirCategoriaClick(Sender: TObject);
begin
  inherited;
  TFuncao.CriarForm(TfrmCadCategoria, oUsuarioLogado, DtmPrincipal.ConexaoDB);
  QryCategoria.Refresh;
end;


procedure TfrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
    if Assigned(oProduto) then
     FreeAndNil(oProduto); // Verifica se tem alguma variavel instanciada na memoria e limpa da memoria a informação
end;
{$endregion}
procedure TfrmCadProduto.btnAlterarClick(Sender: TObject);
begin
    if oProduto.Selecionar(QryListagem.FieldByName('produtoId').AsInteger) then begin
    edtProdutoId.Text :=IntToStr(oProduto.codigo);
    edtNome.Text   := oProduto.nome;
    edtDescricao.Text   := oProduto.descricao;
    edtCusto.Value := oProduto.custo;
    edtValor.Value :=  oProduto.valor;
    edtQuantidadeMinima.Value := oProduto.qtminima;
    edtCodBarras.Text :=oProduto.codbarras;
    edtValidade.Date := oProduto.validade;
    imgImagem.Picture.Assign(oProduto.foto);
    lkpCategoria.KeyValue := oProduto.categoriaId;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;
end;
procedure TfrmCadProduto.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtValidade.Date:= Date;
  edtNome.SetFocus;// toda vez que abrir novo ele abre no nome
end;
procedure TfrmCadProduto.btnPesquisarCategoriaClick(Sender: TObject);
begin
  inherited;
  TRY
  frmConsultaCategoria:=TfrmConsultaCategoria.Create(Self);

  if lkpCategoria.KeyValue<>Null then
     frmConsultaCategoria.aIniciarPesquisaId:=lkpCategoria.KeyValue;

  frmConsultaCategoria.ShowModal;

  if frmConsultaCategoria.aRetornarIdSelecionado<>Unassigned then  //Não Atribuido
     lkpCategoria.KeyValue:=frmConsultaCategoria.aRetornarIdSelecionado;
  FINALLY
       frmConsultaCategoria.Release;
  END;
end;


procedure TfrmCadProduto.CarregarImagem1Click(Sender: TObject);
begin
  inherited;
  TFuncao.CarregarImagem(imgImagem);
end;

end.
