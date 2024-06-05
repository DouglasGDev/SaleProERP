unit uSelecionarData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, RxToolEdit, System.DateUtils,
  Vcl.Buttons;

type
  TfrmSelecionarData = class(TForm)
    lblDataInicio: TLabel;
    edtDataInicio: TDateEdit;
    edtDataFinal: TDateEdit;
    lblDataFinal: TLabel;
    BtnOk: TBitBtn;
    procedure BtnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelecionarData: TfrmSelecionarData;

implementation

{$R *.dfm}

procedure TfrmSelecionarData.BtnOkClick(Sender: TObject);
begin
    if (edtDataFinal.Date) < (edtDataInicio.Date) then begin
      MessageDlg('Data Final n�o pode ser menor do que a data in�cio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
      edtDataFinal.SetFocus;
      Abort;
    end;
    if (edtDataFinal.Date = 0) OR (edtDataInicio.Date = 0) then begin
      MessageDlg('Data Inicial ou final s�o campos obrigat�rios', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
      edtDataInicio.SetFocus;
      Abort;
    end;
   ModalResult := mrOk
end;
procedure TfrmSelecionarData.FormShow(Sender: TObject);
begin
  edtDataInicio.Date := StartOfTheMonth(Date); // deixa no campo com o primeiro dia marcado da data do mes
  edtDataFinal.Date  := EndOfTheMonth(Date);   // e deixa com o ultimo dia do mes
end;

end.

