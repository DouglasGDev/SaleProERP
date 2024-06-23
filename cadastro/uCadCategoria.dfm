inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro de categorias'
  ClientHeight = 515
  ClientWidth = 1050
  ExplicitWidth = 1050
  ExplicitHeight = 515
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    Width = 1050
    Height = 448
    ExplicitWidth = 1050
    ExplicitHeight = 448
    inherited tabListagem: TTabSheet
      ExplicitWidth = 1042
      ExplicitHeight = 416
      inherited pnlListagemTopo: TPanel
        Width = 1042
        ExplicitWidth = 1042
      end
      inherited grdListagem: TDBGrid
        Width = 1042
        Height = 278
        Columns = <
          item
            Expanded = False
            FieldName = 'categoriaId'
            Width = 109
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Visible = True
          end>
      end
      inherited pnlTitulo: TPanel
        Width = 1042
        Caption = 'Cadastro de categorias'
        ExplicitWidth = 1042
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 1042
      ExplicitHeight = 416
      object edtCategoriaId: TLabeledEdit
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
        Width = 421
        Height = 25
        EditLabel.Width = 57
        EditLabel.Height = 17
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 100
        TabOrder = 1
        Text = ''
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 448
    Width = 1050
    ExplicitTop = 448
    ExplicitWidth = 1050
    DesignSize = (
      1050
      67)
    inherited btnGravar: TBitBtn
      Left = 260
      ExplicitLeft = 260
    end
    inherited btnFechar: TBitBtn
      Left = 965
      ExplicitLeft = 965
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'select categoriaId, descricao from categorias')
    object QryListagemcategoriaId: TZIntegerField
      DisplayLabel = 'Codigo'
      FieldName = 'categoriaId'
      Required = True
    end
    object QryListagemdescricao: TZUnicodeStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 100
    end
  end
end
