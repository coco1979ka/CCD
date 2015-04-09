unit SalesCheckPrinter;

interface

uses
  Generics.Collections;

type
  TSalesCheck = class
  private
    FName: string;
    FId: Integer;
    procedure SetId(const Value: Integer);
    procedure SetName(const Value: string);
  published
    property Name: string read FName write SetName;
    property Id: Integer read FId write SetId;
  end;

  TSalesCheckPrinter = class
  private
    procedure PrintHeader;
    procedure PrintFooter;
  public
    procedure PrintSalesCheck(List: TList<TSalesCheck>);
  end;

implementation

uses
  SysUtils;

{ TSalesCheck }

procedure TSalesCheck.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TSalesCheck.SetName(const Value: string);
begin
  FName := Value;
end;

{ TSalesCheckPrinter }

procedure TSalesCheckPrinter.PrintFooter;
begin
   Writeln('====== END ========');
end;

procedure TSalesCheckPrinter.PrintHeader;
begin
   Writeln('====== SALES =======');
end;

procedure TSalesCheckPrinter.PrintSalesCheck(List: TList<TSalesCheck>);
var
  Item: TSalesCheck;
begin
  PrintHeader;
  for Item in List do
  begin
    Writeln('ID: ' + IntToStr(Item.Id) + ' - ' + Item.Name);
  end;
  PrintFooter;
end;

end.
