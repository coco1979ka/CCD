unit Geometry.Line;

interface

uses
  Geometry.Point;

type
  TLine = class
  private
    FChanged: Boolean;
    FCachedLength: Double;
    FStartPoint: TPoint;
    FEndPoint: TPoint;
    procedure SetEndPoint(const Value: TPoint);
    procedure SetStartPoint(const Value: TPoint);
  public
    constructor Create;
    function GetLength: Double;
    property StartPoint: TPoint read FStartPoint write SetStartPoint;
    property EndPoint: TPoint read FEndPoint write SetEndPoint;
  end;

implementation

{ TLine }

constructor TLine.Create;
begin
  FChanged := True;
  FCachedLength := 0.0;
end;

function TLine.GetLength: Double;
begin
  if FChanged then
  begin
    FCachedLength := StartPoint.DistanceTo(EndPoint);
    FChanged := False;
  end;
  Result := FCachedLength;
end;

procedure TLine.SetEndPoint(const Value: TPoint);
begin
  FEndPoint := Value;
  FChanged := True;
end;

procedure TLine.SetStartPoint(const Value: TPoint);
begin
  FStartPoint := Value;
  FChanged := False;
end;

end.
