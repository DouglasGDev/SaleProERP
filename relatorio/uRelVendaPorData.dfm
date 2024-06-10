object frmRelVendaPorData: TfrmRelVendaPorData
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Venda por data'
  ClientHeight = 1014
  ClientWidth = 806
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnDestroy = FormDestroy
  TextHeight = 15
  object Relatorio: TRLReport
    Left = 4
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dtsVenda
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
        Width = 291
        Height = 24
        Caption = 'Listagem de Venda por Data'
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
      object rllblDataInicio: TRLLabel
        Left = 523
        Top = 18
        Width = 68
        Height = 16
        Caption = 'xxxxxxxx'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object rllblDataFim: TRLLabel
        Left = 647
        Top = 18
        Width = 68
        Height = 16
        Caption = 'xxxxxxxx'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel9: TRLLabel
        Left = 455
        Top = 18
        Width = 62
        Height = 16
        Caption = 'Per'#237'odo :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel11: TRLLabel
        Left = 597
        Top = 18
        Width = 44
        Height = 16
        Caption = 'ao dia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
    object Rodape: TRLBand
      Left = 38
      Top = 317
      Width = 718
      Height = 47
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
    object BandaDoGrupo: TRLGroup
      Left = 38
      Top = 89
      Width = 718
      Height = 228
      DataFields = 'vendaId'
      Transparent = False
      object RLBand3: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 25
        BandType = btHeader
        Color = clSilver
        ParentColor = False
        Transparent = False
        object RLDBText6: TRLDBText
          Left = 61
          Top = 3
          Width = 47
          Height = 16
          DataField = 'vendaId'
          DataSource = dtsVenda
          Text = ''
          Transparent = False
        end
        object RLLabel6: TRLLabel
          Left = 3
          Top = 3
          Width = 52
          Height = 16
          Caption = 'VENDA:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel12: TRLLabel
          Left = 242
          Top = 3
          Width = 47
          Height = 16
          Caption = 'DATA :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBText3: TRLDBText
          Left = 295
          Top = 3
          Width = 66
          Height = 16
          DataField = 'dataVenda'
          DataSource = dtsVenda
          Text = ''
          Transparent = False
        end
      end
      object RLBand2: TRLBand
        Left = 0
        Top = 25
        Width = 718
        Height = 24
        BandType = btColumnHeader
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
          Width = 110
          Height = 16
          Caption = 'Nome do Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel7: TRLLabel
          Left = 615
          Top = 0
          Width = 103
          Height = 24
          Align = faRight
          Caption = 'Valor da Venda'
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
        Left = 0
        Top = 49
        Width = 718
        Height = 24
        Transparent = False
        object RLDBText1: TRLDBText
          Left = 3
          Top = 4
          Width = 52
          Height = 16
          DataField = 'clienteId'
          DataSource = dtsVenda
          Text = ''
          Transparent = False
        end
        object RLDBText2: TRLDBText
          Left = 84
          Top = 6
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsVenda
          Text = ''
          Transparent = False
        end
        object RLDBText4: TRLDBText
          Left = 649
          Top = 0
          Width = 69
          Height = 24
          Align = faRight
          DataField = 'TotalVenda'
          DataSource = dtsVenda
          DisplayMask = 'R$ 0.00'
          Text = ''
          Transparent = False
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 73
        Width = 718
        Height = 88
        BandType = btSummary
        object RLDBResult1: TRLDBResult
          Left = 523
          Top = 6
          Width = 108
          Height = 16
          Alignment = taRightJustify
          DataField = 'TotalVenda'
          DataSource = dtsVenda
          DisplayMask = 'R$ 0.00'
          Info = riSum
          Text = ''
        end
        object RLDraw3: TRLDraw
          Left = 360
          Top = -3
          Width = 358
          Height = 11
          DrawKind = dkLine
          Transparent = False
        end
        object RLLabel10: TRLLabel
          Left = 360
          Top = 6
          Width = 98
          Height = 16
          Caption = 'Total por Data:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel14: TRLLabel
          Left = 0
          Top = 6
          Width = 118
          Height = 16
          Caption = 'Tipos pagamento:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel15: TRLLabel
          Left = 3
          Top = 32
          Width = 54
          Height = 16
          Caption = 'PIX : R$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBResultPix: TRLDBResult
          Left = 95
          Top = 32
          Width = 84
          Height = 16
          DataField = 'PPIX'
          DataSource = dtsVenda
          DisplayMask = '#0.00'
          Text = ''
        end
        object RLLabel16: TRLLabel
          Left = 0
          Top = 54
          Width = 89
          Height = 16
          Caption = 'CR'#201'DITO : R$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBResultCredito: TRLDBResult
          Left = 95
          Top = 54
          Width = 121
          Height = 16
          DataField = 'CCREDITO'
          DataSource = dtsVenda
          DisplayMask = '#0.00'
          Text = ''
        end
        object RLLabel17: TRLLabel
          Left = 222
          Top = 32
          Width = 80
          Height = 16
          Caption = 'D'#201'BITO : R$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBResultDebito: TRLDBResult
          Left = 322
          Top = 32
          Width = 112
          Height = 16
          DataField = 'DDEBITO'
          DataSource = dtsVenda
          DisplayMask = '#0.00'
          Text = ''
        end
        object RLDBResultDinheiro: TRLDBResult
          Left = 322
          Top = 54
          Width = 126
          Height = 16
          DataField = 'DDINHEIRO'
          DataSource = dtsVenda
          DisplayMask = '#0.00'
          Text = ''
        end
        object RLLabel18: TRLLabel
          Left = 222
          Top = 54
          Width = 94
          Height = 16
          Caption = 'DINHEIRO : R$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
      object RLBand5: TRLBand
        Left = 0
        Top = 161
        Width = 718
        Height = 58
        BandType = btSummary
        object RLLabel8: TRLLabel
          Left = 360
          Top = 16
          Width = 83
          Height = 16
          Caption = 'Total Geral :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBResult2: TRLDBResult
          Left = 523
          Top = 16
          Width = 108
          Height = 16
          Alignment = taRightJustify
          DataField = 'TotalVenda'
          DataSource = dtsVenda
          DisplayMask = 'R$ 0.00'
          Info = riSum
          Text = ''
        end
        object RLDraw4: TRLDraw
          Left = 360
          Top = 6
          Width = 358
          Height = 11
          DrawKind = dkLine
          Transparent = False
        end
      end
    end
  end
  object QryVenda: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT vendas.vendaId,'
      '       vendas.clienteId,'
      '       clientes.nome,'
      '       vendas.dataVenda,'
      'CAST(vendas.totalVenda AS FLOAT) AS TotalVenda,'
      'CAST(vendas.pix AS FLOAT) AS PPIX,'
      'CAST(vendas.credito AS FLOAT) AS CCREDITO,'
      'CAST(vendas.debito AS FLOAT) AS DDEBITO,'
      'CAST(vendas.dinheiro AS FLOAT) AS DDINHEIRO'
      'FROM vendas'
      'INNER JOIN clientes ON clientes.clienteId = vendas.clienteId'
      'WHERE vendas.dataVenda BETWEEN :DataInicio AND :DataFim'
      'ORDER BY vendas.dataVenda, vendas.clienteId')
    Params = <
      item
        DataType = ftDate
        Name = 'DataInicio'
        ParamType = ptInput
        SQLType = stDate
      end
      item
        DataType = ftDate
        Name = 'DataFim'
        ParamType = ptInput
        SQLType = stDate
      end>
    Left = 464
    Top = 520
    ParamData = <
      item
        DataType = ftDate
        Name = 'DataInicio'
        ParamType = ptInput
        SQLType = stDate
      end
      item
        DataType = ftDate
        Name = 'DataFim'
        ParamType = ptInput
        SQLType = stDate
      end>
    object QryVendavendaId: TZIntegerField
      FieldName = 'vendaId'
      Required = True
    end
    object QryVendaclienteId: TZIntegerField
      FieldName = 'clienteId'
      Required = True
    end
    object QryVendanome: TZUnicodeStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryVendadataVenda: TZDateTimeField
      FieldName = 'dataVenda'
    end
    object QryVendaTotalVenda: TZDoubleField
      FieldName = 'TotalVenda'
      ReadOnly = True
    end
    object QryVendaPPIX: TZDoubleField
      FieldName = 'PPIX'
      ReadOnly = True
    end
    object QryVendaCCREDITO: TZDoubleField
      FieldName = 'CCREDITO'
      ReadOnly = True
    end
    object QryVendaDDEBITO: TZDoubleField
      FieldName = 'DDEBITO'
      ReadOnly = True
    end
    object QryVendaDDINHEIRO: TZDoubleField
      FieldName = 'DDINHEIRO'
      ReadOnly = True
    end
  end
  object dtsVenda: TDataSource
    DataSet = QryVenda
    Left = 576
    Top = 528
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0.1.2 \251 Copyright '#169' 1999-20' +
      '21 Fortes Inform'#225'tica'
    FileName = 'C:\Users\Psicocenter\Downloads\teste.pdf'
    DisplayName = 'Documento PDF'
    Left = 520
    Top = 552
  end
  object RLXLSXFilter1: TRLXLSXFilter
    DisplayName = 'Planilha Excel'
    Left = 520
    Top = 608
  end
  object RLHTMLFilter1: TRLHTMLFilter
    DocumentStyle = dsCSS2
    DisplayName = 'P'#225'gina da Web'
    Left = 520
    Top = 736
  end
end