object DtmGrafico: TDtmGrafico
  Height = 480
  Width = 640
  object QryProdutoEstoque: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'SELECT CONCAT(CAST(produtoId AS CHAR), '#39' - '#39', nome) AS Label, Qu' +
        'antidade AS Value FROM produtos')
    Params = <>
    Left = 44
    Top = 41
    object QryProdutoEstoqueLabel: TZUnicodeStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 74
    end
    object QryProdutoEstoqueValue: TZFMTBCDField
      FieldName = 'Value'
      Precision = 18
      Size = 5
    end
  end
  object QryValorVendaPorCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'SELECT CONCAT(CAST(vendas.clienteId AS CHAR), '#39' - '#39', clientes.no' +
        'me) AS Label, '
      '       SUM(vendas.totalVenda) AS Value '
      'FROM Vendas '
      'INNER JOIN clientes ON clientes.clienteId = vendas.clienteId '
      
        'WHERE vendas.dataVenda BETWEEN DATE_SUB(CURDATE(), INTERVAL 7 DA' +
        'Y) AND CURDATE() '
      'GROUP BY vendas.clienteId, clientes.nome;')
    Params = <>
    Left = 360
    Top = 48
    object QryValorVendaPorClienteLabel: TZUnicodeStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 74
    end
    object QryValorVendaPorClienteValue: TZFMTBCDField
      FieldName = 'Value'
      ReadOnly = True
      Precision = 40
      Size = 5
    end
  end
  object QryTopProdutosMaisVendidos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'SELECT CONCAT(CAST(vi.produtoId AS CHAR), '#39' - '#39', p.nome) AS Labe' +
        'l, SUM(vi.totalProduto) AS Value '
      'FROM vendasItens AS vi '
      'INNER JOIN produtos AS p ON p.produtoId = vi.produtoId '
      'GROUP BY vi.produtoId, p.nome'
      'ORDER BY Label DESC '
      'LIMIT 10')
    Params = <>
    Left = 72
    Top = 144
    object QryTopProdutosMaisVendidosLabel: TZUnicodeStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 74
    end
    object QryTopProdutosMaisVendidosValue: TZFMTBCDField
      FieldName = 'Value'
      ReadOnly = True
      Precision = 40
      Size = 5
    end
  end
  object QryVendasUltimaSemana: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'SELECT DATE(vendas.dataVenda) AS Label, SUM(vendas.totalVenda) A' +
        'S Value '
      'FROM vendas '
      
        'WHERE vendas.dataVenda BETWEEN DATE_SUB(CURDATE(), INTERVAL 7 DA' +
        'Y) AND CURDATE() '
      'GROUP BY DATE(vendas.dataVenda);')
    Params = <>
    Left = 360
    Top = 152
    object QryVendasUltimaSemanaLabel: TZDateField
      FieldName = 'Label'
      ReadOnly = True
    end
    object QryVendasUltimaSemanaValue: TZFMTBCDField
      FieldName = 'Value'
      ReadOnly = True
      Precision = 40
      Size = 5
    end
  end
end
