object frmRelCadProdutoComGrupoCategoria: TfrmRelCadProdutoComGrupoCategoria
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Produtos por Categoria'
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
    Left = -4
    Top = 0
    Width = 794
    Height = 1123
    AdjustableMargins = True
    DataSource = dtsProdutos
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
        Width = 372
        Height = 24
        Caption = 'Listagem de Produtos por Categoria'
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
      Top = 233
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
      Height = 144
      DataFields = 'categoriaId'
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
          Left = 79
          Top = 3
          Width = 21
          Height = 16
          AutoSize = False
          DataField = 'categoriaId'
          DataSource = dtsProdutos
          Text = ''
          Transparent = False
        end
        object RLLabel6: TRLLabel
          Left = 3
          Top = 3
          Width = 70
          Height = 16
          Caption = 'Categoria:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBText3: TRLDBText
          Left = 107
          Top = 3
          Width = 117
          Height = 16
          DataField = 'DescricaoCategoria'
          DataSource = dtsProdutos
          Text = ''
          Transparent = False
        end
        object RLLabel9: TRLLabel
          Left = 95
          Top = 3
          Width = 9
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
          Width = 115
          Height = 16
          Caption = 'Nome do Produto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel8: TRLLabel
          Left = 384
          Top = 2
          Width = 100
          Height = 16
          Caption = 'Quant. Estoque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel7: TRLLabel
          Left = 680
          Top = 0
          Width = 38
          Height = 24
          Align = faRight
          Caption = 'Valor'
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
        Height = 26
        Transparent = False
        object RLDBText1: TRLDBText
          Left = 3
          Top = 4
          Width = 57
          Height = 16
          DataField = 'produtoId'
          DataSource = dtsProdutos
          Text = ''
          Transparent = False
        end
        object RLDBText2: TRLDBText
          Left = 84
          Top = 6
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsProdutos
          Text = ''
          Transparent = False
        end
        object RLDBText4: TRLDBText
          Left = 684
          Top = 0
          Width = 34
          Height = 26
          Align = faRight
          DataField = 'Valor'
          DataSource = dtsProdutos
          DisplayMask = '#0.00'
          Text = ''
          Transparent = False
        end
        object RLDBText5: TRLDBText
          Left = 417
          Top = 4
          Width = 70
          Height = 16
          DataField = 'Quantidade'
          DataSource = dtsProdutos
          Text = ''
          Transparent = False
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 75
        Width = 718
        Height = 54
        BandType = btSummary
        object RLDBResult1: TRLDBResult
          Left = 510
          Top = 6
          Width = 109
          Height = 16
          Alignment = taRightJustify
          DataField = 'Quantidade'
          DataSource = dtsProdutos
          Info = riSum
          Text = ''
        end
        object RLDraw3: TRLDraw
          Left = 272
          Top = -3
          Width = 446
          Height = 11
          DrawKind = dkLine
          Transparent = False
        end
        object RLLabel10: TRLLabel
          Left = 271
          Top = 6
          Width = 233
          Height = 16
          Caption = 'Quant. Total Estoque por categoria :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel11: TRLLabel
          Left = 308
          Top = 28
          Width = 196
          Height = 16
          Caption = 'M'#233'dia do valor por categoria :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBResult2: TRLDBResult
          Left = 527
          Top = 28
          Width = 92
          Height = 16
          Alignment = taRightJustify
          DataField = 'Valor'
          DataSource = dtsProdutos
          Info = riAverage
          Text = ''
        end
      end
    end
  end
  object QryProdutos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT produtos.produtoId,'
      '       produtos.nome,'
      '       produtos.descricao,'
      '       CAST(produtos.valor AS FLOAT) AS Valor,'
      '       CAST(produtos.quantidade AS FLOAT) AS Quantidade,'
      '       produtos.categoriaId,'
      '       categorias.descricao AS DescricaoCategoria'
      'FROM produtos'
      
        'LEFT JOIN categorias ON categorias.categoriaId = produtos.catego' +
        'riaId'
      'ORDER BY produtos.categoriaId, produtos.produtoId')
    Params = <>
    Left = 464
    Top = 520
    object QryProdutosprodutoId: TZIntegerField
      FieldName = 'produtoId'
      Required = True
    end
    object QryProdutosnome: TZUnicodeStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryProdutosdescricao: TZUnicodeStringField
      FieldName = 'descricao'
      Size = 255
    end
    object QryProdutosValor: TZDoubleField
      FieldName = 'Valor'
      ReadOnly = True
    end
    object QryProdutosQuantidade: TZDoubleField
      FieldName = 'Quantidade'
      ReadOnly = True
    end
    object QryProdutoscategoriaId: TZIntegerField
      FieldName = 'categoriaId'
    end
    object QryProdutosDescricaoCategoria: TZUnicodeStringField
      FieldName = 'DescricaoCategoria'
      Size = 100
    end
  end
  object dtsProdutos: TDataSource
    DataSet = QryProdutos
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
