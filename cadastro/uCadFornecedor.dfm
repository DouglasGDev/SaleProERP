inherited frmCadFornecedor: TfrmCadFornecedor
  Caption = 'Cadastro de Fornecedores'
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    ActivePage = tabManutencao
    inherited tabListagem: TTabSheet
      inherited grdListagem: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'fornecedorId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'razaosocial'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cnpj'
            Width = 300
            Visible = True
          end>
      end
      inherited pnlTitulo: TPanel
        Caption = 'Cadastro de fornecedores'
      end
    end
    inherited tabManutencao: TTabSheet
      object lblTelefone: TLabel
        Left = 465
        Top = 175
        Width = 49
        Height = 17
        Caption = 'Telefone'
      end
      object lblTelefone2: TLabel
        Left = 683
        Top = 175
        Width = 60
        Height = 17
        Caption = 'Telefone 2'
      end
      object lblInscricaoEstadual: TLabel
        Left = 803
        Top = 126
        Width = 104
        Height = 17
        Caption = 'Inscri'#231#227'o Estadual'
      end
      object lblObservacoes: TLabel
        Left = 3
        Top = 281
        Width = 76
        Height = 17
        Caption = 'Observa'#231#245'es'
      end
      object lblCEP: TLabel
        Left = 647
        Top = 126
        Width = 22
        Height = 17
        Caption = 'CEP'
      end
      object lblIEAtivo: TLabel
        Left = 923
        Top = 126
        Width = 46
        Height = 17
        Caption = 'I.E Ativo'
      end
      object lblMotivo: TLabel
        Left = 656
        Top = 281
        Width = 101
        Height = 17
        Caption = 'Motivo da St.Cad'
      end
      object edtFornecedorId: TLabeledEdit
        Tag = 1
        Left = 3
        Top = 32
        Width = 118
        Height = 25
        EditLabel.Width = 43
        EditLabel.Height = 17
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 11
        NumbersOnly = True
        TabOrder = 0
        Text = ''
      end
      object edtRazaoSocial: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 95
        Width = 315
        Height = 25
        EditLabel.Width = 74
        EditLabel.Height = 17
        EditLabel.Caption = 'Raz'#227'o Social'
        TabOrder = 1
        Text = ''
      end
      object edtEndereco: TLabeledEdit
        Left = 3
        Top = 144
        Width = 418
        Height = 25
        EditLabel.Width = 55
        EditLabel.Height = 17
        EditLabel.Caption = 'Endere'#231'o'
        TabOrder = 5
        Text = ''
      end
      object edtBairro: TLabeledEdit
        Left = 429
        Top = 144
        Width = 212
        Height = 25
        EditLabel.Width = 35
        EditLabel.Height = 17
        EditLabel.Caption = 'Bairro'
        TabOrder = 6
        Text = ''
      end
      object edtCidade: TLabeledEdit
        Left = 3
        Top = 192
        Width = 165
        Height = 25
        EditLabel.Width = 41
        EditLabel.Height = 17
        EditLabel.Caption = 'Cidade'
        TabOrder = 10
        Text = ''
      end
      object edtEstado: TLabeledEdit
        Left = 174
        Top = 192
        Width = 81
        Height = 25
        EditLabel.Width = 63
        EditLabel.Height = 17
        EditLabel.Caption = 'Estado(UF)'
        MaxLength = 2
        TabOrder = 11
        Text = ''
      end
      object edtTelefone: TMaskEdit
        Left = 465
        Top = 192
        Width = 212
        Height = 25
        TabOrder = 13
        Text = ''
      end
      object edtEmail: TLabeledEdit
        Left = 3
        Top = 246
        Width = 419
        Height = 25
        EditLabel.Width = 31
        EditLabel.Height = 17
        EditLabel.Caption = 'Email'
        TabOrder = 16
        Text = ''
      end
      object edtCNPJ: TLabeledEdit
        Left = 696
        Top = 95
        Width = 212
        Height = 25
        EditLabel.Width = 29
        EditLabel.Height = 17
        EditLabel.Caption = 'CNPJ'
        EditMask = '99.999.999/9999-99'
        MaxLength = 18
        TabOrder = 3
        Text = '  .   .   /    -  '
      end
      object edtTelefone2: TMaskEdit
        Left = 683
        Top = 192
        Width = 212
        Height = 25
        TabOrder = 14
        Text = ''
      end
      object edtIE: TMaskEdit
        Left = 803
        Top = 144
        Width = 114
        Height = 25
        TabOrder = 8
        Text = ''
      end
      object btnBuscarCNPJ: TBitBtn
        Left = 918
        Top = 95
        Width = 119
        Height = 25
        Caption = 'BUSCAR CNPJ'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FF314B62
          AC7D7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF5084B20F6FE1325F8CB87E7AFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF32A0FE37A1FF
          106FE2325F8BB67D79FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF37A4FE379FFF0E6DDE355F89BB7F79FF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          37A4FE359EFF0F6FDE35608BA67B7FFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF38A5FE329DFF156DCE444F5BFF
          00FF9C6B65AF887BAF887EAA8075FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF3BABFFA1CAE7AD8679A98373E0CFB1FFFFDAFFFFDDFCF8CFCCB2
          9FA1746BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC0917DFC
          E9ACFFFFCCFFFFCFFFFFD0FFFFDEFFFFFAE3D3D1996965FF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFB08978FAD192FEF4C2FFFFD0FFFFDAFFFFF6FFFF
          FCFFFFFCB69384FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB08978FEDA97ED
          B478FBEEBBFFFFD3FFFFDCFFFFF4FFFFF4FFFFE2E9DDBCA67B73FF00FFFF00FF
          FF00FFFF00FFFF00FFB18A78FFDE99E9A167F4D199FEFCCCFFFFD5FFFFDAFFFF
          DCFFFFD7EFE6C5A97E75FF00FFFF00FFFF00FFFF00FFFF00FFAA7F73FAE0A4F0
          B778EEBA7BF6DDA6FEFBCCFFFFD3FFFFD1FFFFD7D9C5A7A3756CFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFCEB293FFFEDDF4D1A5EEBA7BF2C78FF8E1ABFCF0
          BAFCFACAA3776FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA1746BE1
          D4D3FFFEEEF7CC8CF0B473F7C788FCE3A5C2A088A5776CFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF986865BA9587EAD7A4EAD59EE0C097A577
          6CA5776CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFA77E70A98073A4786EFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 4
        OnClick = btnBuscarCNPJClick
      end
      object edtRamoAtividade: TLabeledEdit
        Left = 428
        Top = 246
        Width = 609
        Height = 25
        EditLabel.Width = 110
        EditLabel.Height = 17
        EditLabel.Caption = 'Ramo de atividade'
        TabOrder = 17
        Text = ''
      end
      object memObservacoes: TMemo
        Left = 3
        Top = 304
        Width = 638
        Height = 153
        Lines.Strings = (
          '')
        TabOrder = 18
      end
      object edtFantasia: TLabeledEdit
        Left = 328
        Top = 95
        Width = 359
        Height = 25
        EditLabel.Width = 47
        EditLabel.Height = 17
        EditLabel.Caption = 'Fantasia'
        TabOrder = 2
        Text = ''
      end
      object edtCEP: TMaskEdit
        Left = 647
        Top = 144
        Width = 149
        Height = 25
        TabOrder = 7
        Text = ''
      end
      object edtComplemento: TLabeledEdit
        Left = 261
        Top = 192
        Width = 195
        Height = 25
        EditLabel.Width = 82
        EditLabel.Height = 17
        EditLabel.Caption = 'Complemento'
        TabOrder = 12
        Text = ''
      end
      object edtIEAtivo: TMaskEdit
        Left = 923
        Top = 144
        Width = 114
        Height = 25
        TabOrder = 9
        Text = ''
      end
      object edtSituacaoCadastral: TLabeledEdit
        Left = 901
        Top = 192
        Width = 136
        Height = 25
        EditLabel.Width = 108
        EditLabel.Height = 17
        EditLabel.Caption = 'Situa'#231#227'o Cadastral'
        TabOrder = 15
        Text = ''
      end
      object edtMotivo: TMemo
        Left = 656
        Top = 304
        Width = 381
        Height = 153
        Lines.Strings = (
          '')
        ReadOnly = True
        TabOrder = 19
      end
    end
  end
  inherited pnlRodape: TPanel
    inherited btnFechar: TBitBtn
      Left = 981
      ExplicitLeft = 981
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT fornecedorId,'
      '             razaosocial,'
      '             cnpj'
      'FROM fornecedores')
    Left = 708
    Top = 34
    object QryListagemfornecedorId: TZIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'fornecedorId'
      Required = True
    end
    object QryListagemrazaosocial: TZUnicodeStringField
      DisplayLabel = 'Raz'#227'o Social'
      FieldName = 'razaosocial'
      Size = 255
    end
    object QryListagemcnpj: TZUnicodeStringField
      DisplayLabel = 'CNPJ'
      FieldName = 'cnpj'
      Size = 18
    end
  end
  inherited dtsListagem: TDataSource
    Left = 788
    Top = 34
  end
  object RESTClient: TRESTClient
    Params = <>
    SynchronizedEvents = False
    Left = 128
    Top = 347
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 224
    Top = 347
  end
  object RESTResponse: TRESTResponse
    Left = 320
    Top = 347
  end
end
