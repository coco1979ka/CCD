unit TestCaching;

interface

uses
  Geometry.Line,
  Geometry.Point,
  TestFramework;

type
  TLineListeningFake = class(TBaseLine)
  private
    FNumberOfCalculations: Integer;
  protected
    procedure SetEndPoint(const Value: TPoint); override;
    procedure SetStartPoint(const Value: TPoint); override;
  public
    function GetLength: Double; override;
    function NumberOfCalculations: Integer;
    procedure Reset;
  end;

  TTestCaching = class(TTestCase)
  private
    FStartPoint: TPoint;
    FEndPoint: TPoint;
    FLineListeningFake: TLineListeningFake;
    FCachedLine: TBaseLine;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure CalculationShouldBeExecutedIfPointChanges;
    procedure ShouldUseCachedResultIfPointsAreNotChanged;
  end;

implementation

{ TTestCaching }

procedure TTestCaching.CalculationShouldBeExecutedIfPointChanges;
var
  NewPoint: TPoint;
begin
  FLineListeningFake.Reset;
  FCachedLine.GetLength;
  //When Endpoint changes
  NewPoint := TPoint.Create(1,1);
  FCachedLine.EndPoint := NewPoint;
  FCachedLine.GetLength;
  //Execution of Getlength should be called twice
  CheckEquals(2, FLineListeningFake.NumberOfCalculations);
  NewPoint.Free;
end;

procedure TTestCaching.ShouldUseCachedResultIfPointsAreNotChanged;
begin
  FLineListeningFake.Reset;
  FCachedLine.GetLength;
  FCachedLine.GetLength;
  CheckEquals(1, FLineListeningFake.NumberOfCalculations);
end;

procedure TTestCaching.SetUp;
var
  Point1, Point2: TPoint;
begin
  inherited;
  FStartPoint := TPoint.Create(0,0);
  FEndPoint := TPoint.Create(1,0);
  FLineListeningFake := TLineListeningFake.Create;
  FCachedLine := TCachedLine.Create(FLineListeningFake);
  FCachedLine.StartPoint := FStartPoint;
  FCachedLine.EndPoint := FEndPoint;
end;

procedure TTestCaching.TearDown;
begin
  inherited;
  FStartPoint.Free;
  FEndPoint.Free;
  FCachedLine.Free;
  FLineListeningFake.Free;
end;

{ TLineListeningFake }

function TLineListeningFake.GetLength: Double;
begin
  Inc(FNumberOfCalculations);
  Result := 0.0;
end;

function TLineListeningFake.NumberOfCalculations: Integer;
begin
  Result := FNumberOfCalculations;
end;

procedure TLineListeningFake.Reset;
begin
  FNumberOfCalculations := 0;
end;

procedure TLineListeningFake.SetEndPoint(const Value: TPoint);
begin
  inherited;
end;

procedure TLineListeningFake.SetStartPoint(const Value: TPoint);
begin
  inherited;
end;

initialization
  RegisterTest(TTestCaching.Suite);

end.
