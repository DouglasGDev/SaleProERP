object frmAtualizaDB: TfrmAtualizaDB
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'frmAtualizaDB'
  ClientHeight = 56
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 56
    Align = alClient
    BevelOuter = bvLowered
    BevelWidth = 3
    BorderWidth = 3
    Color = clBlue
    ParentBackground = False
    TabOrder = 0
    ExplicitHeight = 259
    object Panel2: TPanel
      Left = 6
      Top = 6
      Width = 628
      Height = 44
      Align = alClient
      BevelOuter = bvNone
      Color = clTeal
      Enabled = False
      ParentBackground = False
      TabOrder = 0
      ExplicitHeight = 211
      object lbldb: TLabel
        Left = 0
        Top = 0
        Width = 590
        Height = 37
        Caption = 'Atualiza'#231#227'o do Banco de dados ... AGUARDE ...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -27
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
end
