unit DeviceController;

interface

uses
  Generics.Collections,
  DeviceAPI;

type
  TDeviceController = class
  private
    FDeviceNameHandleMap: TDictionary<string, THandle>;
    function GetDeviceHandle(DeviceName: string): THandle;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SendShutDown;
  end;

implementation

uses
  SysUtils;

const
  INVALID_HANDLE = 0;
  DEV1 = 'MyDevice';

{ TDeviceController }

constructor TDeviceController.Create;
begin
  FDeviceNameHandleMap := TDictionary<string,THandle>.Create;
end;

destructor TDeviceController.Destroy;
begin
  FDeviceNameHandleMap.Free;
  inherited;
end;

function TDeviceController.GetDeviceHandle(DeviceName: string): THandle;
begin
  FDeviceNameHandleMap.TryGetValue(DeviceName, Result);
end;

procedure TDeviceController.SendShutDown;
var
  Handle : THandle;
  Device : TDeviceInfo;
begin
  Handle := GetDeviceHandle(DEV1);
  if(Handle <> INVALID_HANDLE) then
  begin
    Device := RetrieveDeviceRecord(Handle);
    if (Device.Status <> TDeviceStatus.Suspended) then
    begin
      if not PauseDevice(Handle) then
        Writeln('Could not pause device');
      if not ClearDeviceWorkqueue(Handle) then
        Writeln('Could not clear working queue. Code: ' + IntToStr(GetLastErrorCode));
      if not CloseDevice(Handle) then
        Writeln('Could not close device');
    end
    else
    begin
      Writeln('Device suspended.');
    end;
  end
  else
  begin
    Writeln('Invalid device' + DEV1);
  end;
end;



end.
