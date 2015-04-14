unit DeviceController;

interface

uses
  SysUtils,
  Generics.Collections,
  DeviceAPI;

type
  EDeviceShutDownException = class(Exception)
  end;

  TDeviceController = class
  private
    FDeviceNameHandleMap: TDictionary<string, THandle>;
    function DoRetrieveDeviceRecord(const Handle: THandle): TDeviceInfo;
    procedure DoShutDown(const Handle: THandle; var Device: TDeviceInfo);
    function GetDeviceHandle(DeviceName: string): THandle;
    procedure TryToShutDown;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SendShutDown;
  end;

implementation

const
  INVALID_HANDLE = 0;
  DEV1 = 'MyDevice';

  { TDeviceController }

constructor TDeviceController.Create;
begin
  FDeviceNameHandleMap := TDictionary<string, THandle>.Create;
end;

destructor TDeviceController.Destroy;
begin
  FDeviceNameHandleMap.Free;
  inherited;
end;

function TDeviceController.DoRetrieveDeviceRecord(const Handle: THandle)
  : TDeviceInfo;
begin
  Result := RetrieveDeviceRecord(Handle);
end;

procedure TDeviceController.DoShutDown(const Handle: THandle; var Device: TDeviceInfo);
begin
  if (Device.Status = TDeviceStatus.Suspended) then
    raise EDeviceShutDownException.Create('Device already suspended');
  if not PauseDevice(Handle) then
    Writeln('Could not pause device');
  if not ClearDeviceWorkqueue(Handle) then
    Writeln('Could not clear working queue. Code: ' +
      IntToStr(GetLastErrorCode));
  if not CloseDevice(Handle) then
    Writeln('Could not close device');
end;

function TDeviceController.GetDeviceHandle(DeviceName: string): THandle;
begin
  if not FDeviceNameHandleMap.TryGetValue(DeviceName, Result) then
    raise EDeviceShutDownException.Create('Device Handle not found');
end;

procedure TDeviceController.SendShutDown;
begin
  try
    TryToShutDown;
  except
    on E: EDeviceShutDownException do
      Writeln(E.Message);
  end;
end;

procedure TDeviceController.TryToShutDown;
var
  Handle: THandle;
  Device: TDeviceInfo;
begin
  Handle := GetDeviceHandle(DEV1);
  Device := DoRetrieveDeviceRecord(Handle);
  DoShutDown(Handle, Device);
end;

end.
