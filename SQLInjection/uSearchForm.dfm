object frmMainSQLInjection: TfrmMainSQLInjection
  Left = 0
  Top = 0
  Caption = 'SQL Injection Demo'
  ClientHeight = 433
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    632
    433)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 102
    Width = 52
    Height = 13
    Caption = 'Search For'
  end
  object Label2: TLabel
    Left = 8
    Top = 9
    Width = 46
    Height = 13
    Caption = 'Database'
  end
  object Label3: TLabel
    Left = 8
    Top = 57
    Width = 120
    Height = 13
    Caption = 'Example Injection Scripts'
  end
  object edtSearchTerm: TEdit
    Left = 8
    Top = 121
    Width = 265
    Height = 21
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 164
    Width = 616
    Height = 261
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnUnsafeSearch: TButton
    Left = 279
    Top = 119
    Width = 97
    Height = 25
    Caption = 'Unsafe Search'
    Enabled = False
    TabOrder = 2
    OnClick = btnUnsafeSearchClick
  end
  object btnSafeSearch: TButton
    Left = 382
    Top = 119
    Width = 75
    Height = 25
    Caption = 'Safe Search'
    Enabled = False
    TabOrder = 3
    OnClick = btnSafeSearchClick
  end
  object edtDatabase: TEdit
    Left = 8
    Top = 28
    Width = 497
    Height = 21
    TabOrder = 4
  end
  object Button3: TButton
    Left = 504
    Top = 26
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 5
    OnClick = Button3Click
  end
  object btnOpenClose: TButton
    Left = 544
    Top = 26
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 6
    OnClick = btnOpenCloseClick
  end
  object btnLoadExample: TButton
    Left = 327
    Top = 73
    Width = 97
    Height = 25
    Caption = 'Load Example'
    TabOrder = 7
    OnClick = btnLoadExampleClick
  end
  object cbxExamples: TComboBox
    Left = 8
    Top = 75
    Width = 313
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 8
    Text = 'a'
    Items.Strings = (
      'a'
      'a '#39' union select name, sql from sqlite_master --'
      'a '#39' union select name, value from salary --')
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 280
    Top = 281
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 464
    Top = 281
  end
  object FDConnection1: TFDConnection
    Left = 160
    Top = 281
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = []
    Left = 584
    Top = 57
  end
end
