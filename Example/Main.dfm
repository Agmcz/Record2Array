object Form1: TForm1
  Left = 471
  Top = 219
  Width = 329
  Height = 209
  Caption = 'Test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Write'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 153
    Height = 21
    TabOrder = 1
    Text = 'abcdefghijklmnopqrstuvwxyz'
  end
  object Button2: TButton
    Left = 8
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Read'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Edit2: TEdit
    Left = 8
    Top = 32
    Width = 153
    Height = 21
    TabOrder = 3
    Text = '123456789'
  end
  object Edit3: TEdit
    Left = 8
    Top = 88
    Width = 153
    Height = 21
    TabOrder = 4
  end
  object Edit4: TEdit
    Left = 8
    Top = 112
    Width = 153
    Height = 21
    TabOrder = 5
  end
end
