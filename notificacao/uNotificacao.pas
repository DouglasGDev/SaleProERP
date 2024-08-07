unit uNotificacao;

interface

uses
  SysUtils,
  Classes,
  Controls,
  Forms,
  ExtCtrls,
  StdCtrls,
  Generics.Collections,
  MMSystem;

type
  TfrmNotificacao = class(TForm)
    pnlNotificacao: TPanel;
    lblTitulo: TLabel;
    lblMensagem: TLabel;
    TimerHide: TTimer;
    procedure FormShow(Sender: TObject);
    procedure TimerHideTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FNotificationList: TList<TfrmNotificacao>;
    procedure AdjustNotificationPositions;
    procedure TocarSom;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MostrarNotificacao(ATitle, AMessage: string);
  end;

var
  frmNotificacao: TfrmNotificacao;

implementation

{$R *.dfm}

constructor TfrmNotificacao.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FNotificationList := TList<TfrmNotificacao>.Create;
end;

destructor TfrmNotificacao.Destroy;
begin
  FNotificationList.Free;
  inherited Destroy;
end;

procedure TfrmNotificacao.FormShow(Sender: TObject);
begin
  Left := Screen.Width - Width;
  Top := 0;
end;

procedure TfrmNotificacao.AdjustNotificationPositions;
var
  i: Integer;
begin
  for i := 0 to FNotificationList.Count - 1 do
  begin
    if i = 0 then
      FNotificationList[i].Top := 0
    else
      FNotificationList[i].Top := FNotificationList[i - 1].Top + FNotificationList[i - 1].Height + 10;
  end;
end;

procedure TfrmNotificacao.MostrarNotificacao(ATitle, AMessage: string);
var
  NewNotification: TfrmNotificacao;
begin
  NewNotification := TfrmNotificacao.Create(nil);
  try
    NewNotification.lblTitulo.Caption := ATitle;
    NewNotification.lblMensagem.Caption := AMessage;
    NewNotification.Left := Screen.Width - NewNotification.Width;

    FNotificationList.Add(NewNotification);
    AdjustNotificationPositions;
    NewNotification.Show;
      // Tocar som
    TocarSom;
  except
    NewNotification.Free;
  end;
end;

procedure TfrmNotificacao.TimerHideTimer(Sender: TObject);
begin
  TimerHide.Enabled := False;
  Hide;
  if FNotificationList.Count > 0 then
    FNotificationList.Delete(0);
  AdjustNotificationPositions;
end;

procedure TfrmNotificacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Oculta o formul�rio quando o bot�o de fechar � clicado
  Action := caHide;
end;

procedure TfrmNotificacao.TocarSom;
var
  SoundFilePath: string;
begin
  // Caminho relativo para o arquivo de som
  SoundFilePath := ExtractFilePath(Application.ExeName) + '..\..\som\Som.wav';
  PlaySound(PChar(SoundFilePath), 0, SND_FILENAME or SND_ASYNC);
end;
end.

