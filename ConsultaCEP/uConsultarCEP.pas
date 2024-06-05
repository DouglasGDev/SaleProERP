unit uConsultarCEP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, Vcl.StdCtrls, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.Net.HttpClient, System.Net.HttpClientComponent, IdHTTP,
  System.Json, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Mask, uCadCliente;

type
  TfrmConsultarCEP = class(TForm)
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    ResultadoConsultarCEP: TMemo;
    pnlHeader: TPanel;
    btnConsultarCEP: TButton;
    pnlFooter: TPanel;
    btnFechar: TBitBtn;
    edtConsultarCEP: TMaskEdit;
    pnlRight: TPanel;
    pnlLeft: TPanel;
    procedure btnConsultarCEPClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    const
      _URL_CONSULTAR_CEP = 'https://brasilapi.com.br/api/cep/v1/%s';
  end;

var
  frmConsultarCEP: TfrmConsultarCEP;

implementation

{$R *.dfm}


procedure TfrmConsultarCEP.btnConsultarCEPClick(Sender: TObject);
var
  LCEP: String;
  JSONObject: TJSONObject;
begin
  ResultadoConsultarCEP.Clear;
  LCEP := Trim(edtConsultarCEP.Text);

  RESTClient.BaseURL := Format(_URL_CONSULTAR_CEP, [LCEP]);
  RESTClient.SecureProtocols := [THTTPSecureProtocol.TLS12];
  RESTRequest.Method := rmGet;

  try
    try
      RESTRequest.Execute;

      case RESTResponse.StatusCode of
        200: begin
               JSONObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(RESTResponse.Content), 0) as TJSONObject;
               try
                 ResultadoConsultarCEP.Lines.Add('Endere�o: ' + JSONObject.GetValue('street').Value);
                 ResultadoConsultarCEP.Lines.Add('Bairro: ' + JSONObject.GetValue('neighborhood').Value);
                 ResultadoConsultarCEP.Lines.Add('CEP: ' + JSONObject.GetValue('cep').Value);
                 ResultadoConsultarCEP.Lines.Add('Cidade: ' + JSONObject.GetValue('city').Value);
                 ResultadoConsultarCEP.Lines.Add('Estado: ' + JSONObject.GetValue('state').Value);
               finally
                 JSONObject.Free;
               end;
             end;
        404: MessageDlg('CEP n�o encontrado.', mtInformation, [mbOK], 0);
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
  end;
end;

procedure TfrmConsultarCEP.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConsultarCEP.FormShow(Sender: TObject);
begin
  edtConsultarCEP.SetFocus;
end;

end.

