inherited frmCadUsuario: TfrmCadUsuario
  Caption = 'Cadastro de Usu'#225'rio'
  ClientHeight = 468
  ClientWidth = 905
  ExplicitWidth = 905
  ExplicitHeight = 468
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    Width = 905
    Height = 401
    ActivePage = tabManutencao
    ExplicitWidth = 905
    ExplicitHeight = 401
    inherited tabListagem: TTabSheet
      ExplicitWidth = 897
      ExplicitHeight = 369
      inherited pnlListagemTopo: TPanel
        Width = 897
        ExplicitWidth = 897
      end
      inherited grdListagem: TDBGrid
        Width = 897
        Height = 231
        Columns = <
          item
            Expanded = False
            FieldName = 'usuarioId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 651
            Visible = True
          end>
      end
      inherited pnlTitulo: TPanel
        Width = 897
        Caption = 'Cadastro de Usu'#225'rio'
        ExplicitWidth = 897
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 897
      ExplicitHeight = 369
      object edtUsuarioId: TLabeledEdit
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
        Width = 574
        Height = 25
        EditLabel.Width = 45
        EditLabel.Height = 17
        EditLabel.Caption = 'Usu'#225'rio'
        MaxLength = 50
        TabOrder = 1
        Text = ''
      end
      object edtSenha: TLabeledEdit
        Tag = 2
        Left = 3
        Top = 152
        Width = 331
        Height = 25
        EditLabel.Width = 35
        EditLabel.Height = 17
        EditLabel.Caption = 'Senha'
        MaxLength = 40
        PasswordChar = '*'
        TabOrder = 2
        Text = ''
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 401
    Width = 905
    ExplicitTop = 401
    ExplicitWidth = 905
    DesignSize = (
      905
      67)
    inherited btnGravar: TBitBtn
      Left = 260
      ExplicitLeft = 260
    end
    inherited btnFechar: TBitBtn
      Left = 820
      ExplicitLeft = 820
    end
    inherited btnNavigator: TDBNavigator
      Left = 431
      Hints.Strings = ()
      ExplicitLeft = 431
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT usuarioId,'
      '       nome,'
      '       senha'
      'FROM usuarios')
    object QryListagemusuarioId: TZIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'usuarioId'
      Required = True
    end
    object QryListagemnome: TZUnicodeStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'nome'
      Required = True
      Size = 50
    end
    object QryListagemsenha: TZUnicodeStringField
      DisplayLabel = 'Senha'
      FieldName = 'senha'
      Required = True
      Size = 40
    end
  end
end
