object frmRelVenda: TfrmRelVenda
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Venda'
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
    AdjustableMargins = True
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
        Width = 77
        Height = 24
        Caption = 'VENDA'
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
      Top = 252
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
    object BandaDoGrupo: TRLGroup
      Left = 38
      Top = 89
      Width = 718
      Height = 112
      DataFields = 'dataVenda'
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
          Left = 58
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
          Width = 49
          Height = 16
          Caption = 'Venda:'
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
        Top = 25
        Width = 718
        Height = 26
        Transparent = False
        object RLDBText2: TRLDBText
          Left = 162
          Top = 3
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsVenda
          Text = ''
          Transparent = False
        end
        object RLDBText4: TRLDBText
          Left = 652
          Top = 4
          Width = 66
          Height = 16
          DataField = 'dataVenda'
          DataSource = dtsVenda
          DisplayMask = 'dd/mm/yyyy'
          Text = ''
          Transparent = False
        end
        object RLLabel9: TRLLabel
          Left = 3
          Top = 4
          Width = 114
          Height = 16
          Caption = 'Nome do Cliente:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel7: TRLLabel
          Left = 613
          Top = 4
          Width = 33
          Height = 16
          Caption = 'Data'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBText1: TRLDBText
          Left = 123
          Top = 4
          Width = 22
          Height = 16
          DataField = 'clienteId'
          DataSource = dtsVenda
          Text = ''
          Transparent = False
        end
        object RLLabel4: TRLLabel
          Left = 145
          Top = 2
          Width = 12
          Height = 16
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
      object RLSubDetail1: TRLSubDetail
        Left = 0
        Top = 51
        Width = 718
        Height = 64
        DataSource = dtsVendaItens
        Transparent = False
        object RLBand2: TRLBand
          Left = 0
          Top = 0
          Width = 718
          Height = 19
          BandType = btHeader
          Color = clInfoBk
          ParentColor = False
          Transparent = False
          object RLLabel5: TRLLabel
            Left = 3
            Top = 0
            Width = 60
            Height = 16
            Caption = 'Produtos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel11: TRLLabel
            Left = 523
            Top = 0
            Width = 67
            Height = 16
            Caption = 'Valor Und'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel13: TRLLabel
            Left = 641
            Top = 0
            Width = 74
            Height = 16
            Caption = 'Valor Total'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel12: TRLLabel
            Left = 360
            Top = 0
            Width = 78
            Height = 16
            Caption = 'Quantidade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
        object RLBand4: TRLBand
          Left = 0
          Top = 19
          Width = 718
          Height = 22
          Transparent = False
          object RLDBText3: TRLDBText
            Left = 3
            Top = 3
            Width = 22
            Height = 16
            DataField = 'produtoId'
            DataSource = dtsVendaItens
            Text = ''
            Transparent = False
          end
          object RLLabel10: TRLLabel
            Left = 26
            Top = 3
            Width = 12
            Height = 16
            Caption = '-'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLDBText5: TRLDBText
            Left = 43
            Top = 3
            Width = 36
            Height = 16
            DataField = 'nome'
            DataSource = dtsVendaItens
            Text = ''
            Transparent = False
          end
          object RLDBText7: TRLDBText
            Left = 523
            Top = 3
            Width = 74
            Height = 16
            DataField = 'valorUnitario'
            DataSource = dtsVendaItens
            Text = ''
            Transparent = False
          end
          object RLDBText9: TRLDBText
            Left = 641
            Top = 3
            Width = 74
            Height = 16
            DataField = 'totalProduto'
            DataSource = dtsVendaItens
            Text = ''
            Transparent = False
          end
          object RLDBText8: TRLDBText
            Left = 360
            Top = 3
            Width = 67
            Height = 16
            DataField = 'quantidade'
            DataSource = dtsVendaItens
            Text = ''
            Transparent = False
          end
        end
      end
    end
    object RLBand5: TRLBand
      Left = 38
      Top = 201
      Width = 718
      Height = 51
      BandType = btSummary
      Transparent = False
      object RLLabel8: TRLLabel
        Left = 360
        Top = 16
        Width = 103
        Height = 16
        Caption = 'Total da venda:'
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
        DisplayMask = '#0.00'
        Info = riSum
        Text = ''
        Transparent = False
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
  object QryVenda: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT vendas.vendaId,'
      '       vendas.clienteId,'
      '       clientes.nome,'
      '       vendas.dataVenda,'
      'CAST(vendas.totalVenda AS FLOAT) AS TotalVenda'
      'FROM vendas'
      'INNER JOIN clientes ON clientes.clienteId = vendas.clienteId'
      'WHERE vendas.vendaId = :vendaId')
    Params = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        SQLType = stInteger
        Value = 7
      end>
    Left = 464
    Top = 392
    ParamData = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        SQLType = stInteger
        Value = 7
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
      DisplayFormat = '#0.00'
    end
  end
  object dtsVenda: TDataSource
    DataSet = QryVenda
    Left = 544
    Top = 392
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
  object QryVendaItens: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT vendasitens.vendaId,'
      '       vendasitens.produtoId,'
      '       produtos.nome,'
      '       vendasitens.quantidade,'
      '       vendasitens.valorUnitario,'
      '       vendasitens.totalProduto'
      'FROM vendasItens'
      
        'INNER JOIN produtos ON produtos.produtoId = vendasitens.produtoI' +
        'd'
      'WHERE vendasitens.vendaId = :vendaId'
      'ORDER BY vendasitens.produtoId')
    Params = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        SQLType = stInteger
        Value = 7
      end>
    Left = 464
    Top = 464
    ParamData = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        SQLType = stInteger
        Value = 7
      end>
    object QryVendaItensvendaId: TZIntegerField
      FieldName = 'vendaId'
      Required = True
    end
    object QryVendaItensprodutoId: TZIntegerField
      FieldName = 'produtoId'
      Required = True
    end
    object QryVendaItensnome: TZUnicodeStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryVendaItensquantidade: TZFMTBCDField
      FieldName = 'quantidade'
      DisplayFormat = '#0.00'
      Precision = 18
      Size = 5
    end
    object QryVendaItensvalorUnitario: TZFMTBCDField
      FieldName = 'valorUnitario'
      DisplayFormat = '#0.00'
      Precision = 18
      Size = 5
    end
    object QryVendaItenstotalProduto: TZFMTBCDField
      FieldName = 'totalProduto'
      DisplayFormat = '#0.00'
      Precision = 18
      Size = 5
    end
  end
  object dtsVendaItens: TDataSource
    DataSet = QryVendaItens
    Left = 544
    Top = 464
  end
end
