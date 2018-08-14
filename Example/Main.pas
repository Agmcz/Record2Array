unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uRecord;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type
  TMyRecord = packed record
    Str: string;
    Int: Integer;
  end;

procedure TForm1.Button1Click(Sender: TObject);
var
  MyRecord: TMyRecord;
  FS: TFileStream;
  TypData: TTypData;
begin
  MyRecord.Str := Edit1.Text;
  MyRecord.Int := StrToInt(Edit2.Text);
  RecordToArray(@TypData, @MyRecord, [tiString, tiInteger], [0]);
  FS := TFileStream.Create('Settings.dat', fmCreate or fmOpenWrite);
  try
    FS.Write(TypData.Data^, TypData.DataSize)
  finally
    FS.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  MyRecord: TMyRecord;
  MS: TMemoryStream;
begin
  MS := TMemoryStream.Create;
  try
    MS.LoadFromFile('Settings.dat');
    ArrayToRecord(@MyRecord, MS.Memory, [tiString, tiInteger], [0]);
    Edit3.Text := MyRecord.Str;
    Edit4.Text := IntToStr(MyRecord.Int);
  finally
    MS.Free;
  end;
end;

end.
