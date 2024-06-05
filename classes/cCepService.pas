unit cCepService;

interface

uses
  System.SysUtils, System.Classes, System.Json, IdHTTP;

type
  TCepService = class
  private
    FEndereco: string;
    FBairro: string;
    FCEP: string;
    FCidade: string;
    FEstado: string;
    procedure ParseJson(const JsonString: string);
  public
    function Consultar(const CEP: string): Boolean;
    property Endereco: string read FEndereco;
    property Bairro: string read FBairro;
    property CEP: string read FCEP;
    property Cidade: string read FCidade;
    property Estado: string read FEstado;
  end;

implementation

{ TCepService }

function TCepService.Consultar(const CEP: string): Boolean;
var
  IdHTTP: TIdHTTP;
  JsonString: string;
begin
  IdHTTP := TIdHTTP.Create(nil);
  try
    try
      JsonString := IdHTTP.Get('https://brasilapi.com.br/api/cep/v1/' + CEP);
      ParseJson(JsonString);
      Result := True;
    except
      // Em caso de erro na consulta, retorna False
      Result := False;
    end;
  finally
    IdHTTP.Free;
  end;
end;

procedure TCepService.ParseJson(const JsonString: string);
var
  JsonObj: TJSONObject;
begin
  JsonObj := TJSONObject.ParseJSONValue(JsonString) as TJSONObject;
  try
    FEndereco := JsonObj.GetValue('street').Value;
    FBairro := JsonObj.GetValue('neighborhood').Value;
    FCEP := JsonObj.GetValue('cep').Value;
    FCidade := JsonObj.GetValue('city').Value;
    FEstado := JsonObj.GetValue('state').Value;
  finally
    JsonObj.Free;
  end;
end;

end.

