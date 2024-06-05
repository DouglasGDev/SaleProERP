program ConsultarCEP;

uses
  Vcl.Forms,
  uConsultarCEP in 'uConsultarCEP.pas' {frmConsultarCEP};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmConsultarCEP, frmConsultarCEP);
  Application.Run;
end.
