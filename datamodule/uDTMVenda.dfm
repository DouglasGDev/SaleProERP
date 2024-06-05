object dtmVenda: TdtmVenda
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 255
  Width = 355
  object QryCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT clienteId,'
      '             nome'
      'FROM clientes')
    Params = <>
    Left = 24
    Top = 72
    object QryClienteclienteId: TZIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'clienteId'
      Required = True
    end
    object QryClientenome: TZUnicodeStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
  end
  object QryProdutos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT produtoId,'
      '             nome,'
      '             valor,'
      '             quantidade,'
      '             foto'
      'FROM produtos')
    Params = <>
    Left = 96
    Top = 72
    object QryProdutosprodutoId: TZIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
      Required = True
    end
    object QryProdutosnome: TZUnicodeStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object QryProdutosvalor: TZFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
      Precision = 18
      Size = 5
    end
    object QryProdutosquantidade: TZFMTBCDField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
      Precision = 18
      Size = 5
    end
    object QryProdutosfoto: TZBlobField
      FieldName = 'foto'
    end
  end
  object cdsItensVenda: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 208
    Top = 72
    object cdsItensVendaprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
    end
    object cdsItensVendaNomeProduto: TStringField
      DisplayLabel = 'Nome do Produto'
      FieldName = 'NomeProduto'
      Size = 60
    end
    object cdsItensVendaquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object cdsItensVendavalorUnitario: TFloatField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'valorUnitario'
    end
    object cdsItensVendavalorTotalProduto: TFloatField
      DisplayLabel = 'Total do Produto'
      FieldName = 'valorTotalProduto'
    end
    object cdsItensVendavendaId: TIntegerField
      FieldName = 'vendaId'
    end
  end
  object dtsCliente: TDataSource
    DataSet = QryCliente
    Left = 24
    Top = 160
  end
  object dtsProdutos: TDataSource
    DataSet = QryProdutos
    Left = 96
    Top = 160
  end
  object dtsItensVenda: TDataSource
    DataSet = cdsItensVenda
    Left = 208
    Top = 160
  end
end
