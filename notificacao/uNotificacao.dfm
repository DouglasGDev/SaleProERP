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
    ExplicitWidth = 460
    ExplicitHeight = 88
    object lblTitulo: TLabel
      Left = 1
      Top = 1
      Width = 466
      Height = 17
      Align = alTop
      Alignment = taCenter
      Caption = 'Titulo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 37
    end
    object lblMensagem: TLabel
      Left = 1
      Top = 18
      Width = 466
      Height = 81
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
      ExplicitTop = 41
      ExplicitWidth = 67
      ExplicitHeight = 17
    end
  end
  object TimerHide: TTimer
    Left = 288
  end
end
