inherited frmCadCliente: TfrmCadCliente
  Caption = 'Cadastro de Cliente'
  ClientHeight = 562
  ClientWidth = 986
  ExplicitWidth = 986
  ExplicitHeight = 562
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    Width = 986
    Height = 495
    ActivePage = tabManutencao
    ExplicitWidth = 986
    ExplicitHeight = 495
    inherited tabListagem: TTabSheet
      ExplicitWidth = 978
      ExplicitHeight = 463
      inherited pnlListagemTopo: TPanel
        Width = 978
        ExplicitWidth = 978
      end
      inherited grdListagem: TDBGrid
        Width = 978
        Height = 325
        Columns = <
          item
            Expanded = False
            FieldName = 'clienteId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 259
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'telefone'
            Width = 124
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'email'
            Width = 311
            Visible = True
          end>
      end
      inherited pnlTitulo: TPanel
        Width = 978
        Caption = 'Cadastro de Cliente'
        ExplicitTop = 0
        ExplicitWidth = 978
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 978
      ExplicitHeight = 463
      object lblCEP: TLabel
        Left = 443
        Top = 75
        Width = 22
        Height = 17
        Caption = 'CEP'
      end
      object lblTelefone: TLabel
        Left = 443
        Top = 175
        Width = 49
        Height = 17
        Caption = 'Telefone'
      end
      object lblDataNascimento: TLabel
        Left = 3
        Top = 275
        Width = 100
        Height = 17
        Caption = 'Data Nascimento'
      end
      object lblCPF: TLabel
        Left = 443
        Top = 225
        Width = 21
        Height = 17
        Caption = 'CPF'
      end
      object btnPesquisarCep: TSpeedButton
        Left = 776
        Top = 98
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
        OnClick = btnPesquisarCepClick
      end
      object edtClienteId: TLabeledEdit
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
        Width = 421
        Height = 25
        EditLabel.Width = 36
        EditLabel.Height = 17
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
        Text = ''
      end
      object edtCEP: TMaskEdit
        Left = 443
        Top = 96
        Width = 219
        Height = 25
        TabOrder = 2
        Text = ''
      end
      object edtEndereco: TLabeledEdit
        Left = 3
        Top = 144
        Width = 421
        Height = 25
        EditLabel.Width = 55
        EditLabel.Height = 17
        EditLabel.Caption = 'Endere'#231'o'
        MaxLength = 60
        TabOrder = 3
        Text = ''
      end
      object edtBairro: TLabeledEdit
        Left = 443
        Top = 144
        Width = 220
        Height = 25
        EditLabel.Width = 35
        EditLabel.Height = 17
        EditLabel.Caption = 'Bairro'
        MaxLength = 40
        TabOrder = 4
        Text = ''
      end
      object edtCidade: TLabeledEdit
        Left = 3
        Top = 192
        Width = 318
        Height = 25
        EditLabel.Width = 41
        EditLabel.Height = 17
        EditLabel.Caption = 'Cidade'
        MaxLength = 50
        TabOrder = 5
        Text = ''
      end
      object edtTelefone: TMaskEdit
        Left = 443
        Top = 196
        Width = 217
        Height = 25
        EditMask = '(99)99999-9999;1;_'
        MaxLength = 14
        TabOrder = 7
        Text = '(  )     -    '
      end
      object edtEmail: TLabeledEdit
        Left = 3
        Top = 246
        Width = 420
        Height = 25
        EditLabel.Width = 31
        EditLabel.Height = 17
        EditLabel.Caption = 'Email'
        MaxLength = 100
        TabOrder = 8
        Text = ''
      end
      object edtDataNascimento: TDateEdit
        Left = 3
        Top = 296
        Width = 121
        Height = 25
        ClickKey = 114
        DialogTitle = 'Selecione a Data'
        NumGlyphs = 2
        CalendarStyle = csDialog
        TabOrder = 10
      end
      object edtCPF: TMaskEdit
        Left = 443
        Top = 246
        Width = 218
        Height = 25
        EditMask = '000.000.000-00;1;_'
        MaxLength = 14
        TabOrder = 9
        Text = '   .   .   -  '
        OnExit = edtCPFExit
      end
      object edtEstado: TLabeledEdit
        Left = 340
        Top = 192
        Width = 84
        Height = 25
        EditLabel.Width = 63
        EditLabel.Height = 17
        EditLabel.Caption = 'Estado(UF)'
        MaxLength = 2
        TabOrder = 6
        Text = ''
      end
      object btnBuscar: TBitBtn
        Left = 680
        Top = 96
        Width = 90
        Height = 25
        Caption = 'BUSCAR'
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
        TabOrder = 11
        OnClick = btnBuscarClick
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 495
    Width = 986
    ExplicitTop = 495
    ExplicitWidth = 986
    DesignSize = (
      986
      67)
    inherited btnGravar: TBitBtn
      Left = 261
      ExplicitLeft = 261
    end
    inherited btnFechar: TBitBtn
      Left = 901
      ExplicitLeft = 901
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'select clienteId,'
      '           nome,'
      '           endereco,'
      '           cidade,'
      '           bairro,'
      '           estado,'
      '           cep,'
      '           telefone,'
      '           email,'
      '           cpf,'
      '           dataNascimento'
      'from clientes')
    object QryListagemclienteId: TZIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'clienteId'
      Required = True
    end
    object QryListagemnome: TZUnicodeStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object QryListagemtelefone: TZUnicodeStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Size = 14
    end
    object QryListagemcpf: TZUnicodeStringField
      DisplayLabel = 'CPF'
      FieldName = 'cpf'
      Size = 14
    end
    object QryListagemdataNascimento: TZDateTimeField
      DisplayLabel = 'Data nascimento'
      FieldName = 'dataNascimento'
    end
    object QryListagememail: TZUnicodeStringField
      DisplayLabel = 'Email'
      FieldName = 'email'
      Size = 100
    end
    object QryListagemendereco: TZUnicodeStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'endereco'
      Size = 60
    end
    object QryListagembairro: TZUnicodeStringField
      DisplayLabel = 'Bairro'
      FieldName = 'bairro'
      Size = 40
    end
    object QryListagemcidade: TZUnicodeStringField
      DisplayLabel = 'Cidade'
      FieldName = 'cidade'
      Size = 50
    end
    object QryListagemestado: TZUnicodeStringField
      DisplayLabel = 'Estado'
      FieldName = 'estado'
      Size = 2
    end
    object QryListagemcep: TZUnicodeStringField
      DisplayLabel = 'CEP'
      FieldName = 'cep'
      Size = 10
    end
  end
  object RESTClient: TRESTClient
    Params = <>
    SynchronizedEvents = False
    Left = 520
    Top = 372
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 600
    Top = 372
  end
  object RESTResponse: TRESTResponse
    Left = 688
    Top = 372
  end
end
