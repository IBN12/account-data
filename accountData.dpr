program accountData;

uses
  Vcl.Forms,
  main in 'main.pas' {Form1},
  accountEntryWin in 'accountEntryWin.pas' {accountEntryWindow};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TaccountEntryWindow, accountEntryWindow);
  Application.Run;
end.
