unit uCadFilial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, IdHTTP,System.JSON,
  System.Net.HttpClient, System.Net.HttpClientComponent, cCadFilial, uEnum,
  uDTMConexao;

type
  TfrmCadFilial = class(TfrmTelaHeranca)
    edtFilialId: TLabeledEdit;
    edtRazaoSocial: TLabeledEdit;
    edtEndereco: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtEstado: TLabeledEdit;
    edtTelefone: TMaskEdit;
    edtEmail: TLabeledEdit;
    edtCNPJ: TLabeledEdit;
    lblTelefone: TLabel;
    lblTelefone2: TLabel;
    edtTelefone2: TMaskEdit;
    edtIE: TMaskEdit;
    lblInscricaoEstadual: TLabel;
    btnBuscarCNPJ: TBitBtn;
    edtRamoAtividade: TLabeledEdit;
    memObservacoes: TMemo;
    lblObservacoes: TLabel;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    edtFantasia: TLabeledEdit;
    edtCEP: TMaskEdit;
    lblCEP: TLabel;
    edtComplemento: TLabeledEdit;
    edtIEAtivo: TMaskEdit;
    lblIEAtivo: TLabel;
    edtSituacaoCadastral: TLabeledEdit;
    edtMotivo: TMemo;
    lblMotivo: TLabel;
    edtNumFilial: TLabeledEdit;
    QryListagemfilialId: TZIntegerField;
    QryListagemnumfilial: TZIntegerField;
    QryListagemrazaosocial: TZUnicodeStringField;
    QryListagemcnpj: TZUnicodeStringField;
    procedure btnBuscarCNPJClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    oFilial : TFilial;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
  public
    { Public declarations }
    const
      _URL_CONSULTAR_CNPJ = 'https://publica.cnpj.ws/cnpj/%s';
  end;

var
  frmCadFilial: TfrmCadFilial;

implementation

{$R *.dfm}
function ApenasNumeros(const Texto: string): string;
var
  i: Integer;
begin
  Result := ''; // Inicializa o resultado como uma string vazia
  for i := 1 to Length(Texto) do
  begin
    if CharInSet(Texto[i], ['0'..'9']) then
      Result := Result + Texto[i];
  end;
end;
function AplicarMascaraCNPJ(const CNPJ: string): string;
begin
  // Assume que o CNPJ j� est� apenas com n�meros e tem 14 caracteres
  if Length(CNPJ) = 14 then
    Result := Format('%.2s.%.3s.%.3s/%.4s-%.2s', [Copy(CNPJ, 1, 2), Copy(CNPJ, 3, 3),
      Copy(CNPJ, 6, 3), Copy(CNPJ, 9, 4), Copy(CNPJ, 13, 2)])
  else
    Result := CNPJ; // Retorna o CNPJ sem m�scara se n�o tiver 14 caracteres
end;

function TfrmCadFilial.Apagar: Boolean;
begin
  if oFilial.Selecionar(QryListagem.FieldByName('filialId').AsInteger) then begin
     Result := oFilial.Apagar;
  end;
end;

procedure TfrmCadFilial.btnAlterarClick(Sender: TObject);
begin
    if oFilial.Selecionar(QryListagem.FieldByName('filialId').AsInteger) then begin
    edtFilialId.Text     :=IntToStr(oFilial.codigo);
    edtNumFilial.Text    :=IntToStr(oFilial.numfilial);
    edtRazaoSocial.Text  := oFilial.razaosocial;
    edtFantasia.Text     := oFilial.fantasia;
    edtCNPJ.Text         := oFilial.cnpj;
    edtEndereco.Text     := oFilial.endereco;
    edtBairro.Text       := oFilial.bairro;
    edtCEP.Text          := oFilial.cep;
    edtCidade.Text       := oFilial.cidade;
    edtEstado.Text       := oFilial.estado;
    edtComplemento.Text  := oFilial.complemento;
    edtIE.Text           := oFilial.inscricaoestadual;
    edtIEAtivo.Text      := oFilial.inscricaostatus;
    edtTelefone.Text     := oFilial.telefone1;
    edtTelefone2.Text    := oFilial.telefone2;
    edtSituacaoCadastral.Text := oFilial.situacaocadastral;
    edtMotivo.Text       := oFilial.motivoscad;
    edtEmail.Text        := oFilial.email;
    edtRamoAtividade.Text:= oFilial.ramo;
    memObservacoes.Text  := oFilial.observacao;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;

end;

procedure TfrmCadFilial.btnBuscarCNPJClick(Sender: TObject);
var
  LCNPJ: String;
  JSONObject: TJSONObject;
  InscricaoEstadual: TJSONValue;
  TipoLogradouro: String;
  Logradouro: String;
  Numero : String;
  DDD1 : String;
  DDD2 : String;
  Telefone1: String;
  Telefone2: String;
begin
  edtCNPJ.SetFocus;
  LCNPJ := Trim(ApenasNumeros(edtCNPJ.Text));
  RESTClient.BaseURL := Format(_URL_CONSULTAR_CNPJ, [LCNPJ]);
  RESTClient.SecureProtocols := [THTTPSecureProtocol.TLS12];
  RESTRequest.Method := rmGet;
  try
    try
      RESTRequest.Execute;
      case RESTResponse.StatusCode of
        200: begin
               JSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(RESTResponse.Content), 0) as TJSONObject;
                 try
                     if JSONObject.FindValue('razao_social') <> nil then
                       edtRazaoSocial.Text :=  JSONObject.FindValue('razao_social').Value
                     else
                     edtRazaoSocial.Text :='';
                     if JSONObject.FindValue('estabelecimento.nome_fantasia') <> nil then
                      edtFantasia.Text :=  JSONObject.FindValue('estabelecimento.nome_fantasia').Value
                     else
                      edtFantasia.Text := '';
                     //if JSONObject.FindValue('estabelecimento.cnpj') <> nil then
                       //edtCNPJ.Text :=  AplicarMascaraCNPJ(JSONObject.FindValue('estabelecimento.cnpj').Value)
                     //else
                       //edtCNPJ.Text := '';
                         // endere�o
                         try
                              if JSONObject.FindValue('estabelecimento.tipo_logradouro') <> nil then
                                 TipoLogradouro :=JSONObject.FindValue('estabelecimento.tipo_logradouro').Value
                               else
                                 TipoLogradouro := '';
                               if JSONObject.FindValue('estabelecimento.logradouro') <> nil then
                                 Logradouro :=  JSONObject.FindValue('estabelecimento.logradouro').Value
                               else
                                 Logradouro := '';
                               if JSONObject.FindValue('estabelecimento.numero') <> nil then
                                 Numero :=  JSONObject.FindValue('estabelecimento.numero').Value
                               else
                                 Numero := '';
                         finally
                               edtEndereco.Text := TipoLogradouro+' '+ Logradouro+' '+ Numero ;
                         end;

                         if JSONObject.FindValue('estabelecimento.bairro') <> nil then
                           edtBairro.Text :=  JSONObject.FindValue('estabelecimento.bairro').Value
                         else
                           edtBairro.Text := '';
                         if JSONObject.FindValue('estabelecimento.cep') <> nil then
                           edtCEP.Text := JSONObject.FindValue('estabelecimento.cep').Value
                         else
                           edtCEP.Text := '';

                         if JSONObject.FindValue('estabelecimento.inscricoes_estaduais[0].inscricao_estadual') <> nil then
                            edtIE.Text := JSONObject.FindValue('estabelecimento.inscricoes_estaduais[0].inscricao_estadual').Value
                         else
                            edtIE.Text := 'ISENTO';

                         if JSONObject.FindValue('estabelecimento.inscricoes_estaduais[0].ativo') <> nil then
                            edtIEAtivo.Text :=  JSONObject.FindValue('estabelecimento.inscricoes_estaduais[0].ativo').Value
                          else
                            edtIEAtivo.Text := 'INATIVO';

                          if JSONObject.FindValue('estabelecimento.cidade.nome') <> nil then
                            edtCidade.Text :=  JSONObject.FindValue('estabelecimento.cidade.nome').Value
                          else
                            edtCidade.Text := '';

                          if JSONObject.FindValue('estabelecimento.estado.sigla') <> nil then
                            edtEstado.Text :=  JSONObject.FindValue('estabelecimento.estado.sigla').Value
                          else
                            edtEstado.Text := '';

                          if JSONObject.FindValue('estabelecimento.complemento') <> nil then
                            edtComplemento.Text :=  JSONObject.FindValue('estabelecimento.complemento').Value
                          else
                            edtComplemento.Text := '';

                         try
                              if JSONObject.FindValue('estabelecimento.ddd1') <> nil then
                                DDD1 := JSONObject.FindValue('estabelecimento.ddd1').Value
                              else
                                DDD1 := '';
                              if JSONObject.FindValue('estabelecimento.telefone1') <> nil then
                                Telefone1 := JSONObject.FindValue('estabelecimento.telefone1').Value
                              else
                                Telefone1 := '';
                              if JSONObject.FindValue('estabelecimento.ddd2') <> nil then
                                DDD2 := JSONObject.FindValue('estabelecimento.ddd2').Value
                              else
                                DDD2 := '';
                              if JSONObject.FindValue('estabelecimento.telefone2') <> nil then
                                Telefone2 := JSONObject.FindValue('estabelecimento.telefone2').Value
                              else
                                Telefone2 := '';
                         finally
                               edtTelefone.Text := DDD1+' '+ Telefone1;
                               edtTelefone2.Text := DDD2+' '+ Telefone2;
                         end;

                      if JSONObject.FindValue('estabelecimento.situacao_cadastral') <> nil then
                        edtSituacaoCadastral.Text :=  JSONObject.FindValue('estabelecimento.situacao_cadastral').Value
                      else
                        edtSituacaoCadastral.Text := '';

                      if JSONObject.FindValue('estabelecimento.email') <> nil then
                        edtEmail.Text := JSONObject.FindValue('estabelecimento.email').Value
                      else
                        edtEmail.Text := '';

                      if JSONObject.FindValue('estabelecimento.atividade_principal.descricao') <> nil then
                        edtRamoAtividade.Text := JSONObject.FindValue('estabelecimento.atividade_principal.descricao').Value
                      else
                        edtRamoAtividade.Text := '';

                      if JSONObject.FindValue('estabelecimento.motivo_situacao_cadastral.descricao') <> nil then
                        edtMotivo.Text := JSONObject.FindValue('estabelecimento.motivo_situacao_cadastral.descricao').Value
                      else
                        edtMotivo.Text := '';


                 finally
                 JSONObject.Free;
               end;
             end;
        404: MessageDlg('CNPJ n�o encontrado.', mtInformation, [mbOK], 0);
        else
          MessageDlg('Erro HTTP: ' + IntToStr(RESTResponse.StatusCode) + ' - ' + RESTResponse.StatusText, mtError, [mbOK], 0);
      end;
    except
      on E: EIdHTTPProtocolException do
        MessageDlg('Erro na requisi��o HTTP: ' + E.Message, mtError, [mbOK], 0);
      on E: Exception do
        MessageDlg('Erro ao executar a requisi��o: ' + E.Message, mtError, [mbOK], 0);
    end;
  finally
    RESTClient.ResetToDefaults;
    RESTRequest.ResetToDefaults;
  end;
  inherited;

end;

procedure TfrmCadFilial.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtCNPJ.SetFocus;// toda vez que abrir novo ele abre no nome
end;

procedure TfrmCadFilial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   if Assigned(oFilial) then
     FreeAndNil(oFilial); // Verifica se tem alguma variavel instanciada na memoria e limpa da memoria a informa��o
end;

procedure TfrmCadFilial.FormCreate(Sender: TObject);
begin
  inherited;
   oFilial := TFilial.Create(dtmPrincipal.ConexaoDB);
   IndiceAtual := 'razaosocial';// apenas para mostrar o campo label da pesquisa em categoria, ele puxa do banc
end;

procedure TfrmCadFilial.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  BloqueiaCTRL_DEL_DBGrid(Key,Shift);
end;

procedure TfrmCadFilial.FormShow(Sender: TObject);
begin
  inherited;
     //QryListagem.Open;
end;

function TfrmCadFilial.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
   begin
  if edtFilialId.Text<>EmptyStr then // se o campo do id for diferente de vazio
         oFilial.codigo:=StrToInt(edtFilialId.Text)// atribui pro campo c�digo o texto convertido em numero inteiro
  else
     oFilial.codigo:=0;
     oFilial.numfilial           := StrToInt(edtNumFilial.Text);
     oFilial.razaosocial         := edtRazaoSocial.Text;
     oFilial.fantasia            := edtFantasia.Text;
     oFilial.cnpj                := edtCNPJ.Text;
     oFilial.endereco            := edtEndereco.Text;
     oFilial.bairro              := edtBairro.Text;
     oFilial.cep                 := edtCEP.Text;
     oFilial.cidade              := edtCidade.Text;
     oFilial.estado              := edtEstado.Text;
     oFilial.complemento         := edtComplemento.Text;
     oFilial.inscricaoestadual   := edtIE.Text;
     oFilial.inscricaostatus     := edtIEAtivo.Text;
     oFilial.telefone1           := edtTelefone.Text;
     oFilial.telefone2           := edtTelefone2.Text;
     oFilial.situacaocadastral   := edtSituacaoCadastral.Text;
     oFilial.motivoscad          := edtMotivo.Text;
     oFilial.email               := edtEmail.Text;
     oFilial.ramo                := edtRamoAtividade.Text;
     oFilial.observacao          := memObservacoes.Text;

    if (EstadoDoCadastro=ecInserir) then
        Result := oFilial.Inserir
    else if(EstadoDoCadastro=ecAlterar) then
        Result := oFilial.Atualizar;
 end;
end;

end.
