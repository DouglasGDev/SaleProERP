inherited frmConsultaExtratoProduto: TfrmConsultaExtratoProduto
  Caption = 'Extrato de Produtos'
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    inherited tabListagem: TTabSheet
      inherited pnlListagemTopo: TPanel
        inherited lblIndice: TLabel
          Left = 144
          ExplicitLeft = 144
        end
        object lblFilial: TLabel [1]
          Left = 56
          Top = 1
          Width = 30
          Height = 17
          Caption = 'Filial'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        inherited mskPesquisar: TMaskEdit
          Left = 144
          ExplicitLeft = 144
        end
        inherited btnPesquisar: TBitBtn
          Left = 511
          Top = 22
          TabOrder = 2
          ExplicitLeft = 511
          ExplicitTop = 22
        end
        object lkpFilial: TDBLookupComboBox
          Left = 56
          Top = 22
          Width = 76
          Height = 25
          KeyField = 'filialId'
          ListField = 'numfilial'
          ListFieldIndex = 1
          ListSource = dtsFilial
          TabOrder = 1
          OnExit = lkpFilialExit
        end
      end
      inherited grdListagem: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'produtoId'
            Width = 181
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 586
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'codbarras'
            Width = 64
            Visible = True
          end>
      end
      inherited pnlTitulo: TPanel
        Caption = 'Extrato de Produtos'
      end
    end
    inherited tabManutencao: TTabSheet
      object lblFoto: TLabel
        Left = 31
        Top = 69
        Width = 124
        Height = 21
        Caption = 'Foto do produto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDescricao: TLabel
        Left = 320
        Top = 69
        Width = 164
        Height = 21
        Caption = 'Descri'#231#227'o do Produto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblQuantidade: TLabel
        Left = 320
        Top = 299
        Width = 81
        Height = 15
        Caption = 'QUANTIDADE:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValor: TLabel
        Left = 360
        Top = 331
        Width = 41
        Height = 15
        Caption = 'VALOR:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 31
        Top = 19
        Width = 56
        Height = 15
        Caption = 'Cod. Prod:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 231
        Top = 19
        Width = 37
        Height = 15
        Caption = 'Nome:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 339
        Top = 362
        Width = 62
        Height = 15
        Caption = 'Cod.Barras:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dmImageProduto: TDBImage
        Left = 31
        Top = 96
        Width = 237
        Height = 322
        BorderStyle = bsNone
        DataField = 'foto'
        DataSource = dtsListagem
        TabOrder = 0
      end
      object dbMemoDescricaoProduto: TDBMemo
        Left = 320
        Top = 90
        Width = 729
        Height = 167
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        DataField = 'descricao'
        DataSource = dtsListagem
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object dbedtQuantidade: TDBEdit
        Left = 410
        Top = 296
        Width = 119
        Height = 23
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        DataField = 'quantidade'
        DataSource = dtsListagem
        ReadOnly = True
        TabOrder = 2
      end
      object dbedtValor: TDBEdit
        Left = 410
        Top = 328
        Width = 121
        Height = 23
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        DataField = 'valor'
        DataSource = dtsListagem
        ReadOnly = True
        TabOrder = 3
      end
      object edtCodProduto: TDBEdit
        Left = 93
        Top = 17
        Width = 121
        Height = 23
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        DataField = 'produtoId'
        DataSource = dtsListagem
        ReadOnly = True
        TabOrder = 4
      end
      object edtNome: TDBEdit
        Left = 280
        Top = 17
        Width = 121
        Height = 23
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        DataField = 'nome'
        DataSource = dtsListagem
        ReadOnly = True
        TabOrder = 5
      end
      object edtCodBarras: TDBEdit
        Left = 410
        Top = 359
        Width = 121
        Height = 23
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        DataField = 'codbarras'
        DataSource = dtsListagem
        ReadOnly = True
        TabOrder = 6
      end
    end
  end
  inherited pnlRodape: TPanel
    inherited btnNovo: TBitBtn
      Tag = 0
      Enabled = False
      Visible = False
    end
    inherited btnAlterar: TBitBtn
      Caption = '&Visualizar'
    end
    inherited btnGravar: TBitBtn
      Tag = 0
      Enabled = False
      Visible = False
    end
    inherited btnApagar: TBitBtn
      Tag = 0
      Enabled = False
      Visible = False
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT'
      ' produtoId,'
      ' nome,'
      ' descricao,'
      ' valor,'
      ' codbarras,'
      ' foto,'
      ' quantidade'
      'FROM produtos'
      'WHERE filialId =:filialId')
    Params = <
      item
        DataType = ftWideString
        Name = 'filialId'
        SQLType = stUnicodeString
        Value = Null
      end>
    Left = 676
    Top = 42
    ParamData = <
      item
        DataType = ftWideString
        Name = 'filialId'
        SQLType = stUnicodeString
        Value = Null
      end>
    object QryListagemprodutoId: TZIntegerField
      FieldName = 'produtoId'
      Required = True
    end
    object QryListagemnome: TZUnicodeStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryListagemdescricao: TZUnicodeStringField
      FieldName = 'descricao'
      Size = 255
    end
    object QryListagemvalor: TZFMTBCDField
      FieldName = 'valor'
      Precision = 18
      Size = 5
    end
    object QryListagemcodbarras: TZUnicodeStringField
      FieldName = 'codbarras'
      Size = 13
    end
    object QryListagemfoto: TZBlobField
      FieldName = 'foto'
    end
    object QryListagemquantidade: TZFMTBCDField
      FieldName = 'quantidade'
      Precision = 18
      Size = 5
    end
  end
  inherited dtsListagem: TDataSource
    Left = 764
    Top = 42
  end
  object dtsFilial: TDataSource
    DataSet = QryFilial
    Left = 764
    Top = 101
  end
  object QryFilial: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT '
      ' filialId,'
      ' numfilial,'
      ' fantasia,'
      ' cnpj'
      'FROM filiais')
    Params = <>
    Left = 678
    Top = 100
    object QryFilialfilialId: TZIntegerField
      FieldName = 'filialId'
      Required = True
    end
    object QryFilialnumfilial: TZIntegerField
      FieldName = 'numfilial'
      Required = True
    end
    object QryFilialfantasia: TZUnicodeStringField
      FieldName = 'fantasia'
      Size = 255
    end
    object QryFilialcnpj: TZUnicodeStringField
      FieldName = 'cnpj'
      Size = 18
    end
  end
end
