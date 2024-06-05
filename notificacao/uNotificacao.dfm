object frmNotificacao: TfrmNotificacao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Estoque Baixo'
  ClientHeight = 100
  ClientWidth = 468
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object pnlNotificacao: TPanel
    Left = 0
    Top = 0
    Width = 468
    Height = 100
    Align = alClient
    Color = 33023
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 56
    ExplicitWidth = 185
    ExplicitHeight = 41
    object lblTitulo: TLabel
      Left = 1
      Top = 1
      Width = 466
      Height = 40
      Align = alTop
      Alignment = taCenter
      Caption = 'Titulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblMensagem: TLabel
      Left = 1
      Top = 41
      Width = 466
      Height = 58
      Align = alClient
      Caption = 'Mensagem'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ExplicitTop = 40
      ExplicitWidth = 506
      ExplicitHeight = 26
    end
  end
  object TimerHide: TTimer
    Left = 288
  end
end
