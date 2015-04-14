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
begin
  FLineListeningFake.Reset;
  CheckEquals(2, FLineListeningFake.NumberOfCalculations);
end;

procedure TTestCaching.SetUp;
begin
  inherited;
  FLineListeningFake := TLineListeningFake.Create;
  FCachedLine := TCachedLine.Create(FLineListeningFake);
end;

procedure TTestCaching.ShouldUseCachedResultIfPointsAreNotChanged;
begin
  CheckEquals(1, FLineListeningFake.NumberOfCalculations);
end;

procedure TTestCaching.TearDown;
begin
  inherited;
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
