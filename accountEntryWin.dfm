object accountEntryWindow: TaccountEntryWindow
  Left = 0
  Top = 0
  Caption = 'Account Entry'
  ClientHeight = 441
  ClientWidth = 624
  Color = clAntiquewhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 15
  object Timer1: TTimer
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 536
    Top = 32
  end
end
