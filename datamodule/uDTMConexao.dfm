object dtmPrincipal: TdtmPrincipal
  Height = 200
  Width = 155
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Properties.Strings = (
      'RawStringEncoding=DB_CP')
    TransactIsolationLevel = tiReadCommitted
    Connected = True
    DesignConnection = True
    HostName = '10.0.0.181'
    Port = 3306
    Database = 'vendas'
    User = 'douglas'
    Password = '0927'
    Protocol = 'mysql'
    LibraryLocation = 'E:\ADS\quinto_semestre\projetos4\Estoque\libmysql.dll'
    Left = 56
    Top = 56
  end
end
