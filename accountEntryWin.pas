unit accountEntryWin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TaccountEntryWindow = class(TForm)
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  accountEntryWindow: TaccountEntryWindow;
  I: Integer;

implementation

{$R *.dfm}

procedure TaccountEntryWindow.FormShow(Sender: TObject);
begin
  AlphaBlendValue := 0;     // Start invisible
  Timer1.Enabled := True;   // Begin the fade
end;

procedure TaccountEntryWindow.Timer1Timer(Sender: TObject);
  const
    StepSize = 8; // Opacity to add per tick
begin
  if AlphaBlendValue + StepSize >= 255 then
    begin
      AlphaBlendValue := 255; // Snaps to fully opaque
      Timer1.Enabled := False; // Stop the timer; fade is done
    end
  else
    AlphaBlendValue := AlphaBlendValue + StepSize;
end;

end.
