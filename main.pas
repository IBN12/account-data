unit main;

(* \Notes\
  => Interface uses:
  accountEntryWin: TaccountEntryWindow class

  => Creating Objects: Creating objects such as buttons or labels while the
  application is running (at runtime) requires code to instantiate, size, position,
  parent, and assign events to them.

*)

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, accountEntryWin, activeWindows, windowCount, activeAccounts;

// TForm1 = Main Form:
type
  TForm1 = class(TForm)
    accountDataTitle: TLabel;
    accountDataSubtitle: TLabel;
    newAccountLabel: TLabel;
    newAccountIcon: TImage;
    accountDataActiveWindowsPanel: TFlowPanel;
    activeWindowsLabel: TLabel;
    activeAccountEntriesPanel: TPanel;
    activeAccountEntriesLabel: TLabel;
    ScrollBox1: TScrollBox;
    procedure FormPaint(Sender: TObject);
    procedure newAccountIconClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure activeWindowsLabelClick(Sender: TObject);
    procedure AddAccountEntry(const Account: TAccountRecord);
  private
    procedure OpenActiveAccountEntryWindow(Sender: TObject);
  public
    { Public declarations }
  end;

var
  // Main Form variables:
  Form1: TForm1;

implementation

{$R *.dfm}

// Procedure:
procedure TForm1.FormDestroy(Sender: TObject);
begin
end;

// Procedure:
procedure TForm1.FormPaint(Sender: TObject);
begin
  Canvas.Pen.Color := clRed;
  Canvas.Pen.Width := 1;
  Canvas.MoveTo(50,115);
  Canvas.LineTo(clientWidth - 40, 115);
end;


procedure TForm1.activeWindowsLabelClick(Sender: TObject);
begin

end;


// Procedure: Create a new 'Account Entry Window' instance every time:
procedure TForm1.newAccountIconClick(Sender: TObject);
var
  accountEntryWindowNum: Integer;
  accountEntryWindowActiveTag: TActiveAccountEntryWindowButton;
begin
  // WGO: Create a new 'Account Entry Window' instance:
  accountEntryWindow := TaccountEntryWindow.Create(Application);
  accountEntryWindow.Show;

  // WGO: Temporary count method has been added for every window opened just in case:
  Inc(accountEntryWindowCount);
  accountEntryWindowNum := accountEntryWindowCount;

  // WGO: Create the new tag (accountEntryWindowTag) inside the
  // 'Account Data Actives Windows Panel':
  accountEntryWindowActiveTag := TActiveAccountEntryWindowButton.Create(Self);
  with accountEntryWindowActiveTag do
    begin
      Parent := accountDataActiveWindowsPanel; // Attach to the Panel
      Width := 150;
      Height := 41;
      Caption := 'Account Entry Window' + ' ' + IntToStr(accountEntryWindowCount);
      Name := 'accountEntryWindowTag_' + IntToStr(accountEntryWindowCount);
    end;
    Inc(tagSpacing, 50);

    // WGO: Directly assign the object reference:
    accountEntryWindowActiveTag.LinkedWindow := accountEntryWindow;
    accountEntryWindowActiveTag.OnClick := OpenActiveAccountEntryWindow;

    // Note: TFlowPanel will automatically handle the positioning. Therefore,
    // when the 'Account Entry Window' calls 'CurrrentCtrl.Free' inside its 'FormDestroy',
    // the 'TFlowPanel' will automatically animate/snap the remaining buttons to the left.

end;


// procedure: Open the active 'Account Entry Window':
procedure TForm1.OpenActiveAccountEntryWindow(Sender: TObject);
var
  Btn: TActiveAccountEntryWindowButton;
  begin
    Btn := Sender as TActiveAccountEntryWindowButton;

    if Assigned(Btn.LinkedWindow) then
    begin
      if Btn.LinkedWindow.WindowState = wsMinimized then
        Btn.LinkedWindow.WindowState := wsNormal;

      Btn.LinkedWindow.BringToFront;
    end;
  end;


// procedure: ...
procedure TForm1.AddAccountEntry(const Account: TAccountRecord);
var
  EntryPanel: TPanel;
  CxIdPanel: TLabel;
  FirstName: TLabel;
  LastName: TLabel;
  Age: TLabel;
  NextTop: Integer;
  begin
    // Read current panel height BEFORE adding the child — with AutoSize = True
    // this equals the bottom edge of all existing content, so the new entry
    // is always appended below instead of overlapping the header label:
    NextTop := activeAccountEntriesPanel.Height;

    // 1. Create a container panel for this specific account entry:
    EntryPanel := TPanel.Create(Self);
    EntryPanel.AutoSize := False;
    EntryPanel.Height := 100;
    EntryPanel.Width := activeAccountEntriesPanel.Width;
    EntryPanel.Align := alNone;
    EntryPanel.Top := NextTop;
    EntryPanel.BevelOuter := bvNone;
    EntryPanel.BevelInner := bvNone;
    EntryPanel.BevelKind := bkFlat;
    EntryPanel.BevelWidth := 3;
    EntryPanel.Padding.Bottom := 4;
    EntryPanel.Parent := activeAccountEntriesPanel;

    // 2. Create a label inside the EntryPanel to show the account info:
    CxIdPanel := TLabel.Create(Self);
    CxIdPanel.Parent := EntryPanel;
    CxIdPanel.Width := EntryPanel.Width;
    CxIdPanel.AutoSize := False;
//    CxIdPanel.Align := alClient;
//    CxIdPanel.Layout := tlCenter;

    FirstName := TLabel.Create(Self);
    FirstName.Parent := EntryPanel;
    FirstName.AutoSize := False;
    FirstName.Height := 20;
    FirstName.Width := EntryPanel.Width;
    FirstName.Top := 20;
//    FirstName.ParentColor := False;
//    FirstName.Transparent := False;
//    FirstName.Color := $00FF0000;

    LastName := TLabel.Create(Self);
    LastName.Parent := EntryPanel;
    LastName.AutoSize := False;
    LastName.Height := 20;
    LastName.Width := EntryPanel.Width;
    LastName.Top := 40;

    Age := TLabel.Create(Self);
    Age.Parent := EntryPanel;
    Age.AutoSize := False;
    Age.Height := 20;
    Age.Width := EntryPanel.Width;
    Age.Top := 60;

    // Format the display text nicely:
    CxIdPanel.Caption := Format(' CxID: %s ', [Account.CxId]);
    CxIdPanel.Font.Name := 'Segoe UI';
    CxIdPanel.Font.Size := 12;

    FirstName.Caption := Format('First Name: %s ', [Account.FirstName]);
    FirstName.Font.Name := 'Segoe UI';
    FirstName.Font.Size := 9;

    LastName.Caption := Format('Last Name: %s ', [Account.LastName]);
    LastName.Font.Name := 'Segoe UI';
    LastName.Font.Size := 9;

    Age.Caption := Format('Age: %d ', [Account.Age]);
    Age.Font.Name := 'Segoe UI';
    Age.Font.Size := 9;
  end;
end.
