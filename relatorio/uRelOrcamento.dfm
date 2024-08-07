object frmRelOrcamento: TfrmRelOrcamento
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Or'#231'amento'
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
    DataSource = dtsOrcamento
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
        Top = 15
        Width = 141
        Height = 24
        Caption = 'OR'#199'AMENTO'
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
      Top = 257
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
      DataFields = 'dataOrcamento'
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
          Left = 162
          Top = 4
          Width = 75
          Height = 16
          DataField = 'orcamentoId'
          DataSource = dtsOrcamento
          Text = ''
          Transparent = False
        end
        object RLLabel6: TRLLabel
          Left = 3
          Top = 4
          Width = 150
          Height = 16
          Caption = 'N'#250'mero do or'#231'amento:'
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
          Top = 4
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsOrcamento
          Text = ''
          Transparent = False
        end
        object RLDBText4: TRLDBText
          Left = 625
          Top = 0
          Width = 93
          Height = 26
          Align = faRight
          DataField = 'dataOrcamento'
          DataSource = dtsOrcamento
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
          Left = 524
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
          DataSource = dtsOrcamento
          Text = ''
          Transparent = False
        end
      end
      object RLSubDetail1: TRLSubDetail
        Left = 0
        Top = 51
        Width = 718
        Height = 64
        DataSource = dtsOrcamentoItens
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
            DataSource = dtsOrcamentoItens
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
            Left = 44
            Top = 3
            Width = 36
            Height = 16
            DataField = 'nome'
            DataSource = dtsOrcamentoItens
            Text = ''
            Transparent = False
          end
          object RLDBText7: TRLDBText
            Left = 523
            Top = 3
            Width = 74
            Height = 16
            DataField = 'valorUnitario'
            DataSource = dtsOrcamentoItens
            DisplayMask = 'R$ #0.00'
            Text = ''
            Transparent = False
          end
          object RLDBText9: TRLDBText
            Left = 615
            Top = 0
            Width = 103
            Height = 22
            Align = faRight
            DataField = 'valorTotalProduto'
            DataSource = dtsOrcamentoItens
            DisplayMask = 'R$ #0.00'
            Text = ''
            Transparent = False
          end
          object RLDBText8: TRLDBText
            Left = 360
            Top = 3
            Width = 67
            Height = 16
            DataField = 'quantidade'
            DataSource = dtsOrcamentoItens
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
      Height = 56
      BandType = btSummary
      Transparent = False
      object RLLabel8: TRLLabel
        Left = 360
        Top = 16
        Width = 132
        Height = 16
        Caption = 'Total do or'#231'amento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLDBResult2: TRLDBResult
        Left = 524
        Top = 16
        Width = 135
        Height = 16
        Alignment = taRightJustify
        DataField = 'TotalOrcamento'
        DataSource = dtsOrcamento
        DisplayMask = 'R$ #0.00'
        Info = riSum
        Text = ''
        Transparent = False
      end
      object RLDraw4: TRLDraw
        Left = 0
        Top = 6
        Width = 718
        Height = 11
        DrawKind = dkLine
        Transparent = False
      end
      object RLDBResultDinheiro: TRLDBResult
        Left = 300
        Top = 62
        Width = 126
        Height = 16
        DataField = 'DDINHEIRO'
        DataSource = dtsOrcamento
        DisplayMask = '#0.00'
        Text = ''
      end
    end
  end
  object QryOrcamento: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT orcamentos.orcamentoId,'
      '       orcamentos.clienteId,'
      '       clientes.nome,'
      '      orcamentos.dataOrcamento,'
      'CAST(orcamentos.totalOrcamento AS FLOAT) AS TotalOrcamento'
      'FROM orcamentos'
      'INNER JOIN clientes ON clientes.clienteId = orcamentos.clienteId'
      'WHERE orcamentos.orcamentoId = :orcamentoId')
    Params = <
      item
        Name = 'orcamentoId'
      end>
    Left = 464
    Top = 392
    ParamData = <
      item
        Name = 'orcamentoId'
      end>
    object QryOrcamentoorcamentoId: TZIntegerField
      FieldName = 'orcamentoId'
      Required = True
    end
    object QryOrcamentoclienteId: TZIntegerField
      FieldName = 'clienteId'
      Required = True
    end
    object QryOrcamentonome: TZUnicodeStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryOrcamentodataOrcamento: TZDateTimeField
      FieldName = 'dataOrcamento'
      Required = True
    end
    object QryOrcamentoTotalOrcamento: TZDoubleField
      FieldName = 'TotalOrcamento'
      ReadOnly = True
    end
  end
  object dtsOrcamento: TDataSource
    DataSet = QryOrcamento
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
  object QryOrcamentoItens: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT itens_orcamento.orcamentoId,'
      '       itens_orcamento.produtoId,'
      '       produtos.nome,'
      '       itens_orcamento.quantidade,'
      '       itens_orcamento.valorUnitario,'
      '       itens_orcamento.valorTotalProduto'
      'FROM itens_orcamento'
      
        'INNER JOIN produtos ON produtos.produtoId = itens_orcamento.prod' +
        'utoId'
      'WHERE itens_orcamento.orcamentoId = :orcamentoId'
      'ORDER BY itens_orcamento.produtoId')
    Params = <
      item
        Name = 'orcamentoId'
      end>
    Left = 464
    Top = 464
    ParamData = <
      item
        Name = 'orcamentoId'
      end>
    object QryOrcamentoItensorcamentoId: TZIntegerField
      FieldName = 'orcamentoId'
      Required = True
    end
    object QryOrcamentoItensprodutoId: TZIntegerField
      FieldName = 'produtoId'
      Required = True
    end
    object QryOrcamentoItensnome: TZUnicodeStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryOrcamentoItensquantidade: TZFMTBCDField
      FieldName = 'quantidade'
      Required = True
      Precision = 18
      Size = 5
    end
    object QryOrcamentoItensvalorUnitario: TZFMTBCDField
      FieldName = 'valorUnitario'
      Required = True
      Precision = 18
      Size = 5
    end
    object QryOrcamentoItensvalorTotalProduto: TZFMTBCDField
      FieldName = 'valorTotalProduto'
      Required = True
      Precision = 18
      Size = 5
    end
  end
  object dtsOrcamentoItens: TDataSource
    DataSet = QryOrcamentoItens
    Left = 544
    Top = 464
  end
end
