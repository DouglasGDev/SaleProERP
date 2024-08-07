unit uUsuarioVsAcoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, ZAbstractRODataset, ZAbstractDataset, ZDataset, uDTMConexao,
  Vcl.StdCtrls, Vcl.Buttons, IniFiles;

type
  TfrmUsuarioVsAcoes = class(TForm)
    pnlUser: TPanel;
    pnlBody: TPanel;
    pnlFooter: TPanel;
    Splitter1: TSplitter;
    grdUsuario: TDBGrid;
    grdAcoes: TDBGrid;
    QryUsuario: TZQuery;
    QryAcoes: TZQuery;
    DtsUsuario: TDataSource;
    DtsAcoes: TDataSource;
    QryUsuariousuarioId: TZIntegerField;
    QryUsuarionome: TZUnicodeStringField;
    QryAcoesusuarioId: TZIntegerField;
    QryAcoesacaoAcessoId: TZIntegerField;
    QryAcoesdescricao: TZUnicodeStringField;
    QryAcoesativo: TZBooleanField;
    btnFechar: TBitBtn;
    pnlHeader: TPanel;
    procedure btnFecharClick(Sender: TObject);
    procedure QryUsuarioAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure grdAcoesDblClick(Sender: TObject);
    procedure grdAcoesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure SelecionarAcoesAcessoPorUsuario;
    function LoadSwitchState: Boolean;
  public
    { Public declarations }
  end;

var
  frmUsuarioVsAcoes: TfrmUsuarioVsAcoes;

implementation

{$R *.dfm}

procedure TfrmUsuarioVsAcoes.btnFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmUsuarioVsAcoes.grdAcoesDblClick(Sender: TObject); // no duplo click no campo grid das a��es ele muda de ativo pra inativo ou true pra false
var Qry:TZQuery;                                              // no grid de a��es por usu�rio
    bmRegistroAtual:TBookmark;
begin
  try
    bmRegistroAtual := QryAcoes.GetBookMark; //Marcar o Registro Selecionado
    Qry:=TZQuery.Create(nil);
    Qry.Connection:=DtmPrincipal.ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE usuariosAcaoAcesso '+
                '   SET ativo=:ativo '+
                ' WHERE usuarioId=:usuarioId '+
                '   AND acaoAcessoId=:acaoAcessoId ');
    Qry.ParamByName('usuarioId').AsInteger    :=QryAcoes.FieldByName('usuarioId').AsInteger;
    Qry.ParamByName('acaoAcessoId').AsInteger :=QryAcoes.FieldByName('acaoAcessoId').AsInteger;
    Qry.ParamByName('ativo').AsBoolean        :=not QryAcoes.FieldByName('ativo').AsBoolean;
    Try

      DtmPrincipal.ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      DtmPrincipal.ConexaoDB.Commit;
    Except
      DtmPrincipal.ConexaoDB.Rollback;
    End;

  finally
    SelecionarAcoesAcessoPorUsuario;
    QryAcoes.GotoBookMark(bmRegistroAtual);  //Faz o Retorno do Registro depois que a query foi fechada e aberta
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

procedure TfrmUsuarioVsAcoes.grdAcoesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  If not QryAcoes.FieldByName('ativo').AsBoolean  then // se n�o estiver ativo coloca uma cor de fundo vermelha, caso contr�rio mant�m
  begin
    TDBGrid(Sender).Canvas.Font.Color:= clWhite;
    TDBGrid(Sender).Canvas.Brush.Color:=clRed
  end;
  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[datacol].field, State);
end;

procedure TfrmUsuarioVsAcoes.FormShow(Sender: TObject);
var
SwitchState : Boolean;
  Ini: TIniFile;
  FilePath: string;
  corPrincipal: TColor;
begin
   Try
    QryUsuario.DisableControls;// desabilita o afterscroll para cada usu�rio que puxa todos os controles da query
    QryUsuario.Open; // abre a query
    SelecionarAcoesAcessoPorUsuario; // seleciona o usu�rio
  Finally
    QryUsuario.EnableControls;// habilita novamente, e isso pra cada usu�rio
  End;

  // Define o caminho do arquivo INI
  FilePath := ExtractFilePath(ParamStr(0)) + 'vendas.ini';

  // Cria a inst�ncia de TIniFile
  Ini := TIniFile.Create(FilePath);
  try
    // L� os valores do arquivo INI
    corPrincipal := StringToColor(Ini.ReadString('Configuracoes', 'CorPrincipal', 'clTeal'));
  finally
    // Libera a inst�ncia de TIniFile
    Ini.Free;
  end;

  SwitchState := LoadSwitchState;
    if SwitchState.ToInteger = 0 then
    begin
        pnlHeader.Color := corPrincipal;
        pnlFooter.Color := corPrincipal;
    end
    else if SwitchState.ToInteger = 1 then
    begin
        pnlHeader.Color := $001E1E1E;
        pnlFooter.Color := $001E1E1E;
    end;
end;

procedure TfrmUsuarioVsAcoes.QryUsuarioAfterScroll(DataSet: TDataSet);
begin
    SelecionarAcoesAcessoPorUsuario;
end;

procedure TfrmUsuarioVsAcoes.SelecionarAcoesAcessoPorUsuario;
begin
  QryAcoes.Close;
  QryAcoes.ParamByName('usuarioId').AsInteger := QryUsuario.FieldByName('usuarioID').AsInteger;
  QryAcoes.Open;
end;

function TfrmUsuarioVsAcoes.LoadSwitchState: Boolean;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'vendas.ini');
  try
    Result := Ini.ReadBool('Settings', 'SwitchState', False);
  finally
    Ini.Free;
  end;
end;

end.
