unit Geometry.Point;

interface

type
  TPoint = class
  private
    FX: Double;
    FY: Double;
  public
    constructor Create(X, Y: Double);
    function GetX: Double;
    function GetY: Double;
    function DistanceTo(Point: TPoint): Double;
  end;

implementation

{ TPoint }

constructor TPoint.Create(X, Y: Double);
begin
  FX := X;
  FY := Y;
end;

function TPoint.DistanceTo(Point: TPoint): Double;
begin
  Result := Sqrt(Sqr(FX - Point.GetX) + Sqr(FY - Point.GetY));
end;

function TPoint.GetX: Double;
begin
  Result := FX;
end;

function TPoint.GetY: Double;
begin
  Result := FY;
end;

end.
