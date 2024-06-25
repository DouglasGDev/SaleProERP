inherited frmConsultaExtratoProduto: TfrmConsultaExtratoProduto
  Caption = 'Extrato de Produtos'
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    inherited tabListagem: TTabSheet
      inherited grdListagem: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'produtoId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'codbarras'
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
      'FROM produtos')
    Left = 676
    Top = 42
    object QryListagemprodutoId: TZIntegerField
      DisplayLabel = 'Cod.Prod'
      FieldName = 'produtoId'
      Required = True
    end
    object QryListagemnome: TZUnicodeStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object QryListagemdescricao: TZUnicodeStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 255
    end
    object QryListagemvalor: TZFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
      Precision = 18
      Size = 5
    end
    object QryListagemcodbarras: TZUnicodeStringField
      DisplayLabel = 'Cod.barras'
      FieldName = 'codbarras'
      Size = 13
    end
    object QryListagemfoto: TZBlobField
      DisplayLabel = 'Foto'
      FieldName = 'foto'
    end
    object QryListagemquantidade: TZFMTBCDField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
      Precision = 18
      Size = 5
    end
  end
  inherited dtsListagem: TDataSource
    Left = 764
    Top = 42
  end
end
