object accountEntryWindow: TaccountEntryWindow
  Left = 0
  Top = 0
  AlphaBlend = True
  Caption = 'Account Entry'
  ClientHeight = 510
  ClientWidth = 778
  Color = clAntiquewhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnShow = FormShow
  TextHeight = 15
  object aew_Title: TLabel
    Left = 32
    Top = 29
    Width = 143
    Height = 21
    Caption = 'Account Entry'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'THE SCORE'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object aew_Subtitle: TLabel
    Left = 40
    Top = 56
    Width = 375
    Height = 19
    Caption = 
      'Fill out the fields and submit the data to create a new account.' +
      ' '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object aew_cx_label: TLabel
    Left = 32
    Top = 136
    Width = 81
    Height = 17
    Alignment = taCenter
    Caption = 'Create Cx ID'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object aew_firstName_label: TLabel
    Left = 32
    Top = 224
    Width = 66
    Height = 17
    Alignment = taCenter
    Caption = 'First Name'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object aew_lastName_label: TLabel
    Left = 32
    Top = 261
    Width = 66
    Height = 17
    Alignment = taCenter
    Caption = 'Last Name'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object aew_age_label: TLabel
    Left = 32
    Top = 304
    Width = 25
    Height = 17
    Alignment = taCenter
    Caption = 'Age'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object aew_cxRule_label: TLabel
    Left = 128
    Top = 163
    Width = 163
    Height = 15
    Caption = 'Cx ID: Must be a six digit number'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object aew_cx_input: TEdit
    Left = 128
    Top = 134
    Width = 305
    Height = 23
    TabOrder = 0
  end
  object aew_firstName_input: TEdit
    Left = 128
    Top = 222
    Width = 305
    Height = 23
    TabOrder = 1
  end
  object aew_lastName_input: TEdit
    Left = 128
    Top = 259
    Width = 305
    Height = 23
    TabOrder = 2
  end
  object aew_age_input: TEdit
    Left = 128
    Top = 302
    Width = 305
    Height = 23
    TabOrder = 3
  end
  object aew_submit_button: TButton
    Left = 128
    Top = 360
    Width = 137
    Height = 25
    Cursor = crHandPoint
    Caption = 'Submit'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = aew_submit_buttonClick
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 536
    Top = 32
  end
end
