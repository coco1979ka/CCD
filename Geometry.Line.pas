unit Geometry.Line;

interface

uses
  Geometry.Point;

type
  TBaseLine = class abstract
  private
  protected
    procedure SetEndPoint(const Value: TPoint); virtual; abstract;
    procedure SetStartPoint(const Value: TPoint); virtual; abstract;
  public
    property StartPoint: TPoint write SetStartPoint;
    property EndPoint: TPoint write SetEndPoint;
    function GetLength: double; virtual; abstract;
  end;

  TLine = class(TBaseLine)
  private
    FStartPoint: TPoint;
    FEndPoint: TPoint;
  protected
    procedure SetStartPoint(const Value: TPoint); override;
    procedure SetEndPoint(const Value: TPoint); override;
  public
    function GetLength: Double; override;
  end;

  TCachedLine = class(TBaseLine)
  private
    FLine: TBaseLine;
    FChanged: Boolean;
    FCachedLength: Double;
  protected
    procedure SetEndPoint(const Value: TPoint); override;
    procedure SetStartPoint(const Value: TPoint); override;
  public
    constructor Create(Line: TBaseLine);
    function GetLength: double; override;
  end;

implementation

{ TLine }

constructor TCachedLine.Create(Line: TBaseLine);
begin
  FChanged := True;
  FCachedLength := 0.0;
  FLine := Line;
end;

function TCachedLine.GetLength: Double;
begin
  if FChanged then
  begin
    FCachedLength := FLine.GetLength;
    FChanged := False;
  end;
  Result := FCachedLength;
end;

procedure TCachedLine.SetEndPoint(const Value: TPoint);
begin
  FLine.EndPoint := Value;
  FChanged := True;
end;

procedure TCachedLine.SetStartPoint(const Value: TPoint);
begin
  FLine.StartPoint := Value;
  FChanged := True;
end;

{ TLine }

function TLine.GetLength: Double;
begin
  Result := FStartPoint.DistanceTo(FEndPoint)
end;

procedure TLine.SetEndPoint(const Value: TPoint);
begin
  FEndPoint := Value;
end;

procedure TLine.SetStartPoint(const Value: TPoint);
begin
  FStartPoint := Value;
end;

end.
