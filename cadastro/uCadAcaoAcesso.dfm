inherited frmCadAcaoAcesso: TfrmCadAcaoAcesso
  Caption = 'Cadastro  A'#231#227'o de Acesso'
  ClientHeight = 563
  ClientWidth = 976
  ExplicitWidth = 976
  ExplicitHeight = 563
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    Width = 976
    Height = 496
    ExplicitWidth = 976
    ExplicitHeight = 496
    inherited tabListagem: TTabSheet
      ExplicitWidth = 968
      ExplicitHeight = 464
      inherited pnlListagemTopo: TPanel
        Width = 968
        ExplicitWidth = 968
      end
      inherited grdListagem: TDBGrid
        Width = 968
        Height = 326
        Columns = <
          item
            Expanded = False
            FieldName = 'acaoAcessoId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Width = 334
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'chave'
            Width = 379
            Visible = True
          end>
      end
      inherited pnlTitulo: TPanel
        Width = 968
        Caption = 'Cadastro  A'#231#227'o de Acesso'
        ExplicitWidth = 968
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 968
      ExplicitHeight = 464
      object edtAcaoAcessoId: TLabeledEdit
        Tag = 1
        Left = 0
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
      object edtDescricao: TLabeledEdit
        Tag = 2
        Left = 0
        Top = 96
        Width = 663
        Height = 25
        EditLabel.Width = 57
        EditLabel.Height = 17
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 100
        TabOrder = 1
        Text = ''
      end
      object edtChave: TLabeledEdit
        Tag = 2
        Left = 0
        Top = 160
        Width = 473
        Height = 25
        EditLabel.Width = 35
        EditLabel.Height = 17
        EditLabel.Caption = 'Chave'
        MaxLength = 60
        TabOrder = 2
        Text = ''
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 496
    Width = 976
    ExplicitTop = 496
    ExplicitWidth = 976
    DesignSize = (
      976
      67)
    inherited btnGravar: TBitBtn
      Left = 261
      ExplicitLeft = 261
    end
    inherited btnFechar: TBitBtn
      Left = 891
      ExplicitLeft = 891
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT acaoAcessoId,'
      '             descricao,'
      '             chave'
      'FROM acaoAcesso')
    object QryListagemacaoAcessoId: TZIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'acaoAcessoId'
      Required = True
    end
    object QryListagemdescricao: TZUnicodeStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Required = True
      Size = 100
    end
    object QryListagemchave: TZUnicodeStringField
      DisplayLabel = 'Chave'
      FieldName = 'chave'
      Required = True
      Size = 60
    end
  end
end
