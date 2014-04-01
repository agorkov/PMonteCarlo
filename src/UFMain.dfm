object FMain: TFMain
  Left = 0
  Top = 0
  Caption = #1054#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1087#1083#1086#1097#1072#1076#1080' '#1084#1077#1090#1086#1076#1086#1084' '#1052#1086#1085#1090#1077'-'#1050#1072#1088#1083#1086'...'
  ClientHeight = 324
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Image: TImage
    Left = 247
    Top = 8
    Width = 200
    Height = 200
    OnClick = ImageClick
    OnMouseMove = ImageMouseMove
  end
  object Label1: TLabel
    Left = 135
    Top = 264
    Width = 26
    Height = 13
    Caption = 'S=...'
  end
  object Label2: TLabel
    Left = 135
    Top = 295
    Width = 30
    Height = 13
    Caption = 'S:=...'
  end
  object VLECoordinates: TValueListEditor
    Left = 8
    Top = 8
    Width = 217
    Height = 169
    KeyOptions = [keyEdit, keyAdd, keyDelete]
    ScrollBars = ssVertical
    Strings.Strings = (
      '10=10'
      '20=190'
      '50=170'
      '190=170'
      '150=100'
      '190=80')
    TabOrder = 0
    TitleCaptions.Strings = (
      'X'
      'Y')
    ColWidths = (
      150
      61)
  end
  object BDraw: TButton
    Left = 8
    Top = 183
    Width = 217
    Height = 25
    Caption = #1053#1072#1088#1080#1089#1086#1074#1072#1090#1100' '#1084#1085#1086#1075#1086#1091#1075#1086#1083#1100#1085#1080#1082
    TabOrder = 1
    OnClick = BDrawClick
  end
  object LETestCount: TLabeledEdit
    Left = 8
    Top = 232
    Width = 121
    Height = 21
    EditLabel.Width = 97
    EditLabel.Height = 13
    EditLabel.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1090#1086#1095#1077#1082':'
    TabOrder = 2
    Text = '100'
  end
  object BStartTest: TButton
    Left = 8
    Top = 259
    Width = 121
    Height = 25
    Caption = #1057#1087#1086#1089#1086#1073' 1'
    Enabled = False
    TabOrder = 3
    OnClick = BStartTestClick
  end
  object BStartTest2: TButton
    Left = 8
    Top = 290
    Width = 121
    Height = 25
    Caption = #1057#1087#1086#1089#1086#1073' 2'
    Enabled = False
    TabOrder = 4
    OnClick = BStartTest2Click
  end
  object CBShow: TCheckBox
    Left = 135
    Top = 234
    Width = 130
    Height = 17
    Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1090#1086#1095#1082#1080
    TabOrder = 5
  end
end
