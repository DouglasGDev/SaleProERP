inherited frmConsultaFilial: TfrmConsultaFilial
  Caption = 'CONSULTAR FILIAL'
  TextHeight = 15
  inherited pnlHeader: TPanel
    inherited lblTitulo: TLabel
      Width = 1041
      Caption = 'CONSULTAR FILIAL'
      ExplicitWidth = 170
    end
  end
  inherited pnlBody: TPanel
    inherited grdPesquisa: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'filialId'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'numfilial'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fantasia'
          Width = 496
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cnpj'
          Width = 188
          Visible = True
        end>
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT filialId,'
      '             numfilial,'
      '             fantasia,'
      '             cnpj'
      'FROM filiais'
      '            ')
    object QryListagemfilialId: TZIntegerField
      DisplayLabel = 'Cod. Filial'
      FieldName = 'filialId'
      Required = True
    end
    object QryListagemnumfilial: TZIntegerField
      DisplayLabel = 'N'#186' Filial'
      FieldName = 'numfilial'
      Required = True
    end
    object QryListagemfantasia: TZUnicodeStringField
      DisplayLabel = 'Fantasia'
      FieldName = 'fantasia'
      Size = 255
    end
    object QryListagemcnpj: TZUnicodeStringField
      DisplayLabel = 'CNPJ'
      FieldName = 'cnpj'
      Size = 18
    end
  end
end
