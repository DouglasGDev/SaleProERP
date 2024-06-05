inherited frmConsultaProduto: TfrmConsultaProduto
  Caption = 'frmConsultaProduto'
  TextHeight = 15
  inherited pnlHeader: TPanel
    inherited lblTitulo: TLabel
      Caption = 'CONSULTA DE PRODUTOS'
      ExplicitWidth = 233
    end
  end
  inherited pnlBody: TPanel
    inherited grdPesquisa: TDBGrid
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
          FieldName = 'valor'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'codbarras'
          Width = 183
          Visible = True
        end>
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT produtoId,'
      '             nome,'
      '             valor,'
      '             quantidade,'
      '             codbarras'
      'FROM produtos')
    object QryListagemprodutoId: TZIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
      Required = True
    end
    object QryListagemnome: TZUnicodeStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object QryListagemvalor: TZFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
      Precision = 18
      Size = 5
    end
    object QryListagemquantidade: TZFMTBCDField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
      Precision = 18
      Size = 5
    end
    object QryListagemcodbarras: TZUnicodeStringField
      DisplayLabel = 'Cod. Barras'
      FieldName = 'codbarras'
      Size = 13
    end
  end
end
