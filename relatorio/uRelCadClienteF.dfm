object frmRelCadCliente: TfrmRelCadCliente
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio Ficha de Clientes'
  ClientHeight = 1014
  ClientWidth = 806
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Relatorio: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    AdjustableMargins = True
    DataSource = dtsCliente
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Transparent = False
    object Cabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 51
      BandType = btHeader
      Transparent = False
      object RLLabel1: TRLLabel
        Left = 3
        Top = 16
        Width = 211
        Height = 24
        Caption = 'Listagem de  Cliente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLDraw1: TRLDraw
        Left = 0
        Top = 40
        Width = 718
        Height = 11
        Align = faBottom
        DrawKind = dkLine
        Pen.Width = 2
        Transparent = False
      end
    end
    object Rodape: TRLBand
      Left = 38
      Top = 139
      Width = 718
      Height = 50
      BandType = btFooter
      Transparent = False
      object RLDraw2: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 11
        Align = faTop
        DrawKind = dkLine
        Pen.Width = 2
        Transparent = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 3
        Top = 17
        Width = 60
        Height = 16
        Info = itFullDate
        Text = ''
        Transparent = False
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 647
        Top = 17
        Width = 25
        Height = 16
        Info = itPageNumber
        Text = ''
        Transparent = False
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 690
        Top = 17
        Width = 25
        Height = 16
        Info = itLastPageNumber
        Text = ''
        Transparent = False
      end
      object RLLabel2: TRLLabel
        Left = 670
        Top = 17
        Width = 17
        Height = 16
        Caption = '/'
        Transparent = False
      end
      object RLLabel3: TRLLabel
        Left = 588
        Top = 17
        Width = 53
        Height = 16
        Caption = 'P'#225'gina:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 113
      Width = 718
      Height = 26
      Transparent = False
      object RLDBText1: TRLDBText
        Left = 3
        Top = 4
        Width = 52
        Height = 16
        DataField = 'clienteId'
        DataSource = dtsCliente
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 84
        Top = 4
        Width = 36
        Height = 16
        DataField = 'nome'
        DataSource = dtsCliente
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 308
        Top = 4
        Width = 35
        Height = 16
        DataField = 'email'
        DataSource = dtsCliente
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 492
        Top = 6
        Width = 49
        Height = 16
        DataField = 'telefone'
        DataSource = dtsCliente
        Text = ''
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 89
      Width = 718
      Height = 24
      BandType = btColumnHeader
      Transparent = False
      object RLPanel1: TRLPanel
        Left = 0
        Top = 0
        Width = 718
        Height = 24
        Align = faClient
        Color = clInfoBk
        ParentColor = False
        Transparent = False
        object RLLabel4: TRLLabel
          Left = 3
          Top = 2
          Width = 49
          Height = 16
          Caption = 'C'#243'digo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel5: TRLLabel
          Left = 84
          Top = 2
          Width = 41
          Height = 16
          Caption = 'Nome'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel6: TRLLabel
          Left = 308
          Top = 2
          Width = 44
          Height = 16
          Caption = 'E-mail'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel7: TRLLabel
          Left = 492
          Top = 2
          Width = 60
          Height = 16
          Caption = 'Telefone'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
    end
  end
  object QryCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT clientes.clienteId,'
      '       clientes.nome,'
      '       clientes.email,'
      '       clientes.telefone'
      'FROM clientes'
      'ORDER BY clientes.nome')
    Params = <>
    Left = 360
    Top = 176
    object QryClienteclienteId: TZIntegerField
      FieldName = 'clienteId'
      Required = True
    end
    object QryClientenome: TZUnicodeStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryClienteemail: TZUnicodeStringField
      FieldName = 'email'
      Size = 100
    end
    object QryClientetelefone: TZUnicodeStringField
      FieldName = 'telefone'
      Size = 14
    end
  end
  object dtsCliente: TDataSource
    DataSet = QryCliente
    Left = 440
    Top = 176
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0.1.2 \251 Copyright '#169' 1999-20' +
      '21 Fortes Inform'#225'tica'
    FileName = 'C:\Users\Psicocenter\Downloads\Teste5.pdf'
    DisplayName = 'Documento PDF'
    Left = 512
    Top = 264
  end
  object RLXLSXFilter1: TRLXLSXFilter
    FileName = 'C:\Users\Psicocenter\Downloads\teste.xlsx'
    DisplayName = 'Planilha Excel'
    Left = 512
    Top = 320
  end
  object RLXLSFilter1: TRLXLSFilter
    DisplayName = 'Planilha Excel 97-2013'
    Left = 512
    Top = 384
  end
  object RLHTMLFilter1: TRLHTMLFilter
    DocumentStyle = dsCSS2
    DisplayName = 'P'#225'gina da Web'
    Left = 512
    Top = 448
  end
end
