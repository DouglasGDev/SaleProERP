unit uTelaHeranca;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  Vcl.DBCtrls, ZAbstractRODataset, ZAbstractDataset, ZDataset, uDtmConexao, uEnum, RxCurrEdit,
  RxToolEdit, ZAbstractConnection, ZConnection, cUsuarioLogado, Vcl.Menus;
type
  TfrmTelaHeranca = class(TForm)
    pgcPrincipal: TPageControl;
    pnlRodape: TPanel;
    tabListagem: TTabSheet;
    tabManutencao: TTabSheet;
    pnlListagemTopo: TPanel;
    mskPesquisar: TMaskEdit;
    btnPesquisar: TBitBtn;
    grdListagem: TDBGrid;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnApagar: TBitBtn;
    btnFechar: TBitBtn;
    btnNavigator: TDBNavigator;
    QryListagem: TZQuery;
    dtsListagem: TDataSource;
    lblIndice: TLabel;
    pnlTitulo: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure mskPesquisarChange(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    SelectOrignal : String;
    procedure ControlarBotoes(btnNovo,btnAlterar,btnCancelar,
              btnGravar,btnApagar:TBitBtn; Navegador:TDBNavigator;
              pgcPrincipal: TPageControl; Flag: Boolean);
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
    function RetornarCampoTraduzido(Campo: String): String;
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);
    function ExisteCampoObrigatorio: Boolean;
    procedure DesabilitarEditPK;
    procedure LimparEdits;
  public
    { Public declarations }
    EstadoDoCadastro:TEstadoDoCadastro;
    IndiceAtual:string;
    function Apagar:Boolean; virtual;// o virtual da possibilidade de reescrever o método em outra tela que pega dessa herança
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; virtual; //mesma coisa do de cima
    procedure BloqueiaCTRL_DEL_DBGrid(var Key: word; Shift: TShiftState);
  end;
var
  frmTelaHeranca: TfrmTelaHeranca;
implementation
{$R *.dfm}

uses UPrincipal;
{$region 'OBSERVAÇÕES'}
 //TAG: 1 -> Chave primária- PK (id)
 //TAG: 2 -> Campos obrigatórios
{$endregion}
{$region 'Procedimentos e funções de controle de tela'} // serve pra definir uma região onde posso esconder um bloco específico de código que defini
procedure TfrmTelaHeranca.ControlarBotoes(btnNovo,btnAlterar,btnCancelar,
          btnGravar,btnApagar:TBitBtn; Navegador:TDBNavigator;
          pgcPrincipal: TPageControl; Flag: Boolean);
begin
     btnNovo.Enabled    := Flag;  // só para controlar a função dos botões nas telas que herdam dessa tbm
     btnApagar.Enabled  := Flag;
     btnAlterar.Enabled := Flag;
     Navegador.Enabled  := Flag;
     pgcPrincipal.Pages[0].TabVisible := Flag;
     btnCancelar.Enabled := not(Flag);  // aqui só fica true se as demais acima tiverem false
     btnGravar.Enabled := not(Flag);  // mesma coisa aqui
end;
procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
begin
    if (pgcPrincipal.Pages[Indice].TabVisible) then // isso aqui verifica se a aba que estiver visivel ele coloca a propriedade indice
       pgcPrincipal.TabIndex := Indice;
end;
function TfrmTelaHeranca.RetornarCampoTraduzido(Campo:String):String; // pra armazenar o nome do campo da coluna pra retornar no titulo da pesquisa que utilizarei para filtrar na pesquisa
var i : Integer;
begin
  for i := 0 to QryListagem.Fields.Count-1 do begin
     if lowercase(QryListagem.Fields[i].FieldName)=lowercase(Campo) then begin//deixa tudo minusculo para não ter problema no label, ele retorna certinho no label o valor, e comparando valores, ele retorna a configuração correta do display label no grid
        Result:= QryListagem.Fields[i].DisplayLabel;
        Break;
     end;
  end;
end;




procedure TfrmTelaHeranca.ExibirLabelIndice(Campo: string; aLabel:TLabel);
begin
   aLabel.Caption :=  RetornarCampoTraduzido(Campo);
end;
function TfrmTelaHeranca.ExisteCampoObrigatorio: Boolean;// automatiza a verificação de campos obrigatórios
var i: integer;
begin
  Result := False;
  for i := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then begin // verifica se é do tipo TLabeledEdit
      if (TLabeledEdit(Components[i]).Tag = 2) // verifica se a tag é 2 e se o campo de texto está vazio
          and (TLabeledEdit(Components[i]).Text=EmptyStr) then begin
          MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption + // da um diálogo com o nome do campo mais a mensagem
                    ' é um campo obrigatório', TMsgDlgType.mtInformation,[TMsgDlgBtn.mbOK], 0);// junto com um tipo de alerta que no caso apenas informação  e um botão de ok
          TLabeledEdit(Components[i]).SetFocus;
          Result := True;  // muda pra true pq no caso é campo obrigatório
          Break;   // da um break para não ficar verificando sem parar
      end;
    end;
  end;
  for i := 0 to ComponentCount -1 do begin
    if (Components[i] is TDBLookupComboBox) then begin // verifica se é do tipo TLabeledEdit
      if (TDBLookupComboBox(Components[i]).Tag = 2) // verifica se a tag é 2 e se o campo de texto está vazio
          and (TDBLookupComboBox(Components[i]).Text=EmptyStr) then begin
          MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption + // da um diálogo com o nome do campo mais a mensagem
                    ' é um campo obrigatório', TMsgDlgType.mtInformation,[TMsgDlgBtn.mbOK], 0);// junto com um tipo de alerta que no caso apenas informação  e um botão de ok
          TDBLookupComboBox(Components[i]).SetFocus;
          Result := True;  // muda pra true pq no caso é campo obrigatório
          Break;   // da um break para não ficar verificando sem parar
      end;
    end;
  end;
  for i := 0 to ComponentCount -1 do begin
    if (Components[i] is TMaskEdit) then begin // verifica se é do tipo TLabeledEdit
      if (TMaskEdit(Components[i]).Tag = 2) // verifica se a tag é 2 e se o campo de texto está vazio
          and (TMaskEdit(Components[i]).Text=EmptyStr) then begin
          MessageDlg(TMaskEdit(Components[i]).Name + // da um diálogo com o nome do campo mais a mensagem
                    ' é um campo obrigatório', TMsgDlgType.mtInformation,[TMsgDlgBtn.mbOK], 0);// junto com um tipo de alerta que no caso apenas informação  e um botão de ok
          TMaskEdit(Components[i]).SetFocus;
          Result := True;  // muda pra true pq no caso é campo obrigatório
          Break;   // da um break para não ficar verificando sem parar
      end;
    end;
  end;
end;
procedure TfrmTelaHeranca.DesabilitarEditPK;
var i: integer;
begin
  for i := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then begin // verifica se é do tipo TLabeledEdit
      if (TLabeledEdit(Components[i]).Tag = 1) then begin
         TLabeledEdit(Components[i]).Enabled := false; // é para desabilitar o campo id para não poder modificar no banco
         Break;
      end;
    end;
  end;
end;
procedure TfrmTelaHeranca.LimparEdits;
var i: integer;
begin
  for i := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then // verifica se é do tipo TLabeledEdit
      TLabeledEdit(Components[i]).Text := EmptyStr// para limpar o campo que foi digitado anteriormente e retornar sem sujeira
       else if (Components[i] is TMaskEdit) then
       TMaskEdit(Components[i]).Text := EmptyStr// para limpar o campo que foi digitado anteriormente e retornar sem sujeira
       else if (Components[i] is TEdit) then
       TEdit(Components[i]).Text := EmptyStr// para limpar o campo que foi digitado anteriormente e retornar sem sujeira
       else if (Components[i] is TMemo) then
       TMemo(Components[i]).Text := EmptyStr// para limpar o campo que foi digitado anteriormente e retornar sem sujeira
       else if (Components[i] is TDBLookupComboBox) then
       TDBLookupComboBox(Components[i]).KeyValue := Null// para limpar o campo que foi digitado anteriormente e retornar sem sujeira
       else if (Components[i] is TCurrencyEdit) then
       TCurrencyEdit(Components[i]).Value := 0// para limpar o campo que foi digitado anteriormente e retornar sem sujeira
       else if (Components[i] is TDateEdit) then
       TDateEdit(Components[i]).Date := 0// para limpar o campo que foi digitado anteriormente e retornar sem sujeira
       else if (Components[i] is TImage) then
       TImage(Components[i]).Picture := nil;
  end;
end;
{$endregion}

{$region 'Métodos Virtuais'}
function TfrmTelaHeranca.Apagar: Boolean;
begin
   ShowMessage('Deletado');
   Result := True;
end;
function TfrmTelaHeranca.Gravar(EstadoDoCadastro:TEstadoDoCadastro): Boolean;
begin
     if (EstadoDoCadastro=ecInserir) then
         showmessage('Inserir')
     else if (EstadoDoCadastro=ecAlterar) then
         showmessage('Alterado')
     else
      showmessage('Nada aconteceu');
end;
{$endregion}

procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, self.Name+'_'+TBitBtn(Sender).Name, DtmPrincipal.ConexaoDB) then
  begin
     MessageDlg('Usuário: '+oUsuarioLogado.nome +', não tem permissão de acesso',mtWarning,[mbOK],0);
     Abort;
  end;
     ControlarBotoes(btnNovo,btnAlterar,btnCancelar,
          btnGravar,btnApagar,btnNavigator, pgcPrincipal, false);
     EstadoDoCadastro:=ecInserir; // enum para ter controle sobre tela, no caso aqui pra aber que está na tela de criar ou inserir
     LimparEdits;// para limpar o campo onde digita
end;
procedure TfrmTelaHeranca.btnPesquisarClick(Sender: TObject);
var I : Integer;
    TipoCampo : TFieldType;
    NomeCampo : String;
    WhereOrAnd : String;
    CondicaoSQL : String;
    dataFormatada: string;
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, self.Name+'_'+TBitBtn(Sender).Name, DtmPrincipal.ConexaoDB) then
    begin
       MessageDlg('Usuário: '+oUsuarioLogado.nome +', não tem permissão de acesso',mtWarning,[mbOK],0);
       Abort;
    end;
  if mskPesquisar.Text = '' then   // se o campo de pesquisa estiver vazio vai fechar a query, limpar ela e adicionar a query original que foi armazenada na variável e abrir novamente e abortar a operação
  begin
    QryListagem.Close;
    QryListagem.SQL.Clear;
    QryListagem.SQL.Add(SelectOrignal);
    QryListagem.Open;
    Abort;
  end;
    for I := 0 to QryListagem.FieldCount-1 do    // verifica quantos campos tem na tela que recebeu a herança
    begin
        if QryListagem.Fields[i].FieldName = IndiceAtual then  // compara os campos com o indice atual que está marcando, pergunta se é o mesmo indice
        begin
             TipoCampo := QryListagem.Fields[i].DataType; // aqui ele armazena o tipo nessa variável, por exemplo se é inteiro, string e assim vai
             if QryListagem.Fields[i].Origin<>'' then
             begin
                if Pos('.', QryListagem.Fields[i].Origin) > 0 then
                NomeCampo := QryListagem.Fields[i].Origin
                else
                NomeCampo := QryListagem.Fields[i].Origin+'.'+QryListagem.Fields[i].FieldName // dnetro dos campos da qry listagem tem um campo origem que é preenchido de onde vem aquela campo da tabela
             end
             else
             NomeCampo := QryListagem.Fields[i].FieldName; // aqui armazena o nome do campo
             Break;
        end;
    end;
        if Pos('where', LowerCase(SelectOrignal)) > 1 then // verfica se dentro do select original possui a palavra where, Pos é a posição e se existe uma palvra where
        begin
          WhereOrAnd := ' and '
        end
        else
        begin
          WhereOrAnd := ' where ';
        end;

        if (TipoCampo=ftString) or (TipoCampo=ftWideString) then // do tipo string a condição abaixo
        begin
          CondicaoSQL := WhereOrAnd + ' ' + NomeCampo + ' ' + ' LIKE ' + QuotedStr('%'+mskPesquisar.Text+'%'); // quotedStr é pra colocar aspas duplas
        end
        else if (TipoCampo = ftInteger) or (TipoCampo = ftSmallint) then // do tipo inteiro a condição abaixo
        begin
          CondicaoSQL := WhereOrAnd+' '+NomeCampo + '='+mskPesquisar.Text
        end
        else if (TipoCampo = ftFloat) or (TipoCampo = ftCurrency) then
        begin
          CondicaoSQL := WhereOrAnd+' '+NomeCampo + '='+StringReplace(mskPesquisar.Text, ',', '.', [rfReplaceAll])
        end
        else if (TipoCampo = ftDate) or (TipoCampo = ftDateTime) then // se for do tipo date ele da essa condição abaixo
        begin
          dataFormatada := FormatDateTime('yyyy-mm-dd', StrToDate(mskPesquisar.Text)); // teve que inverter pois no banco de dados o formato da data é esse da inversão.
          CondicaoSQL := WhereOrAnd+' '+NomeCampo + '='+ QuotedStr(dataFormatada)
        end
        else
        begin
          CondicaoSQL := WhereOrAnd+' '+NomeCampo + '='+StringReplace(mskPesquisar.Text, ',', '.', [rfReplaceAll]);
        end;


        QryListagem.Close; // fecha a query
        QryListagem.SQL.Clear;// limpa
        QryListagem.SQL.Add(SelectOrignal);// adiciona a original
        QryListagem.SQL.Add(CondicaoSQL);// juntamente com a condição gerada
        QryListagem.Open;// e abre a query novamente com a query modificada

        mskPesquisar.Text := ''; // limpa o campo
        mskPesquisar.SetFocus; // foca nele


end;

procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, self.Name+'_'+TBitBtn(Sender).Name, DtmPrincipal.ConexaoDB) then
  begin
     MessageDlg('Usuário: '+oUsuarioLogado.nome +', não tem permissão de acesso',mtWarning,[mbOK],0);
     Abort;
  end;
  ControlarBotoes(btnNovo,btnAlterar,btnCancelar,
          btnGravar,btnApagar,btnNavigator, pgcPrincipal, false);
  EstadoDoCadastro:=ecAlterar; // enum para ter controle sobre tela, no caso aqui é para saber que ele está alterando na tela de alterar
end;
procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, self.Name+'_'+TBitBtn(Sender).Name, DtmPrincipal.ConexaoDB) then
  begin
     MessageDlg('Usuário: '+oUsuarioLogado.nome +', não tem permissão de acesso',mtWarning,[mbOK],0);
     Abort;
  end;
  Try
    if (Apagar) then begin
        ControlarBotoes(btnNovo,btnAlterar,btnCancelar,
            btnGravar,btnApagar,btnNavigator, pgcPrincipal, True);
        ControlarIndiceTab(pgcPrincipal, 0);// volta para o indice 0, aba de listagem
        LimparEdits;// para limpar o campo onde digita
        QryListagem.Refresh;// para atualizar a listagem depois de apagar uma categoria
    end
    else begin
       MessageDlg('Erro na exclusão', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    end;
  Finally
      EstadoDoCadastro:=ecNenhum; // enum para ter controle sobre tela, no caso aqui não terá nenhum efeito sobre a tela
  End;
end;
procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
       ControlarBotoes(btnNovo,btnAlterar,btnCancelar,
          btnGravar,btnApagar,btnNavigator, pgcPrincipal, True);
       ControlarIndiceTab(pgcPrincipal, 0);// volta para o indice 0, aba de listagem
       EstadoDoCadastro:=ecNenhum; // enum para ter controle sobre tela, no caso aqui não terá nenhum efeito sobre a tela
       LimparEdits;// para limpar o campo onde digita
end;
procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close;
end;
procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, self.Name+'_'+TBitBtn(Sender).Name, DtmPrincipal.ConexaoDB) then
  begin
     MessageDlg('Usuário: '+oUsuarioLogado.nome +', não tem permissão de acesso',mtWarning,[mbOK],0);
     Abort;
  end;

if (ExisteCampoObrigatorio) then // so chama a função de verificar campo obrigatório e se tiver não grava
    abort;
  Try  // tenta executar esse bloco(mesmo que não conseguir ele vai no finally e executa)
    if Gravar(EstadoDoCadastro) then begin // método virtual
      ControlarBotoes(btnNovo,btnAlterar,btnCancelar,
              btnGravar,btnApagar,btnNavigator, pgcPrincipal, True);
      ControlarIndiceTab(pgcPrincipal, 0);// volta para o indice 0, aba de listagem
      EstadoDoCadastro:=ecNenhum;// enum para ter controle sobre tela, no caso aqui não terá nenhum efeito sobre a tela
      LimparEdits;// para limpar o campo onde digita
      QryListagem.Refresh;// para atualizar a listagem depois de inserir uma nova categoria
    end
    else begin
      MessageDlg('Erro na gravação', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    end;
  Finally
  End;
end;
procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      QryListagem.Close;// pra fechar a conexão db
end;
procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  QryListagem.Connection := dtmPrincipal.ConexaoDB;// diz que aqui o campo de query da listagem, recebe a conexão do banco de dados
  dtsListagem.DataSet := QryListagem;// e aqui ele recebe a variável acima
  grdListagem.DataSource:= dtsListagem;// aqui o grid da listagem recebe a variável acima
  grdListagem.Options:= [dgTitles,dgIndicator,dgColumnResize,
                        dgColLines,dgRowLines,dgTabs,
                        dgRowSelect,dgAlwaysShowSelection,dgCancelOnExit,
                        dgTitleClick,dgTitleHotTrack];// salva as opçoes que defini pro grid
end;
procedure TfrmTelaHeranca.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   BloqueiaCTRL_DEL_DBGrid(Key,Shift);
end;
procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
   if (QryListagem.SQL.Text<>EmptyStr) then begin // está verificando se o campo sql não está vazio
      QryListagem.IndexFieldNames := IndiceAtual;// aqui recebe o indice para armazenar e mostrar no campo de pesquisa
      ExibirLabelIndice(IndiceAtual, lblIndice);
      SelectOrignal := QryListagem.SQL.Text; // aqui recebe o sql pré definido
      QryListagem.Open; // abre o sql se não estiver vazio
   end;
   ControlarIndiceTab(pgcPrincipal, 0);
   DesabilitarEditPK;
   ControlarBotoes(btnNovo,btnAlterar,btnCancelar,
                   btnGravar,btnApagar,btnNavigator, pgcPrincipal, True);// isso é feito para deixar os botões cancelar e gravar da tela de listagem, desabilitados
end;

procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
   btnAlterar.Click;
end;
procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
      IndiceAtual := Column.FieldName; // aqui armazena o nome da coluna clicada
      QryListagem.IndexFieldNames := IndiceAtual; // isso é para ordenar os campos
      ExibirLabelIndice(IndiceAtual, lblIndice);// é para mostrar o campo encima do pesquisar onde é clicado na coluna
end;
procedure TfrmTelaHeranca.mskPesquisarChange(Sender: TObject);
begin
  QryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]);// é para fazer a pesquisa, recebe o que foi digitado no campo de pesquisa
end;
   procedure TfrmTelaHeranca.BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
   begin
     //Bloqueia o CTRL + DEL
     if (Shift = [ssCtrl]) and (Key = 46) then
        Key := 0;
   end;
end.
