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
    procedure PrintAllItemsOf(List: TList<TSalesCheck>);
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

procedure TSalesCheckPrinter.PrintAllItemsOf(List: TList<TSalesCheck>);
var
  Item: TSalesCheck;
begin
  for Item in List do
  begin
    Writeln('ID: ' + IntToStr(Item.Id) + ' - ' + Item.Name);
  end;
end;

procedure TSalesCheckPrinter.PrintFooter;
begin
   Writeln('====== END ========');
end;

procedure TSalesCheckPrinter.PrintHeader;
begin
   Writeln('====== SALES =======');
end;

procedure TSalesCheckPrinter.PrintSalesCheck(List: TList<TSalesCheck>);
begin
  PrintHeader;
  PrintAllItemsOf(List);
  PrintFooter;
end;

end.
