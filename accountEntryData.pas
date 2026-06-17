unit accountEntryData;

(* \Data Notes\
  For an account-data app, the typical combination is a record (or class)
  for one account plus a TObjectList<T> or TList<T> to hold them all - or a
  TDictionary if I mostly look them up by an ID.

  record: Groupss related fields into one type. I can use this to model a single account.
  However, records cannot be inherited in Delphi. Object pascal explicitly designed
  records as light-weight value types that do not support inheritance or polymorphism.
  Classes support inheritance.

  TList<T>: This is suitable since its a generic list (in System.Generics.Collections).
  Probably the best default for this type of application - I can add, remove, and index
  items without managing length on my own.
*)

interface


uses
  System.Generics.Collections, System.SysUtils, System.Classes, VCL.Dialogs;

// TAccount: Will account information:
type
  TAccount = class(TObject)
    private
      FCxId: String;
      FFirstName: String;
      FLastName: String;
      FAge: Integer;

    public
      constructor Create(CxId: String; FirstName: String; LastName: String; Age: Integer);
      function GetId: String;
  end;

implementation
  constructor TAccount.Create(CxId: string; FirstName: string; LastName: string; Age: Integer);
  begin
    FCxId := CxId;
    FFirstName := FirstName;
    FLastName := LastName;
    FAge := Age;
  end;

  function TAccount.GetId: string;
  begin
    Result := FCxId;
  end;

end.
