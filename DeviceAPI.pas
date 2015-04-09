unit DeviceAPI;

interface
type
  TDeviceStatus = (Suspended, Ready);

  TDeviceInfo = record
  public
    Status: TDeviceStatus;
  end;

  function PauseDevice(Handle: THandle) : Boolean;
  function ClearDeviceWorkqueue(Handle: THandle) : Boolean;
  function CloseDevice(Handle: THandle) : Boolean;
  function GetLastErrorCode : Integer;
  function RetrieveDeviceRecord(Handle: THandle): TDeviceInfo;

implementation

function PauseDevice(Handle: THandle) : Boolean;
begin
  Writeln('Pausing device');
  Result := True;
end;

function ClearDeviceWorkqueue(Handle: THandle) : Boolean;
begin
  Writeln('Clear device workqueue');
  Result := True;
end;

function CloseDevice(Handle: THandle) : Boolean;
begin
  Writeln('Closing device');
  Result := True;
end;

function GetLastErrorCode : Integer;
begin
  Result := 42;
end;

function RetrieveDeviceRecord(Handle: THandle): TDeviceInfo;
begin
  Result.Status := TDeviceStatus.Ready;
end;

end.
