object frmDashboard: TfrmDashboard
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'DASHBOARD'
  ClientHeight = 715
  ClientWidth = 1015
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 1015
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    Caption = 'DASHBOARD'
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 1011
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 656
    Width = 1015
    Height = 59
    Align = alBottom
    BevelOuter = bvNone
    Color = clTeal
    ParentBackground = False
    TabOrder = 1
    ExplicitTop = 655
    ExplicitWidth = 1011
  end
  object pnlBody: TPanel
    Left = 0
    Top = 97
    Width = 1015
    Height = 559
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 1011
    ExplicitHeight = 558
    object grdPnlGraficos: TGridPanel
      Left = 1
      Top = 1
      Width = 1013
      Height = 557
      Align = alClient
      BevelOuter = bvNone
      Color = 16767927
      ColumnCollection = <
        item
          Value = 50.000000000000000000
        end
        item
          Value = 50.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = DBCProdutoEstoque
          Row = 0
        end
        item
          Column = 1
          Control = DBCValorVendaCliente
          Row = 0
        end
        item
          Column = 1
          Control = DBCTop10ProdutosMaisVendidos
          Row = 1
        end
        item
          Column = 0
          Control = DBChart1
          Row = 1
        end>
      ParentBackground = False
      RowCollection = <
        item
          Value = 50.000000000000000000
        end
        item
          Value = 50.000000000000000000
        end
        item
          SizeStyle = ssAuto
        end
        item
          SizeStyle = ssAuto
        end>
      TabOrder = 0
      ExplicitWidth = 1009
      ExplicitHeight = 556
      object DBCProdutoEstoque: TDBChart
        Left = 0
        Top = 0
        Width = 506
        Height = 278
        RefreshInterval = 10
        Title.Text.Strings = (
          'Produto em Estoque')
        Align = alClient
        BevelOuter = bvNone
        Color = 16767927
        TabOrder = 0
        AutoSize = True
        DefaultCanvas = 'TGDIPlusCanvas'
        PrintMargins = (
          15
          16
          15
          16)
        ColorPaletteIndex = 13
        object Series1: TBarSeries
          HoverElement = []
          Marks.Brush.Gradient.Colors = <
            item
              Color = clRed
            end
            item
              Color = 819443
              Offset = 0.067915690866510540
            end
            item
              Color = clYellow
              Offset = 1.000000000000000000
            end>
          Marks.Brush.Gradient.Direction = gdTopBottom
          Marks.Brush.Gradient.EndColor = clYellow
          Marks.Brush.Gradient.MidColor = 819443
          Marks.Brush.Gradient.StartColor = clRed
          Marks.Brush.Gradient.Visible = True
          Marks.Font.Color = 159
          Marks.Font.Name = 'Tahoma'
          Marks.Font.Style = [fsBold, fsItalic]
          Marks.Frame.Color = 33023
          Marks.RoundSize = 14
          Marks.Visible = False
          DataSource = DtmGrafico.QryProdutoEstoque
          Title = 'ProdutoEstoque'
          XLabelsSource = 'Label'
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
          YValues.ValueSource = 'Value'
        end
      end
      object DBCValorVendaCliente: TDBChart
        Left = 506
        Top = 0
        Width = 507
        Height = 278
        RefreshInterval = 10
        Title.Text.Strings = (
          'Valor de venda por cliente na '#250'ltima semana.')
        View3DOptions.Elevation = 315
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 0
        View3DOptions.Rotation = 360
        Align = alClient
        BevelOuter = bvNone
        Color = 16767927
        TabOrder = 1
        AutoSize = True
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series2: TPieSeries
          HoverElement = []
          Marks.Brush.Gradient.Colors = <
            item
              Color = clRed
            end
            item
              Color = 819443
              Offset = 0.067915690866510540
            end
            item
              Color = clYellow
              Offset = 1.000000000000000000
            end>
          Marks.Brush.Gradient.Direction = gdTopBottom
          Marks.Brush.Gradient.EndColor = clYellow
          Marks.Brush.Gradient.MidColor = 819443
          Marks.Brush.Gradient.StartColor = clRed
          Marks.Brush.Gradient.Visible = True
          Marks.Font.Color = 159
          Marks.Font.Name = 'Tahoma'
          Marks.Font.Style = [fsBold, fsItalic]
          Marks.Frame.Color = 33023
          Marks.RoundSize = 14
          Marks.Visible = False
          Marks.Style = smsPercentTotal
          Marks.Callout.Length = 20
          Marks.Tail.Margin = 2
          DataSource = DtmGrafico.QryValorVendaPorCliente
          Title = 'ValorDeVendaPorClienteNaUltimaSemana'
          XLabelsSource = 'Label'
          XValues.Order = loAscending
          YValues.Name = 'Pie'
          YValues.Order = loNone
          YValues.ValueSource = 'Value'
          Frame.InnerBrush.BackColor = clRed
          Frame.InnerBrush.Gradient.EndColor = clGray
          Frame.InnerBrush.Gradient.MidColor = clWhite
          Frame.InnerBrush.Gradient.StartColor = 4210752
          Frame.InnerBrush.Gradient.Visible = True
          Frame.MiddleBrush.BackColor = clYellow
          Frame.MiddleBrush.Gradient.EndColor = 8553090
          Frame.MiddleBrush.Gradient.MidColor = clWhite
          Frame.MiddleBrush.Gradient.StartColor = clGray
          Frame.MiddleBrush.Gradient.Visible = True
          Frame.OuterBrush.BackColor = clGreen
          Frame.OuterBrush.Gradient.EndColor = 4210752
          Frame.OuterBrush.Gradient.MidColor = clWhite
          Frame.OuterBrush.Gradient.StartColor = clSilver
          Frame.OuterBrush.Gradient.Visible = True
          Frame.Width = 4
          OtherSlice.Legend.TextStyle = ltsPercent
          OtherSlice.Legend.Visible = False
        end
      end
      object DBCTop10ProdutosMaisVendidos: TDBChart
        Left = 506
        Top = 278
        Width = 507
        Height = 279
        RefreshInterval = 10
        Title.Text.Strings = (
          'Top 10 Produtos mais vendidos')
        View3DOptions.Elevation = 315
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 0
        View3DOptions.Rotation = 360
        Align = alClient
        BevelOuter = bvNone
        Color = 16767927
        TabOrder = 2
        AutoSize = True
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object PieSeries1: TPieSeries
          HoverElement = []
          Marks.Brush.Gradient.Colors = <
            item
              Color = clRed
            end
            item
              Color = 819443
              Offset = 0.067915690866510540
            end
            item
              Color = clYellow
              Offset = 1.000000000000000000
            end>
          Marks.Brush.Gradient.Direction = gdTopBottom
          Marks.Brush.Gradient.EndColor = clYellow
          Marks.Brush.Gradient.MidColor = 819443
          Marks.Brush.Gradient.StartColor = clRed
          Marks.Brush.Gradient.Visible = True
          Marks.Font.Color = 159
          Marks.Font.Name = 'Tahoma'
          Marks.Font.Style = [fsBold, fsItalic]
          Marks.Frame.Color = 33023
          Marks.RoundSize = 14
          Marks.Visible = False
          Marks.Style = smsPercentTotal
          Marks.Callout.Length = 20
          Marks.Tail.Margin = 2
          DataSource = DtmGrafico.QryTopProdutosMaisVendidos
          Title = 'Top10ProdutosMaisVendidos'
          XLabelsSource = 'Label'
          XValues.Order = loAscending
          YValues.Name = 'Pie'
          YValues.Order = loNone
          YValues.ValueSource = 'Value'
          Frame.InnerBrush.BackColor = clRed
          Frame.InnerBrush.Gradient.EndColor = clGray
          Frame.InnerBrush.Gradient.MidColor = clWhite
          Frame.InnerBrush.Gradient.StartColor = 4210752
          Frame.InnerBrush.Gradient.Visible = True
          Frame.MiddleBrush.BackColor = clYellow
          Frame.MiddleBrush.Gradient.EndColor = 8553090
          Frame.MiddleBrush.Gradient.MidColor = clWhite
          Frame.MiddleBrush.Gradient.StartColor = clGray
          Frame.MiddleBrush.Gradient.Visible = True
          Frame.OuterBrush.BackColor = clGreen
          Frame.OuterBrush.Gradient.EndColor = 4210752
          Frame.OuterBrush.Gradient.MidColor = clWhite
          Frame.OuterBrush.Gradient.StartColor = clSilver
          Frame.OuterBrush.Gradient.Visible = True
          Frame.Width = 4
          OtherSlice.Legend.TextStyle = ltsPercent
          OtherSlice.Legend.Visible = False
        end
      end
      object DBChart1: TDBChart
        Left = 0
        Top = 278
        Width = 506
        Height = 279
        RefreshInterval = 10
        Title.Text.Strings = (
          'Vendas da '#250'ltima semana')
        Align = alClient
        BevelOuter = bvNone
        Color = 16767927
        TabOrder = 3
        AutoSize = True
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series3: TFastLineSeries
          HoverElement = []
          DataSource = DtmGrafico.QryVendasUltimaSemana
          Title = 'VendasUltimaSemana'
          XLabelsSource = 'Label'
          LinePen.Color = 10708548
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          YValues.ValueSource = 'Value'
        end
      end
    end
  end
end
