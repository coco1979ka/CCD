unit TestGeometry;

interface

uses
  TestFramework, Geometry.Line;

type
  TestTLine = class(TTestCase)
  strict private
    FLine: TBaseLine;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure GetLengthShouldReturnCorrectValue;
  end;

implementation

uses
  Geometry.Point;

procedure TestTLine.SetUp;
begin
  FLine := TLine.Create;
end;

procedure TestTLine.TearDown;
begin
  FLine.Free;
  FLine := nil;
end;

procedure TestTLine.GetLengthShouldReturnCorrectValue;
var
  Length: Double;
  Point1: TPoint;
  Point2: TPoint;
begin
  Point1 := TPoint.Create(0, 0);
  Point2 := TPoint.Create(3, 4);
  FLine.StartPoint := Point1;
  FLine.EndPoint := Point2;
  Length := FLine.GetLength;
  CheckEquals(5, Length, 'Result should be equal');
  Point1.Free;
  Point2.Free;
end;

initialization
  RegisterTest(TestTLine.Suite);
end.

