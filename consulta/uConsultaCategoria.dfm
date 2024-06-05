inherited frmConsultaCategoria: TfrmConsultaCategoria
  Caption = 'CONSULTA DE CATEGORIAS'
  TextHeight = 15
  inherited pnlHeader: TPanel
    inherited lblIndice: TLabel
      Color = clWhite
      ParentColor = False
    end
    inherited lblTitulo: TLabel
      Width = 1041
    end
  end
  inherited pnlFooter: TPanel
    inherited btnFechar: TBitBtn
      Top = 19
      ExplicitTop = 19
    end
  end
  inherited pnlBody: TPanel
    inherited grdPesquisa: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'categoriaId'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Visible = True
        end>
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT categoriaId,'
      '             descricao'
      'FROM categorias')
    Left = 540
    Top = 90
    object QryListagemcategoriaId: TZIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      Required = True
    end
    object QryListagemdescricao: TZUnicodeStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 100
    end
  end
  inherited dtsListagem: TDataSource
    Left = 596
    Top = 90
  end
end
