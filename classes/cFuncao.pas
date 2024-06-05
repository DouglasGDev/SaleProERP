unit cFuncao;

interface

uses System.Classes,
     Vcl.Controls,
     Vcl.ExtCtrls,
     Vcl.Dialogs,
     ZAbstractConnection,
     ZConnection,
     ZAbstractRODataset,
     ZAbstractDataset,
     ZDataset,
     System.SysUtils,
     Vcl.Forms,
     Vcl.Buttons,
     cAcaoAcesso,
     cUsuarioLogado,
     RLReport,
     uSelecionarData,
     uRelVendaPorData,
     uDTMConexao,

     Vcl.Imaging.pngimage,
     Vcl.Imaging.jpeg,
     Vcl.Graphics,
     Vcl.ExtDlgs;

type
  TFuncao = class
  private


  public
    class procedure CriarForm(aNomeForm: TFormClass; oUsuarioLogado: TUsuarioLogado; aConexao:TZConnection); static;
    class procedure CriarRelatorio(aNomeForm: TFormClass; oUsuarioLogado: TUsuarioLogado ; aConexao:TZConnection); static;
    class procedure CriarRelatorioPorData(aNomeForm: TFormClass; oUsuarioLogado: TUsuarioLogado; aConexao: TZConnection); static;
    class procedure CarregarImagem(aImage:TImage); static; // pra carregar imagem dos produtos
    class procedure LimparImagem(var aImage:TImage); static;// pra limpar

  end;

implementation


{$region 'limpar imagem e procedure gigante para ler e transformar imagens'}
class procedure TFuncao.LimparImagem(var aImage: TImage);// pra tirar a imagem do campo imagem do cadastro de produto ou quaquer outro campo
begin
  aImage.Picture.Assign(nil);
end;

class procedure TFuncao.CarregarImagem(aImage: TImage);
   var
   Bmp, BmpTrans: TBitmap; // o tipo de imagem
   Jpg: TJPEGImage; // o tipo de imagem
   Pic: TPicture;  // o tipo de imagem
   Png: TPngImage; // o tipo de imagem
   opdSelecionar:TOPenPictureDialog; // abre uma tela de selecionar imagem
   iWidth: Integer;  // define a largura
   iHeight: Integer; // define a altura
begin
try
  iWidth:= 160;// tamanho que vai gravar no banco de dados
  iHeight:= 130;// tamanho que vai gravar no banco de dados
  opdSelecionar:=TOpenPictureDialog.Create(nil);// cria o componente de dialog
  opdSelecionar.Filter:= 'All (*.bmp; *.jpg; *.jpeg; *.png) | *.jpg; *.jpeg; *.bmp; *.png|Bitmaps '+  //filtros de imagem
                         ' (*.bmp) | *.bmp|JPEG Image File (*.jpg; *.jpeg) |*.jpg; *.jpeg| '+
                         'PNG(*.png)| *.png';
  opdSelecionar.Title:='Selecione a imagem'; // titulo do dialog
  opdSelecionar.Execute;// executa a sele��o

  if opdSelecionar.FileName<>EmptyStr then begin
    if (POS('.JPG', UpperCase(opdSelecionar.FileName))>0) or ( POS('.JPEG',UpperCase(opdSelecionar.FileName))>0) then begin  //jpg
      Bmp := TBitmap.Create;
      Jpg := TJPEGImage.Create;
      Pic := TPicture.Create;
      try
        Pic.LoadFromFile(opdSelecionar.FileName);
        Jpg.Assign(Pic);
        Jpg.CompressionQuality := 7;
        Bmp.Width := iWidth;
        Bmp.Height := iHeight;
        Bmp.Canvas.StretchDraw(Rect(0,0,Bmp.Width, Bmp.Height), Jpg);
        aImage.Picture.Bitmap := Bmp;
      finally
        Pic.Free;
        Jpg.Free;
        Bmp.Free;
      end
    end
    else if (POS('.PNG', UpperCase(opdSelecionar.FileName))>0) then begin  //png
      Bmp := TBitmap.Create;
      png := TPngImage.Create;
      Pic := TPicture.Create;
      try
        Pic.LoadFromFile(opdSelecionar.FileName);
        png.Assign(Pic);
        Bmp.Width := iWidth;
        Bmp.Height := iHeight;
        Bmp.Canvas.StretchDraw(Rect(0,0,Bmp.Width, Bmp.Height), png);
        aImage.Picture.Bitmap := Bmp;
      finally
        Pic.Free;
        Png.Free;
        Bmp.Free;
      end
    end
    else begin
      try
        Bmp := TBitmap.Create;   //bmp de transi��o
        BmpTrans := TBitmap.Create;
        Pic := TPicture.Create;

        Pic.LoadFromFile(opdSelecionar.FileName);
        png.Assign(Pic.Bitmap);
        Bmp.Width := iWidth;
        Bmp.Height := iHeight;
        Bmp.Canvas.StretchDraw(Rect(0,0,Bmp.Width, Bmp.Height), BmpTrans);
        aImage.Picture.Bitmap := Bmp;
      finally
        Pic.Free;
        BmpTrans.Free;
        Bmp.Free;
      end;
    end;
  end;

finally

end;

end;
{$endregion}

{$region 'formularios'}

class procedure TFuncao.CriarForm(aNomeForm: TFormClass; oUsuarioLogado: TUsuarioLogado; aConexao:TZConnection);// pra criar os formularios quando chamamos na tela principal
var form: TForm;
begin
  try
    form := aNomeForm.Create(Application);
    if TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, form.Name, aConexao) then
    begin
      form.ShowModal;
    end
    else begin
       MessageDlg('Usu�rio: '+oUsuarioLogado.nome +' N�o tem Permiss�o de Acesso',mtWarning,[mbOK],0);
    end;
  finally
    if Assigned(form) then
       form.Release;
  end;
end;


class procedure TFuncao.CriarRelatorio(aNomeForm: TFormClass; oUsuarioLogado: TUsuarioLogado; aConexao:TZConnection); // pra criar os relat�rios quando chamamos na tela principal
var form: TForm;
    aRelatorio:TRLReport;
    i:Integer;
begin
  try
    form := aNomeForm.Create(Application);
    if TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, form.Name, aConexao) then
    begin
      for I := 0 to form.ComponentCount-1 do
      begin
        if form.Components[i] is TRLReport then
        begin
           TRLReport(form.Components[i]).PreviewModal;
           Break;
        end;
      end;
    end
    else begin
       MessageDlg('Usu�rio: '+oUsuarioLogado.nome +', n�o tem permiss�o de acesso',mtWarning,[mbOK],0);
    end;
  finally
    if Assigned(form) then
       form.Release;
  end;
end;

class procedure TFuncao.CriarRelatorioPorData(aNomeForm: TFormClass; oUsuarioLogado: TUsuarioLogado; aConexao: TZConnection);
var
  frmSelecionarData: TfrmSelecionarData;
  frmRelVendaPorData: TfrmRelVendaPorData;
begin
  frmSelecionarData := TfrmSelecionarData.Create(nil);
  try
    if frmSelecionarData.ShowModal = mrOk then
    begin
      frmRelVendaPorData := TfrmRelVendaPorData.Create(nil);
      try
        if TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, frmRelVendaPorData.Name, aConexao) then
        begin
          frmRelVendaPorData.QryVenda.Close;
          frmRelVendaPorData.QryVenda.ParamByName('DataInicio').AsDate := frmSelecionarData.edtDataInicio.Date;
          frmRelVendaPorData.QryVenda.ParamByName('DataFim').AsDate := frmSelecionarData.edtDataFinal.Date;

          frmRelVendaPorData.rllblDataInicio.Caption := DateToStr(frmSelecionarData.edtDataInicio.Date);
          frmRelVendaPorData.rllblDataFim.Caption := DateToStr(frmSelecionarData.edtDataFinal.Date);

          frmRelVendaPorData.QryVenda.Open;
          frmRelVendaPorData.Relatorio.PreviewModal;
        end
        else
        begin
          MessageDlg('Usu�rio: ' + oUsuarioLogado.nome + ', n�o tem permiss�o de acesso', mtWarning, [mbOK], 0);
        end;
      finally
        frmRelVendaPorData.Release;
      end;
    end;
  finally
    frmSelecionarData.Release;
  end;
end;
{$endregion}


end.
