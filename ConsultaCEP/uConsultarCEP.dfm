object frmConsultarCEP: TfrmConsultarCEP
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Consultar CEP'
  ClientHeight = 226
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object ResultadoConsultarCEP: TMemo
    Left = 17
    Top = 33
    Width = 254
    Height = 152
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = 16767927
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    Lines.Strings = (
      '')
    ParentFont = False
    TabOrder = 0
    ExplicitLeft = 33
    ExplicitWidth = 240
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 288
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Color = clTeal
    ParentBackground = False
    TabOrder = 1
    ExplicitWidth = 315
    object btnConsultarCEP: TButton
      Left = 159
      Top = 2
      Width = 113
      Height = 25
      Caption = 'Consultar CEP'
      TabOrder = 0
      OnClick = btnConsultarCEPClick
    end
    object edtConsultarCEP: TMaskEdit
      Left = 17
      Top = 4
      Width = 110
      Height = 23
      EditMask = '00.000-000'
      MaxLength = 10
      TabOrder = 1
      Text = '  .   -   '
    end
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 185
    Width = 288
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Color = clTeal
    ParentBackground = False
    TabOrder = 2
    ExplicitWidth = 315
    DesignSize = (
      288
      41)
    object btnFechar: TBitBtn
      Left = 86
      Top = 6
      Width = 113
      Height = 25
      Anchors = [akLeft, akRight, akBottom]
      Caption = '&Fechar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FF244E6E
        0A6B9BA6B2F19FA4DAA29CBFAD9BAAB69E9EB69E9EB69F9FB69F9FB69F9FB69F
        9F3C9DBE244E6EFF00FFFF00FF244E6E0A6B9B95AAFC8199FC6F8BFC5D7DFC56
        72F06272D47A79B899879CAB9090AB90903FA0BF244E6EFF00FFFF00FF244E6E
        0A6B9B849CFC728DFC607FFC4E71FC3C62FC2A54FC1745FC0A3AFAA08181A081
        8142A3C1244E6EFF00FFFF00FF244E6E0D6E9D7490FC6282FC5074FC3E64FC2C
        56FC1A48FC0A3BFC0A34F095727295727245A6C2244E6EFF00FFFF00FF244E6E
        10719F6684FC5475FC4267FC3059FC1E4AFC0C3CFC0A36F20A2FE58963638963
        6348A9C4244E6EFF00FFFF00FF244E6E1374A15778FC4569FC335BFC214DFC0F
        3EFC0A37F40A2FE60A2ADA7E54547E54544BACC6244E6EFF00FFFF00FF244E6E
        1575A3486CFC365EFC244FFC1240FC0A37F50A31E80A2ADC0A24D07446467446
        464EAEC8244E6EFF00FFFF00FF244E6E1778A53960FC2751FC1543FC0A38F70A
        32EA0A2BDE0A7ED80AA0E16A3C3C6B3B3B50B1CA244E6EFF00FFFF00FF244E6E
        1A7BA72A54FC1744FC0A39F90A33ED0A2CE00A27D30B91EA4DC9F3693D3E6B3B
        3B53B4CC244E6EFF00FFFF00FF244E6E1D7EA91947FC0A3AFB0A34EF0A2DE30A
        28D50A21C90A1BBD0A15B06B3B3B6B3B3B56B7CE244E6EFF00FFFF00FF244E6E
        2081AB0A3BFC0A35F10A2EE40A29D80A22CB0A1CBF0A16B20A0EA56B3B3B6B3B
        3B59BAD0244E6EFF00FFFF00FF244E6E2384AC0A36F30A2FE60A2ADA0A23CE0A
        1DC00A15B10A0FA40A0A9B6B3B3B6B3B3B5CBDD1244E6EFF00FFFF00FF244E6E
        2687AE0A31E80A2ADC0A24D00A1BBE0A13AD0A0EA30A0A9C0A0A9B6B3B3B6B3B
        3B5EBFD3244E6EFF00FFFF00FF244E6E2989B00A2BDE0A21C90A17B40A11AA0A
        0EA20A0B9C0A0A9B0A0A9B6B3B3B6B3B3B61C1D5244E6EFF00FFFF00FF244E6E
        2B8CB23192B53697B93C9CBC3FA0BF45A6C24AABC64FB0C954B5CD59BAD15FBF
        D363C4D7244E6EFF00FFFF00FF244E6E244E6E244E6E244E6E244E6E244E6E24
        4E6E244E6E244E6E244E6E244E6E244E6E244E6E244E6EFF00FF}
      TabOrder = 0
      OnClick = btnFecharClick
    end
  end
  object pnlRight: TPanel
    Left = 271
    Top = 33
    Width = 17
    Height = 152
    Align = alRight
    BevelOuter = bvNone
    Color = clTeal
    ParentBackground = False
    TabOrder = 3
    ExplicitLeft = 296
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 33
    Width = 17
    Height = 152
    Align = alLeft
    BevelOuter = bvNone
    Color = clTeal
    ParentBackground = False
    TabOrder = 4
  end
  object RESTClient: TRESTClient
    Params = <>
    SynchronizedEvents = False
    Left = 40
    Top = 60
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 120
    Top = 60
  end
  object RESTResponse: TRESTResponse
    Left = 208
    Top = 60
  end
end
