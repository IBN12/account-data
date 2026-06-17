unit activeAccounts;

interface
uses
  Vcl.StdCtrls, System.SysUtils, Vcl.ExtCtrls, Vcl.Forms;

  // TActiveAccounts = Active Account Container:
  type
    TAccountRecord = record
      CxId: string;             // 6 digit ID
      FirstName: string;        // first name
      LastName: string;         // last name
      Age: integer;             // age
    end;

implementation

end.
