inherited frmConsultaCliente: TfrmConsultaCliente
  Caption = 'frmConsultaCliente'
  ClientHeight = 513
  ClientWidth = 720
  ExplicitWidth = 720
  ExplicitHeight = 513
  TextHeight = 15
  inherited pnlHeader: TPanel
    Width = 720
    ExplicitWidth = 720
    inherited lblTitulo: TLabel
      Width = 720
      Caption = 'CONSULTA DE CLIENTES'
      ExplicitWidth = 217
    end
    inherited mskPesquisa: TMaskEdit
      Width = 720
      ExplicitWidth = 720
    end
  end
  inherited pnlFooter: TPanel
    Top = 446
    Width = 720
    ExplicitTop = 446
    ExplicitWidth = 720
    inherited btnFechar: TBitBtn
      Left = 633
      ExplicitLeft = 633
    end
  end
  inherited pnlBody: TPanel
    Width = 720
    Height = 357
    ExplicitWidth = 720
    ExplicitHeight = 357
    inherited grdPesquisa: TDBGrid
      Width = 718
      Height = 355
      Columns = <
        item
          Expanded = False
          FieldName = 'clienteId'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Width = 449
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cpf'
          Width = 177
          Visible = True
        end>
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT clienteId,'
      '             nome,'
      '             cpf'
      'FROM clientes')
    Left = 500
    Top = 18
    object QryListagemclienteId: TZIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'clienteId'
      Required = True
    end
    object QryListagemnome: TZUnicodeStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object QryListagemcpf: TZUnicodeStringField
      DisplayLabel = 'CPF'
      FieldName = 'cpf'
      Size = 14
    end
  end
  inherited dtsListagem: TDataSource
    Left = 580
    Top = 18
  end
end
