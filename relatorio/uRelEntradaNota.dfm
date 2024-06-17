object frmRelEntradaNota: TfrmRelEntradaNota
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Entrada de nota'
  ClientHeight = 1013
  ClientWidth = 802
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
    DataSource = dtsEntradaNota
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
        Width = 64
        Height = 24
        Caption = 'NOTA'
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
      Top = 249
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
      DataFields = 'dataEntrada'
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
          Left = 67
          Top = 3
          Width = 84
          Height = 16
          DataField = 'numnotafiscal'
          DataSource = dtsEntradaNota
          Text = ''
          Transparent = False
        end
        object RLLabel6: TRLLabel
          Left = 3
          Top = 3
          Width = 58
          Height = 16
          Caption = 'Numero:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel21: TRLLabel
          Left = 162
          Top = 3
          Width = 74
          Height = 16
          Caption = 'ID Entrada:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBText10: TRLDBText
          Left = 242
          Top = 3
          Width = 57
          Height = 16
          DataField = 'entradaId'
          DataSource = dtsEntradaNota
          Text = ''
          Transparent = False
        end
        object RLLabel13: TRLLabel
          Left = 594
          Top = 3
          Width = 70
          Height = 16
          Caption = 'Pedido n'#186':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBText11: TRLDBText
          Left = 670
          Top = 3
          Width = 48
          Height = 16
          DataField = 'numpedido'
          DataSource = dtsEntradaNota
          Text = ''
          Transparent = False
        end
        object RLLabel14: TRLLabel
          Left = 406
          Top = 3
          Width = 75
          Height = 16
          Caption = 'Valor Nota:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBText9: TRLDBText
          Left = 487
          Top = 3
          Width = 79
          Height = 16
          DataField = 'TotalNota'
          DataSource = dtsEntradaNota
          DisplayMask = '#0,00'
          Text = 'R$ '
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
          Left = 188
          Top = 3
          Width = 70
          Height = 16
          DataField = 'razaosocial'
          DataSource = dtsEntradaNota
          Text = ''
          Transparent = False
        end
        object RLDBText4: TRLDBText
          Left = 652
          Top = 4
          Width = 74
          Height = 16
          DataField = 'dataEntrada'
          DataSource = dtsEntradaNota
          DisplayMask = 'dd/mm/yyyy'
          Text = ''
          Transparent = False
        end
        object RLLabel9: TRLLabel
          Left = 3
          Top = 3
          Width = 81
          Height = 16
          Caption = 'Fornecedor:'
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
          Left = 90
          Top = 4
          Width = 74
          Height = 16
          DataField = 'fornecedorId'
          DataSource = dtsEntradaNota
          Text = ''
          Transparent = False
        end
        object RLLabel4: TRLLabel
          Left = 170
          Top = 4
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
        DataSource = dtsEntradaNotaItens
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
            Left = 613
            Top = 0
            Width = 39
            Height = 16
            Caption = 'Custo'
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
            DataSource = dtsEntradaNotaItens
            Text = ''
            Transparent = False
          end
          object RLLabel10: TRLLabel
            Left = 31
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
            Left = 58
            Top = 3
            Width = 36
            Height = 16
            DataField = 'nome'
            DataSource = dtsEntradaNotaItens
            Text = ''
            Transparent = False
          end
          object RLDBText7: TRLDBText
            Left = 613
            Top = 3
            Width = 56
            Height = 16
            DataField = 'custo'
            DataSource = dtsEntradaNotaItens
            DisplayMask = '#0,00'
            Text = 'R$ '
            Transparent = False
          end
          object RLDBText8: TRLDBText
            Left = 360
            Top = 3
            Width = 67
            Height = 16
            DataField = 'quantidade'
            DataSource = dtsEntradaNotaItens
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
      Height = 48
      Transparent = False
      object RLDraw4: TRLDraw
        Left = 0
        Top = 6
        Width = 718
        Height = 11
        DrawKind = dkLine
        Transparent = False
      end
    end
  end
  object QryEntradaNota: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT entradanota.entradaId,'
      '       entradanota.fornecedorId,'
      '       fornecedores.razaosocial,'
      '       entradanota.numnotafiscal,'
      '       entradanota.numpedido,'
      '       entradanota.dataEntrada,'
      'CAST(entradanota.valorTotalNota AS FLOAT) AS TotalNota'
      'FROM entradanota'
      
        'INNER JOIN fornecedores ON fornecedores.fornecedorId = entradano' +
        'ta.fornecedorId'
      'WHERE entradanota.entradaId = :entradaId ')
    Params = <
      item
        DataType = ftWideString
        Name = 'entradaId'
        ParamType = ptInput
        SQLType = stString
        Value = 'Entrada202406103300062'
      end>
    Left = 448
    Top = 392
    ParamData = <
      item
        DataType = ftWideString
        Name = 'entradaId'
        ParamType = ptInput
        SQLType = stString
        Value = 'Entrada202406103300062'
      end>
    object QryEntradaNotaentradaId: TZUnicodeStringField
      FieldName = 'entradaId'
      Size = 50
    end
    object QryEntradaNotafornecedorId: TZIntegerField
      FieldName = 'fornecedorId'
      Required = True
    end
    object QryEntradaNotarazaosocial: TZUnicodeStringField
      FieldName = 'razaosocial'
      Size = 255
    end
    object QryEntradaNotanumnotafiscal: TZUnicodeStringField
      FieldName = 'numnotafiscal'
      Size = 50
    end
    object QryEntradaNotanumpedido: TZIntegerField
      FieldName = 'numpedido'
    end
    object QryEntradaNotadataEntrada: TZDateTimeField
      FieldName = 'dataEntrada'
    end
    object QryEntradaNotaTotalNota: TZDoubleField
      FieldName = 'TotalNota'
      ReadOnly = True
    end
  end
  object dtsEntradaNota: TDataSource
    DataSet = QryEntradaNota
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
  object QryEntradaNotaItens: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT itens_entradanota.entradaId,'
      '       itens_entradanota.produtoId,'
      '       produtos.nome,'
      '       itens_entradanota.quantidade,'
      '       produtos.custo'
      'FROM itens_entradanota'
      
        'INNER JOIN produtos ON produtos.produtoId = itens_entradanota.pr' +
        'odutoId'
      'WHERE itens_entradanota.entradaId= :entradaId'
      'ORDER BY itens_entradanota.produtoId')
    Params = <
      item
        DataType = ftWideString
        Name = 'entradaId'
        ParamType = ptInput
        SQLType = stString
      end>
    Left = 432
    Top = 464
    ParamData = <
      item
        DataType = ftWideString
        Name = 'entradaId'
        ParamType = ptInput
        SQLType = stString
      end>
    object QryEntradaNotaItensentradaId: TZUnicodeStringField
      FieldName = 'entradaId'
      Required = True
      Size = 50
    end
    object QryEntradaNotaItensprodutoId: TZIntegerField
      FieldName = 'produtoId'
      Required = True
    end
    object QryEntradaNotaItensnome: TZUnicodeStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryEntradaNotaItensquantidade: TZFMTBCDField
      FieldName = 'quantidade'
      Precision = 18
      Size = 5
    end
    object QryEntradaNotaItenscusto: TZFMTBCDField
      FieldName = 'custo'
      Precision = 18
      Size = 5
    end
  end
  object dtsEntradaNotaItens: TDataSource
    DataSet = QryEntradaNotaItens
    Left = 552
    Top = 464
  end
end
