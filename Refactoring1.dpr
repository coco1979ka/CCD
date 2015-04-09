program Refactoring1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Generics.Collections,
  SalesCheckPrinter in 'SalesCheckPrinter.pas';

var
  Item1,
  Item2: TSalesCheck;
  SalesCheckPrinter: TSalesCheckPrinter;
  SalesList: TList<TSalesCheck>;
begin
  try
    { TODO -oUser -cConsole Main : Code hier einfügen }
    Item1 := TSalesCheck.Create;
    Item2 := TSalesCheck.Create;
    SalesList := TList<TSalesCheck>.Create;
    SalesCheckPrinter := TSalesCheckPrinter.Create;
    try
      Item1.Id := 0;
      Item1.Name := 'Hallo';
      Item2.Id := 1;
      Item2.Name := 'Welt';

      SalesList.Add(Item1);
      SalesList.Add(Item2);

      SalesCheckPrinter.PrintSalesCheck(SalesList);
    finally
      SalesCheckPrinter.Free;
      SalesList.Free;
      Item1.Free;
      Item2.Free;
    end;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
