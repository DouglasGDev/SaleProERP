object dtmEntrada: TdtmEntrada
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 347
  Width = 337
  object cdsGridEntradaProdutoVirtual: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 160
    Top = 112
    object cdsGridEntradaProdutoVirtualprodutoId: TIntegerField
      DisplayLabel = 'C'#243'd. Produto'
      FieldName = 'produtoId'
    end
    object cdsGridEntradaProdutoVirtualnome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object cdsGridEntradaProdutoVirtualquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object cdsGridEntradaProdutoVirtualentradaId: TStringField
      DisplayLabel = 'Cod. Entrada'
      FieldName = 'entradaId'
      Size = 50
    end
    object cdsGridEntradaProdutoVirtualcusto: TFloatField
      DisplayLabel = 'Custo'
      FieldName = 'custo'
    end
    object cdsGridEntradaProdutoVirtualvalorTotal: TFloatField
      DisplayLabel = 'Valor Total Unit'#225'rio'
      FieldName = 'valorTotal'
    end
    object cdsGridEntradaProdutoVirtualStatus: TStringField
      FieldName = 'Status'
      Size = 10
    end
  end
  object dtsGridEntradaProdutoVirtual: TDataSource
    DataSet = cdsGridEntradaProdutoVirtual
    Left = 160
    Top = 208
  end
end
