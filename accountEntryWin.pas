unit accountEntryWin;

(* \Notes\
  => Keys:
  aew = Account Entry Window.

  => Interface uses:
  accountEntryData: TAccount class;

*)


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, accountEntryData, activeWindows,
  activeAccounts, System.Generics.Collections;

type
  TaccountEntryWindow = class(TForm)
    Timer1: TTimer;
    aew_Title: TLabel;
    aew_Subtitle: TLabel;
    aew_lastName_input: TEdit;
    aew_age_input: TEdit;
    aew_cx_label: TLabel;
    aew_firstName_label: TLabel;
    aew_lastName_label: TLabel;
    aew_age_label: TLabel;
    aew_cxRule_label: TLabel;
    aew_submit_button: TButton;
    aew_cx_input: TEdit;
    aew_firstName_input: TEdit;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure aew_submit_buttonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Account: TAccount;
    age: Integer;

  public
    { Public declarations }
  end;

var
  accountEntryWindow: TaccountEntryWindow;
  Accounts: TObjectList<TAccount>;
  AccountsCreated: Boolean;


implementation

  // Units added here to prevent circular rotation:
  uses main;

{$R *.dfm}

// Procedure: Submit all the account data from the 'Account Entry Window':
procedure TaccountEntryWindow.aew_submit_buttonClick(Sender: TObject);
  var
    NewAccount: TAccountRecord;
begin
  // WGO: Convert String to Integer:
  age := StrToInt(aew_age_input.Text); 
  
  // WGO: Submit all field data by clicking the Submit Button:
  Account := TAccount.Create(aew_cx_input.Text, aew_firstName_input.Text, aew_lastName_input.Text, age);

  // WGO: Instantiate Accounts with TObjectList to hold every Account created.
  if not Assigned(Accounts) then
    Accounts := TObjectList<TAccount>.Create;

  // WGO: Add Account to the TObjectList Accounts and iterate through Accounts: 
  Accounts.Add(Account);
  ShowMessage(Format('Accounts Count:  %d', [Accounts.Count])); // Testing
//  var
//    I: Integer;
//
//    for I := 0 to Accounts.Count-1 do
//      begin
//        Accounts[I].GetId();
//      end;

  // WGO: Add input values to the properties of 'TAccountRecord':
  // Note: Will add form validation and sanitization later:
  NewAccount.CxId := aew_cx_input.Text;
  NewAccount.FirstName := aew_firstName_input.Text;
  NewAccount.LastName := aew_lastName_input.Text;
  NewAccount.Age := age;

  // Send data straight to the Main Form (TForm1):
  Form1.AddAccountEntry(NewAccount);

  // Close and free the window - it is safe in the TForm1:
  Close;
end;


// Procedure: ...
procedure TaccountEntryWindow.FormClose(Sender: TObject; var Action: TCloseAction);
var
  btnShow: TaccountEntryWindow;
  i: Integer;
begin
  // Note: This is how you typecast in Object Pascal:
  btnShow := Sender as TaccountEntryWindow;

  // WGO: Will free the accountEntryWindow when it has been closed:
  // caFree tells VCL to free the form as soon as it closes.
  // The window will only live exactly as long as its on screen, and
  // closing it reclaims its memory immediately - no accumulation of memory.
  Action := caFree;
end;


// Procedure:  ...
procedure TaccountEntryWindow.FormDestroy(Sender: TObject);
  var
    CurrentCtrl: TControl;
    i: Integer;
begin
  // WGO: Will free the Accounts data when the window is closed:
  // FreeAndNil sets the pointer to nil after freeing, preventing a dangling
  // pointer crash when a second window's FormDestroy calls this same global.
  FreeAndNil(Accounts);

  // WGO:  Free the active 'Account Entry Window Buttons' from the deleted memory:
  // Loop backward throughs main form controls to find the matching button:
  (*
     Why: By default, closing a form only hides it. To make sure 'FormDestroy' actually triggers
     when the user clicks the "X" button, add 'Action := caFree' to the child form's 'OnClose's event.

     If a user closes a child window manually, the 'ActiveAccountEntryWindowButton' will still
     point to a deleted memory location. Clicking it will crash the app with an Access Violation.

     Note: This all applies when the user closes the 'Account Entry Window'.

     -> To prevent this:
     1) In the child window's 'OnClose' event, set Action := caFree;.
     2) In the child window's 'OnDestroy' event, notify the main form or find its corresponing button to free it:

     -> Why looping backward (downto 0) is mandatory:
     When you call 'CurrentCtrl.Free', the control is destroyed, and the
     'accountDataActiveWindowsPanel.ControlCount' instantly shrinks by 1. If you looped forward (0 to ControlCount - 1),
     your index variable i would eventually point to a position that no longer exists, resulting in an Index Out of Bounds
     crash. Loopings backward avoids this entirely.
  *)
  // Guard against Form1 already being destroyed during application shutdown:
  if Assigned(Form1) then
    for i := Form1.accountDataActiveWindowsPanel.ControlCount - 1 downto 0 do
      begin
        CurrentCtrl := Form1.accountDataActiveWindowsPanel.Controls[i];

        if (CurrentCtrl is TActiveAccountEntryWindowButton) then
          begin
            if TActiveAccountEntryWindowButton(CurrentCtrl).LinkedWindow = Self then
              begin
                CurrentCtrl.Free;
                Break;
              end;
          end;
      end;
end;


// Procedure: ...
procedure TaccountEntryWindow.FormPaint(Sender: TObject);
begin
  // WGO: Designs a divider line below the title and subtitle:
  Canvas.Pen.Color := clRed;
  Canvas.Pen.Width := 1;
  Canvas.MoveTo(40, 80);
  Canvas.LineTo(clientWidth - 40, 80);
end;


// Procedure: ...
procedure TaccountEntryWindow.FormShow(Sender: TObject);
begin
  // WGO: Set the AlphaBlendValue to zero and activate the Timer
  // to create a smooth transition for the window to open.
  AlphaBlendValue := 0;     // Start invisible
  Timer1.Enabled := True;   // Begin the fade
end;


// Procedure: ...
procedure TaccountEntryWindow.Timer1Timer(Sender: TObject);
  const
    StepSize = 50; // Opacity to add per tick

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
