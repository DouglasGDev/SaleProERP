inherited frmCadProduto: TfrmCadProduto
  Caption = 'Cadastro de Produto'
  ClientHeight = 464
  ClientWidth = 929
  ExplicitWidth = 929
  ExplicitHeight = 464
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    Width = 929
    Height = 397
    ActivePage = tabManutencao
    ExplicitWidth = 929
    ExplicitHeight = 397
    inherited tabListagem: TTabSheet
      ExplicitWidth = 921
      ExplicitHeight = 365
      inherited pnlListagemTopo: TPanel
        Width = 921
        ExplicitWidth = 921
      end
      inherited grdListagem: TDBGrid
        Width = 921
        Height = 227
        Columns = <
          item
            Expanded = False
            FieldName = 'produtoId'
            Width = 98
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 573
            Visible = True
          end>
      end
      inherited pnlTitulo: TPanel
        Width = 921
        Caption = 'Cadastro de Produto'
        ExplicitWidth = 921
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 921
      ExplicitHeight = 365
      object lblDescricao: TLabel
        Left = 3
        Top = 125
        Width = 128
        Height = 17
        Caption = 'Descri'#231#227'o do Produto'
      end
      object lblValor: TLabel
        Left = 164
        Top = 257
        Width = 30
        Height = 17
        Caption = 'Valor'
      end
      object lblQuantidadeMinima: TLabel
        Left = 322
        Top = 259
        Width = 71
        Height = 17
        Caption = 'Qtd. min'#237'ma'
      end
      object lblValidade: TLabel
        Left = 727
        Top = 257
        Width = 50
        Height = 17
        Caption = 'Validade'
      end
      object btnIncluirCategoria: TSpeedButton
        Left = 638
        Top = 96
        Width = 23
        Height = 22
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FF0A6B0A0A6B0A0A6B0A0A6B0AFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFB25D130A6B0A42D37331B85A0A6B0AA8
          4E0FA54A0EA4480DA1440DA0420C9F3F0C9D3E0BFF00FFFF00FFFF00FFFF00FF
          B561140A6B0A78F3A440D1710A6B0AFBF0DEFBEFDAFBEDD5FBEBD1FBE9CDFBE7
          C89E400BFF00FFFF00FF0A6B0A0A6B0A0A6B0A0A6B0A78F3A444D5740A6B0A0A
          6B0A0A6B0A0A6B0AFCEDD6FBEBD1FBEACEA1430CFF00FFFF00FF0A6B0A78F3A4
          53E4844FE1804CDD7C48D97845D67541D27231B85A0A6B0AFBEFDBFCEDD6FBEB
          D1A3470DFF00FFFF00FF0A6B0A78F3A478F3A478F3A478F3A44DDE7D78F3A478
          F3A442D3730A6B0AFCF1E0FBEFDBFBEDD7A64B0EFF00FFFF00FF0A6B0A0A6B0A
          0A6B0A0A6B0A78F3A450E2810A6B0A0A6B0A0A6B0A0A6B0AFCF4E4FBF1E1FCEF
          DCA94F0FFF00FFFF00FFFF00FFFF00FFC375190A6B0A78F3A454E5850A6B0AFC
          F9F5FCF7F1FCF7EEFCF5E9FBF3E4FCF2E2AC5110FF00FFFF00FFFF00FFFF00FF
          C579190A6B0A78F3A478F3A40A6B0AFCFAF7FCF9F5FCF7F2FCF7EEFBF6E9FBF3
          E5AD5611FF00FFFF00FFFF00FFFF00FFC77C1A0A6B0A0A6B0A0A6B0A0A6B0AFC
          FBFBFCFAF8FCF9F5FBF8F2FCF7EEFBF6EAB05A12FF00FFFF00FFFF00FFFF00FF
          C97F1CFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFAFCFBF8FCF9F6FCF8F2FCF7
          EFB35E13FF00FFFF00FFFF00FFFF00FFCC821CFCFCFCFCFCFCFCFCFCFCFCFCFC
          FCFCFCFCFCFCFCFAFCFBF9FCFAF6FCF8F3B66214FF00FFFF00FFFF00FFFF00FF
          CE851DFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFBFBFCFBF9FCFA
          F7B96615FF00FFFF00FFFF00FFFF00FFCF861DFCFCFCFCFCFCFCFCFCFCFCFCFC
          FCFCFCFCFCFCFCFCFCFCFCFCFCFBFCFBF8BC6A16FF00FFFF00FFFF00FFFF00FF
          CF871DCF871DCE861DCC831CCC821CCA801BC87D1BC67A1AC47719C37419C172
          17BF6F17FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        OnClick = btnIncluirCategoriaClick
      end
      object btnPesquisarCategoria: TSpeedButton
        Left = 667
        Top = 96
        Width = 23
        Height = 22
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF9B3B0A9B3B0A9B3B0A993B0DFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B3B0AFA
          EAC2E9B171953B11FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF9B3B0AFAE9C0EAB474953B11FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B3B0AF9
          E7BFEBB677953B11FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFC3B6B09B3B0AA54D1E9B3B0A983B0EC3B8B4FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA86441C58355FA
          DEB1F7D6A5B3724AAC6C4CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFB89787A54E20F6D4A8FBE2B7F6D19DDBAB799A461FBDA79BFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC5BEBBA0491DDDA876F9E3C2F9
          DBADF4CB96E9B97FB17047A3542CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFAE7559B86F40F6D6ACFBE9CDF7D5A4F2C68FEBB879CA905A984D28B68E
          7AFF00FFFF00FFFF00FFFF00FFFF00FFBDA79B9F4516EBBC84FAE9D1FBE8CBF6
          D09CEFC187E9B272D49758A7653C9B4419C5BEBBFF00FFFF00FFFF00FFC7C4C3
          A4532BCD8E5BF5D5AAFBF5E9FAE2BEF3CB95EDBC80E7AD6ADF9C55B8743D924D
          2BAE7254FF00FFFF00FFFF00FFB3856FAC5E30EFC187FAEEDEFCF9F5F7D6A9F1
          C58DEBB778E4A862DF994EC179399B582E93411BC0ADA4FF00FFFF00FF9D3E0F
          9B3B0A9B3B0A9B3B0A9B3B0A9B3B0A9B3B0A9B3B0A9B3B0A9B3B0A9A3B0B983B
          0E973B0FA65B36FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        OnClick = btnPesquisarCategoriaClick
      end
      object lblCusto: TLabel
        Left = 3
        Top = 257
        Width = 33
        Height = 17
        Caption = 'Custo'
      end
      object lblCategoria: TLabel
        Left = 291
        Top = 78
        Width = 57
        Height = 17
        Caption = 'Categoria'
      end
      object lblFilial: TLabel
        Left = 291
        Top = 12
        Width = 25
        Height = 17
        Caption = 'Filial'
      end
      object btnIncluirFilial: TSpeedButton
        Left = 370
        Top = 38
        Width = 23
        Height = 22
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FF0A6B0A0A6B0A0A6B0A0A6B0AFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFB25D130A6B0A42D37331B85A0A6B0AA8
          4E0FA54A0EA4480DA1440DA0420C9F3F0C9D3E0BFF00FFFF00FFFF00FFFF00FF
          B561140A6B0A78F3A440D1710A6B0AFBF0DEFBEFDAFBEDD5FBEBD1FBE9CDFBE7
          C89E400BFF00FFFF00FF0A6B0A0A6B0A0A6B0A0A6B0A78F3A444D5740A6B0A0A
          6B0A0A6B0A0A6B0AFCEDD6FBEBD1FBEACEA1430CFF00FFFF00FF0A6B0A78F3A4
          53E4844FE1804CDD7C48D97845D67541D27231B85A0A6B0AFBEFDBFCEDD6FBEB
          D1A3470DFF00FFFF00FF0A6B0A78F3A478F3A478F3A478F3A44DDE7D78F3A478
          F3A442D3730A6B0AFCF1E0FBEFDBFBEDD7A64B0EFF00FFFF00FF0A6B0A0A6B0A
          0A6B0A0A6B0A78F3A450E2810A6B0A0A6B0A0A6B0A0A6B0AFCF4E4FBF1E1FCEF
          DCA94F0FFF00FFFF00FFFF00FFFF00FFC375190A6B0A78F3A454E5850A6B0AFC
          F9F5FCF7F1FCF7EEFCF5E9FBF3E4FCF2E2AC5110FF00FFFF00FFFF00FFFF00FF
          C579190A6B0A78F3A478F3A40A6B0AFCFAF7FCF9F5FCF7F2FCF7EEFBF6E9FBF3
          E5AD5611FF00FFFF00FFFF00FFFF00FFC77C1A0A6B0A0A6B0A0A6B0A0A6B0AFC
          FBFBFCFAF8FCF9F5FBF8F2FCF7EEFBF6EAB05A12FF00FFFF00FFFF00FFFF00FF
          C97F1CFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFAFCFBF8FCF9F6FCF8F2FCF7
          EFB35E13FF00FFFF00FFFF00FFFF00FFCC821CFCFCFCFCFCFCFCFCFCFCFCFCFC
          FCFCFCFCFCFCFCFAFCFBF9FCFAF6FCF8F3B66214FF00FFFF00FFFF00FFFF00FF
          CE851DFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFBFBFCFBF9FCFA
          F7B96615FF00FFFF00FFFF00FFFF00FFCF861DFCFCFCFCFCFCFCFCFCFCFCFCFC
          FCFCFCFCFCFCFCFCFCFCFCFCFCFBFCFBF8BC6A16FF00FFFF00FFFF00FFFF00FF
          CF871DCF871DCE861DCC831CCC821CCA801BC87D1BC67A1AC47719C37419C172
          17BF6F17FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        OnClick = btnIncluirFilialClick
      end
      object btnPesquisarFilial: TSpeedButton
        Left = 399
        Top = 38
        Width = 23
        Height = 22
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF9B3B0A9B3B0A9B3B0A993B0DFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B3B0AFA
          EAC2E9B171953B11FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF9B3B0AFAE9C0EAB474953B11FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9B3B0AF9
          E7BFEBB677953B11FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFC3B6B09B3B0AA54D1E9B3B0A983B0EC3B8B4FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA86441C58355FA
          DEB1F7D6A5B3724AAC6C4CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFB89787A54E20F6D4A8FBE2B7F6D19DDBAB799A461FBDA79BFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC5BEBBA0491DDDA876F9E3C2F9
          DBADF4CB96E9B97FB17047A3542CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFAE7559B86F40F6D6ACFBE9CDF7D5A4F2C68FEBB879CA905A984D28B68E
          7AFF00FFFF00FFFF00FFFF00FFFF00FFBDA79B9F4516EBBC84FAE9D1FBE8CBF6
          D09CEFC187E9B272D49758A7653C9B4419C5BEBBFF00FFFF00FFFF00FFC7C4C3
          A4532BCD8E5BF5D5AAFBF5E9FAE2BEF3CB95EDBC80E7AD6ADF9C55B8743D924D
          2BAE7254FF00FFFF00FFFF00FFB3856FAC5E30EFC187FAEEDEFCF9F5F7D6A9F1
          C58DEBB778E4A862DF994EC179399B582E93411BC0ADA4FF00FFFF00FF9D3E0F
          9B3B0A9B3B0A9B3B0A9B3B0A9B3B0A9B3B0A9B3B0A9B3B0A9B3B0A9A3B0B983B
          0E973B0FA65B36FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        OnClick = btnPesquisarFilialClick
      end
      object edtProdutoId: TLabeledEdit
        Tag = 1
        Left = 3
        Top = 32
        Width = 121
        Height = 25
        EditLabel.Width = 43
        EditLabel.Height = 17
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 11
        NumbersOnly = True
        TabOrder = 0
        Text = ''
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 96
        Width = 282
        Height = 25
        EditLabel.Width = 36
        EditLabel.Height = 17
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
        Text = ''
      end
      object edtDescricao: TMemo
        Left = 3
        Top = 146
        Width = 845
        Height = 107
        Lines.Strings = (
          'edtDescricao')
        MaxLength = 255
        ParentShowHint = False
        ShowHint = False
        TabOrder = 4
      end
      object edtValor: TCurrencyEdit
        Left = 164
        Top = 280
        Width = 121
        Height = 25
        TabOrder = 6
      end
      object edtQuantidadeMinima: TCurrencyEdit
        Left = 322
        Top = 280
        Width = 121
        Height = 25
        DisplayFormat = '0.00'
        TabOrder = 7
      end
      object lkpCategoria: TDBLookupComboBox
        Tag = 2
        Left = 291
        Top = 96
        Width = 341
        Height = 25
        KeyField = 'categoriaId'
        ListField = 'descricao'
        ListSource = dtsCategoria
        TabOrder = 3
      end
      object edtValidade: TDateEdit
        Left = 727
        Top = 280
        Width = 121
        Height = 25
        ClickKey = 114
        DialogTitle = 'Selecione a Data'
        NumGlyphs = 2
        CalendarStyle = csDialog
        TabOrder = 9
      end
      object edtCodBarras: TLabeledEdit
        Tag = 2
        Left = 456
        Top = 280
        Width = 256
        Height = 25
        EditLabel.Width = 68
        EditLabel.Height = 17
        EditLabel.Caption = 'Cod. Barras'
        MaxLength = 13
        TabOrder = 8
        Text = ''
      end
      object edtCusto: TCurrencyEdit
        Left = 3
        Top = 280
        Width = 121
        Height = 25
        TabOrder = 5
      end
      object pnlImagem: TPanel
        Left = 712
        Top = 32
        Width = 136
        Height = 108
        BorderStyle = bsSingle
        TabOrder = 10
        object imgImagem: TImage
          Left = 1
          Top = 1
          Width = 130
          Height = 102
          Align = alClient
          PopupMenu = ppmImagem
          ExplicitLeft = 16
          ExplicitWidth = 139
          ExplicitHeight = 135
        end
      end
      object lkpFilial: TDBLookupComboBox
        Tag = 2
        Left = 291
        Top = 35
        Width = 70
        Height = 25
        KeyField = 'filialId'
        ListField = 'numfilial'
        ListSource = dtsFilial
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 397
    Width = 929
    ExplicitTop = 397
    ExplicitWidth = 929
    DesignSize = (
      929
      67)
    inherited btnGravar: TBitBtn
      Left = 259
      ExplicitLeft = 259
    end
    inherited btnFechar: TBitBtn
      Left = 844
      ExplicitLeft = 844
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT produtoId,'
      '             nome'
      'FROM produtos')
    Left = 124
    Top = 346
    object QryListagemprodutoId: TZIntegerField
      DisplayLabel = 'Cod. Produto'
      FieldName = 'produtoId'
      Required = True
    end
    object QryListagemnome: TZUnicodeStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
  end
  inherited dtsListagem: TDataSource
    Left = 204
    Top = 346
  end
  object QryCategoria: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      '  SELECT categoriaId, descricao from categorias')
    Params = <>
    Left = 178
    Top = 200
    object QryCategoriacategoriaId: TZIntegerField
      FieldName = 'categoriaId'
      Required = True
    end
    object QryCategoriadescricao: TZUnicodeStringField
      FieldName = 'descricao'
      Size = 100
    end
  end
  object dtsCategoria: TDataSource
    DataSet = QryCategoria
    Left = 260
    Top = 200
  end
  object ppmImagem: TPopupMenu
    Left = 768
    Top = 103
    object CarregarImagem1: TMenuItem
      Caption = 'Carregar Imagem'
      OnClick = CarregarImagem1Click
    end
    object LimparImagem1: TMenuItem
      Caption = 'Limpar Imagem'
      OnClick = LimparImagem1Click
    end
  end
  object QryFilial: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT'
      '  filialId,'
      '  numfilial,'
      '  razaosocial'
      'FROM filiais')
    Params = <>
    Left = 343
    Top = 199
    object QryFilialfilialId: TZIntegerField
      FieldName = 'filialId'
      Required = True
    end
    object QryFilialnumfilial: TZIntegerField
      FieldName = 'numfilial'
      Required = True
    end
    object QryFilialrazaosocial: TZUnicodeStringField
      FieldName = 'razaosocial'
      Size = 255
    end
  end
  object dtsFilial: TDataSource
    DataSet = QryFilial
    Left = 404
    Top = 199
  end
end
