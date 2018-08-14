{
  uRecord v1.0
    Coded by Agmcz
    Date: 27-12-2017
  Compatible with Delphi Applications Only.
  **************************
  v1.0
    Added TDateTime
  v0.9
    Fixed error.
    Date: 08-11-2016
  v0.8
    Added TRect
  v0.7
    Added TByteDynArray
  v0.6
    Fixed error in TFileTime.
  v0.5:
    Added auto save length dynamic array.
    Fixed error.
  v0.4:
    Added New func ArrayToRecord
  v0.3:
    Added get lenght of dynamic array.
  v0.1 and v0.2:
    Writing...
    func RecordToArray
}

unit uRecord;

interface

uses Windows;

type
  PTypData = ^TTypData;
  TTypData = record
    DataSize: DWORD;
    Data: Pointer;
  end;

var
  tiBuf: array of Byte;
  tiBuf2: array of Byte;
  tiSize: DWORD;
  tiSize2: DWORD;

const
  tiShortInt              = 00;
  tiByte                  = 00;
  tiChar                  = 00;
  tiBoolean               = 00;

  tiWord                  = 01;

  tiInteger               = 02;
  tiDWORD                 = 02;
  tiCardinal              = 02;

  tiInt64                 = 03;

  tiString                = 04;
  tiPChar                 = 04;

  tiWideString            = 05;
  tiPWideChar             = 05;

  tiTFileTime             = 06;

  tiPFileTime             = 07;

  tiTByteDynArray         = 08;

  tiTRect                 = 09;

  tiTDateTime             = 10;
  tiPDateTime             = 11;

  tiShortInt_Array        = 20;
  tiByte_Array            = 20;
  tiChar_Array            = 20;
  tiBoolean_Array         = 20;

  tiWord_Array            = 21;

  tiInteger_Array         = 22;
  tiDWORD_Array           = 22;
  tiCardinal_Array        = 22;

  tiInt64_Array           = 23;

  tiString_Array          = 24;
  tiPChar_Array           = 24;

  tiWideString_Array      = 25;
  tiPWideChar_Array       = 25;

  tiShortInt_Dyn_Array    = 40;
  tiByte_Dyn_Array        = 40;
  tiChar_Dyn_Array        = 40;
  tiBoolean_Dyn_Array     = 40;

  tiWord_Dyn_Array        = 41;

  tiInteger_Dyn_Array     = 42;
  tiDWORD_Dyn_Array       = 42;
  tiCardinal_Dyn_Array    = 42;

  tiInt64_Dyn_Array       = 43;

  tiString_Dyn_Array      = 44;
  tiPChar_Dyn_Array       = 44;

  tiWideString_Dyn_Array  = 45;
  tiPWideChar_Dyn_Array   = 45;
  tiTByteDynArray_Dyn_Array = 46;

  tiSpecial               = 60;

  tiSpecial_Array         = 61;

  tiSpecial_Dyn_Array     = 62;

  tiRecord                = 80;

  tiRecord_Array          = 81;

  tiRecord_Dyn_Array      = 82;

  tiShortInt_Skip         = 90;
  tiByte_Skip             = 90;
  tiChar_Skip             = 90;
  tiBoolean_Skip          = 90;

  tiWord_Skip             = 91;

  tiInteger_Skip          = 92;
  tiDWORD_Skip            = 92;
  tiCardinal_Skip         = 92;

  tiInt64_Skip            = 93;

  tiString_Skip           = 94;
  tiPChar_Skip            = 94;

  tiWideString_Skip       = 95;
  tiPWideChar_Skip        = 95;

  tiTFileTime_Skip        = 96;

  tiPFileTime_Skip        = 97;

  tiTRect_Skip        = 98;

procedure RecordToArray(Dest: PTypData; Source: PByte; const TypInfo: array of Integer; const StaticArrayLength: array of Integer; AutoSaveLength: Boolean = False; FreeOldBuffer: Boolean = True); overload;
procedure RecordToArray(Dest: PTypData; Source: PByte; const TypInfo: array of Integer; const StaticArrayLength: array of Integer; const Record_Special_Info: array of Integer; AutoSaveLength: Boolean = False; FreeOldBuffer: Boolean = True); overload;

procedure ArrayToRecord(Dest: PByte; Source: PByte; const TypInfo: array of Integer; const StaticArrayLength: array of Integer);

implementation

procedure TypToArray(Dest: PTypData; Source: PByte; const TypInfo: Integer; const TypLength: Integer; var IncSrc: DWORD; AutoSaveLength: Boolean = True);
var
  A, G, Len: Integer;
  S: string;
  WS: WideString;
begin
  ZeroMemory(Dest, SizeOf(TTypData));
  SetLength(tiBuf, 0);
  tiSize := 0;
  G := 0;
  Len := 0;
  IncSrc := 0;
  case TypInfo of
    tiByte_Dyn_Array, tiWord_Dyn_Array, tiInteger_Dyn_Array, tiInt64_Dyn_Array, tiString_Dyn_Array, tiWideString_Dyn_Array:
      if  PDWORD(Source)^ <> 0 then
      begin
        Len := PDWORD(PDWORD(Source)^-4)^;
        if AutoSaveLength then
        begin
          SetLength(tiBuf, SizeOf(DWORD));
          CopyMemory(@tiBuf[tiSize], @Len, SizeOf(DWORD));
          Inc(tiSize, SizeOf(DWORD));
        end;
      end
      else
      begin
        if AutoSaveLength then
        begin
          SetLength(tiBuf, SizeOf(DWORD));
          Inc(tiSize, SizeOf(DWORD));
        end;
      end;
  end;
  case TypInfo of
    tiByte:
      begin
        SetLength(tiBuf, SizeOf(Byte));
        CopyMemory(@tiBuf[tiSize], Source, SizeOf(Byte));
        Inc(Source, SizeOf(Byte));
        Inc(tiSize, SizeOf(Byte));
        Inc(IncSrc, SizeOf(Byte));
      end;
    tiWord:
      begin
        SetLength(tiBuf, SizeOf(Word));
        CopyMemory(@tiBuf[tiSize], Source, SizeOf(Word));
        Inc(Source, SizeOf(Word));
        Inc(tiSize, SizeOf(Word));
        Inc(IncSrc, SizeOf(Word));
      end;
    tiInteger:
      begin
        SetLength(tiBuf, SizeOf(Integer));
        CopyMemory(@tiBuf[tiSize], Source, SizeOf(Integer));
        Inc(Source, SizeOf(Integer));
        Inc(tiSize, SizeOf(Integer));
        Inc(IncSrc, SizeOf(Integer));
      end;
    tiInt64:
      begin
        SetLength(tiBuf, SizeOf(Int64));
        CopyMemory(@tiBuf[tiSize], Source, SizeOf(Int64));
        Inc(Source, SizeOf(Int64));
        Inc(tiSize, SizeOf(Int64));
        Inc(IncSrc, SizeOf(Int64));
      end;
    tiString:
      begin
        S := PChar(PDWORD(Source)^);
        SetLength(tiBuf, Length(S) + SizeOf(Byte));
        if Length(S) > 0 then
          CopyMemory(@tiBuf[tiSize], @S[1], Length(S) + SizeOf(Byte));
        Inc(Source, SizeOf(Pointer));
        Inc(tiSize, Length(S) + SizeOf(Byte));
        Inc(IncSrc, SizeOf(Pointer));
      end;
    tiWideString:
      begin
        WS := PWideChar(PDWORD(Source)^);
        SetLength(tiBuf, (Length(WS) + SizeOf(Byte)) * 2);
        if Length(WS) > 0 then
          CopyMemory(@tiBuf[tiSize], @WS[1], (Length(WS) + SizeOf(Byte)) * 2);
        Inc(Source, SizeOf(Pointer));
        Inc(tiSize, (Length(WS) + SizeOf(Byte)) * 2);
        Inc(IncSrc, SizeOf(Pointer));
      end;
      tiTFileTime:
      begin
        SetLength(tiBuf, Length(tiBuf) + SizeOf(TFileTime));
        CopyMemory(@tiBuf[tiSize], Source, SizeOf(TFileTime));
        Inc(Source, SizeOf(TFileTime));
        Inc(tiSize, SizeOf(TFileTime));
        Inc(IncSrc, SizeOf(TFileTime));
      end;
      tiPFileTime:
      begin
        SetLength(tiBuf, Length(tiBuf) + SizeOf(TFileTime));
        CopyMemory(@tiBuf[tiSize], PDWORD(Source), SizeOf(TFileTime));
        Inc(Source, SizeOf(Pointer));
        Inc(tiSize, SizeOf(TFileTime));
        Inc(IncSrc, SizeOf(Pointer));
      end;

      tiTRect:
      begin
        SetLength(tiBuf, Length(tiBuf) + SizeOf(TRect));
        CopyMemory(@tiBuf[tiSize], PDWORD(Source), SizeOf(TRect));
        Inc(Source, SizeOf(TRect));
        Inc(tiSize, SizeOf(TRect));
        Inc(IncSrc, SizeOf(TRect));
      end;

      tiTDateTime:
      begin
        SetLength(tiBuf, Length(tiBuf) + SizeOf(TDateTime));
        CopyMemory(@tiBuf[tiSize], Source, SizeOf(TDateTime));
        Inc(Source, SizeOf(TDateTime));
        Inc(tiSize, SizeOf(TDateTime));
        Inc(IncSrc, SizeOf(TDateTime));
      end;
      tiPDateTime:
      begin
        SetLength(tiBuf, Length(tiBuf) + SizeOf(TDateTime));
        CopyMemory(@tiBuf[tiSize], PDWORD(Source), SizeOf(TDateTime));
        Inc(Source, SizeOf(Pointer));
        Inc(tiSize, SizeOf(TDateTime));
        Inc(IncSrc, SizeOf(Pointer));
      end;


    // Static Array
    tiByte_Array:
      begin
        SetLength(tiBuf, (TypLength * SizeOf(Byte)));
        CopyMemory(@tiBuf[tiSize], Source, (TypLength *SizeOf(Byte)));
        Inc(Source, (TypLength * SizeOf(Byte)));
        Inc(tiSize, (TypLength * SizeOf(Byte)));
        Inc(IncSrc, (TypLength * SizeOf(Byte)));
      end;
    tiWord_Array:
      begin
        SetLength(tiBuf, (TypLength * SizeOf(Word)));
        CopyMemory(@tiBuf[tiSize], Source, (TypLength * SizeOf(Word)));
        Inc(Source, (TypLength * SizeOf(Word)));
        Inc(tiSize, (TypLength * SizeOf(Word)));
        Inc(IncSrc, (TypLength * SizeOf(Word)));
      end;
    tiInteger_Array:
      begin
        SetLength(tiBuf, (TypLength * SizeOf(Integer)));
        CopyMemory(@tiBuf[tiSize], Source, (TypLength * SizeOf(Integer)));
        Inc(Source, (TypLength * SizeOf(Integer)));
        Inc(tiSize, (TypLength * SizeOf(Integer)));
        Inc(IncSrc, (TypLength * SizeOf(Integer)));
      end;
    tiInt64_Array:
      begin
        SetLength(tiBuf, (TypLength * SizeOf(Int64)));
        CopyMemory(@tiBuf[tiSize], Source, (TypLength * SizeOf(Int64)));
        Inc(Source, (TypLength * SizeOf(Int64)));
        Inc(tiSize, (TypLength * SizeOf(Int64)));
        Inc(IncSrc, (TypLength * SizeOf(Int64)));
      end;
    tiString_Array:
      begin
        for A := 0 to TypLength - 1 do
        begin
          S := PChar(PDWORD(Source)^);
          SetLength(tiBuf, Length(tiBuf) + Length(S) + SizeOf(Byte));
          if Length(S) > 0 then
            CopyMemory(@tiBuf[tiSize], @S[1], Length(S) + SizeOf(Byte));
          Inc(Source, SizeOf(Pointer));
          Inc(tiSize, Length(S) +  SizeOf(Byte));
          Inc(IncSrc, SizeOf(Pointer));
        end;
      end;
    tiWideString_Array:
      begin
        for A := 0 to TypLength - 1 do
        begin
          WS := PWideChar(PDWORD(Source)^);
          SetLength(tiBuf, Length(tiBuf) + (Length(WS) + SizeOf(Byte)) * 2);
          if Length(WS) > 0 then
            CopyMemory(@tiBuf[tiSize], @WS[1], (Length(WS) + SizeOf(Byte)) * 2);
          Inc(Source, SizeOf(Pointer));
          Inc(tiSize, (Length(WS) + SizeOf(Byte)) * 2);
          Inc(IncSrc, SizeOf(Pointer));
        end;
      end;

    // Dynamic Array
    tiByte_Dyn_Array:
      begin
        if Len > 0 then
        begin
          SetLength(tiBuf, Length(tiBuf) + (Len * SizeOf(Byte)));
          CopyMemory(@tiBuf[tiSize], PDWORD(PDWORD(Source)^), (Len *SizeOf(Byte)));
          Inc(tiSize, (Len * SizeOf(Byte)));
        end;
        Inc(Source, SizeOf(Pointer));
        Inc(IncSrc, SizeOf(Pointer));
      end;
    tiWord_Dyn_Array:
      begin
        if Len > 0 then
        begin
          SetLength(tiBuf, Length(tiBuf) + (Len * SizeOf(Word)));
          CopyMemory(@tiBuf[tiSize], PDWORD(PDWORD(Source)^), (Len * SizeOf(Word)));
          Inc(tiSize, (Len * SizeOf(Word)));
        end;
        Inc(Source, SizeOf(Pointer));
        Inc(IncSrc, SizeOf(Pointer));
      end;
    tiInteger_Dyn_Array:
      begin
        if Len > 0 then
        begin
          SetLength(tiBuf, Length(tiBuf) + (Len * SizeOf(Integer)));
          CopyMemory(@tiBuf[tiSize], PDWORD(PDWORD(Source)^), (Len * SizeOf(Integer)));
          Inc(tiSize, (Len * SizeOf(Integer)));
        end;
        Inc(Source, SizeOf(Pointer));
        Inc(IncSrc, SizeOf(Pointer));
      end;
    tiInt64_Dyn_Array:
      begin
        if Len > 0 then
        begin
          SetLength(tiBuf, Length(tiBuf) + (Len * SizeOf(Int64)));
          CopyMemory(@tiBuf[tiSize], PDWORD(PDWORD(Source)^), (Len * SizeOf(Int64)));
          Inc(tiSize, (Len * SizeOf(Int64)));
        end;
        Inc(Source, SizeOf(Pointer));
        Inc(IncSrc, SizeOf(Pointer));
      end;
    tiString_Dyn_Array:
      begin
        for A := 0 to Len - 1 do
        begin
          S := PChar(PDWORD(PDWORD(Source)^ + G)^);
          SetLength(tiBuf, Length(tiBuf) + Length(S) + SizeOf(Byte));
          if Length(S) > 0 then
            CopyMemory(@tiBuf[tiSize], @S[1], Length(S) + SizeOf(Byte));
          Inc(G, SizeOf(Pointer));
          Inc(tiSize, Length(S) +  SizeOf(Byte));
        end;
        Inc(Source, SizeOf(Pointer));
        Inc(IncSrc, SizeOf(Pointer));
      end;
    tiWideString_Dyn_Array:
      begin
        for A := 0 to Len - 1 do
        begin
          WS := PWideChar(PDWORD(PDWORD(Source)^ + G)^);
          SetLength(tiBuf, Length(tiBuf) + (Length(WS) + SizeOf(Byte)) * 2);
          if Length(WS) > 0 then
            CopyMemory(@tiBuf[tiSize], @WS[1], (Length(WS) + SizeOf(Byte)) * 2);
          Inc(G, SizeOf(Pointer));
          Inc(tiSize, (Length(WS) + SizeOf(Byte)) * 2);
        end;
        Inc(Source, SizeOf(Pointer));
        Inc(IncSrc, SizeOf(Pointer));
      end;

    // Skip
    tiByte_Skip:
      begin
        Inc(Source, SizeOf(Byte));
        Inc(IncSrc, SizeOf(Byte));
      end;
    tiWord_Skip:
      begin
        Inc(Source, SizeOf(Word));
        Inc(IncSrc, SizeOf(Word));
      end;
    tiInteger_Skip:
      begin
        Inc(Source, SizeOf(Integer));
        Inc(IncSrc, SizeOf(Integer));
      end;
    tiInt64_Skip:
      begin
        Inc(Source, SizeOf(Int64));
        Inc(IncSrc, SizeOf(Int64));
      end;
    tiString_Skip:
      begin
        Inc(Source, SizeOf(Pointer));
        Inc(IncSrc, SizeOf(Pointer));
      end;
    tiWideString_Skip:
      begin
        Inc(Source, SizeOf(Pointer));
        Inc(IncSrc, SizeOf(Pointer));
      end;
    tiTFileTime_Skip:
      begin
        Inc(Source, SizeOf(TFileTime));
        Inc(IncSrc, SizeOf(TFileTime));
      end;
     tiPFileTime_Skip:
      begin
        Inc(Source, SizeOf(Pointer));
        Inc(IncSrc, SizeOf(Pointer));
      end;
     tiTRect_Skip:
      begin
        Inc(Source, SizeOf(TRect));
        Inc(IncSrc, SizeOf(TRect));
      end;

  end;
  if tiSize > 0 then
  begin
    Dest^.DataSize := tiSize;
    //Dest^.Data := tiBuf;
    Dest^.Data := @tiBuf[0];
  end;
end;

procedure RecordToArray(Dest: PTypData; Source: PByte; const TypInfo: array of Integer; const StaticArrayLength: array of Integer; AutoSaveLength: Boolean = False; FreeOldBuffer: Boolean = True);
var
  I, A, G, M, Len, Len2: Integer;
  S: string;
  WS: WideString;
begin
  ZeroMemory(Dest, SizeOf(TTypData));
  if FreeOldBuffer then
  begin
    SetLength(tiBuf, 0);
    tiSize := 0;
  end;
  M := 0;
  for I := Low(TypInfo) to High(TypInfo) do
  begin
    G := 0;
    Len := 0;
    Len2 := 0;
    case TypInfo[I] of
      tiByte_Dyn_Array, tiWord_Dyn_Array, tiInteger_Dyn_Array, tiInt64_Dyn_Array, tiString_Dyn_Array, tiWideString_Dyn_Array, tiTByteDynArray_Dyn_Array:
      if  PDWORD(Source)^ <> 0 then
      begin
        Len := PDWORD(PDWORD(Source)^-4)^;
        if AutoSaveLength then
        begin
          SetLength(tiBuf, Length(tiBuf) + SizeOf(DWORD));
          CopyMemory(@tiBuf[tiSize], @Len, SizeOf(DWORD));
          Inc(tiSize, SizeOf(DWORD));
        end;
      end
      else
      begin
        if AutoSaveLength then
        begin
          SetLength(tiBuf, Length(tiBuf) + SizeOf(DWORD));
          Inc(tiSize, SizeOf(DWORD));
        end;
      end;
    end;
    case TypInfo[I] of
      tiByte:
      begin
        SetLength(tiBuf, Length(tiBuf) + SizeOf(Byte));
        CopyMemory(@tiBuf[tiSize], Source, SizeOf(Byte));
        Inc(Source, SizeOf(Byte));
        Inc(tiSize, SizeOf(Byte));
      end;
      tiWord:
      begin
        SetLength(tiBuf, Length(tiBuf) + SizeOf(Word));
        CopyMemory(@tiBuf[tiSize], Source, SizeOf(Word));
        Inc(Source, SizeOf(Word));
        Inc(tiSize, SizeOf(Word));
      end;
      tiInteger:
      begin
        SetLength(tiBuf, Length(tiBuf) + SizeOf(Integer));
        CopyMemory(@tiBuf[tiSize], Source, SizeOf(Integer));
        Inc(Source, SizeOf(Integer));
        Inc(tiSize, SizeOf(Integer));
      end;
      tiInt64:
      begin
        SetLength(tiBuf, Length(tiBuf) + SizeOf(Int64));
        CopyMemory(@tiBuf[tiSize], Source, SizeOf(Int64));
        Inc(Source, SizeOf(Int64));
        Inc(tiSize, SizeOf(Int64));
      end;
      tiString:
      begin
        S := PChar(PDWORD(Source)^);
        SetLength(tiBuf, Length(tiBuf) + Length(S) + SizeOf(Byte));
        if Length(S) > 0 then
          CopyMemory(@tiBuf[tiSize], @S[1], Length(S) + SizeOf(Byte));
        Inc(Source, SizeOf(Pointer));
        Inc(tiSize, Length(S) + SizeOf(Byte));
      end;
      tiWideString:
      begin
        WS := PWideChar(PDWORD(Source)^);
        SetLength(tiBuf, Length(tiBuf) + (Length(WS) + SizeOf(Byte)) * 2);
        if Length(WS) > 0 then
          CopyMemory(@tiBuf[tiSize], @WS[1], (Length(WS) + SizeOf(Byte)) * 2);
         Inc(Source, SizeOf(Pointer));
        Inc(tiSize, (Length(WS) + SizeOf(Byte)) * 2);
      end;

      tiTFileTime:
      begin
        SetLength(tiBuf, Length(tiBuf) + SizeOf(TFileTime));
        CopyMemory(@tiBuf[tiSize], Source, SizeOf(TFileTime));
        Inc(Source, SizeOf(TFileTime));
        Inc(tiSize, SizeOf(TFileTime));
      end;

      tiPFileTime:
      begin
        SetLength(tiBuf, Length(tiBuf) + SizeOf(TFileTime));
        CopyMemory(@tiBuf[tiSize], PDWORD(Source), SizeOf(TFileTime));
        Inc(Source, SizeOf(Pointer));
        Inc(tiSize, SizeOf(TFileTime));
      end;

      tiTRect:
      begin
        SetLength(tiBuf, Length(tiBuf) + SizeOf(TRect));
        CopyMemory(@tiBuf[tiSize], PDWORD(Source), SizeOf(TRect));
        Inc(Source, SizeOf(TRect));
        Inc(tiSize, SizeOf(TRect));
      end;

      tiTDateTime:
      begin
        SetLength(tiBuf, Length(tiBuf) + SizeOf(TDateTime));
        CopyMemory(@tiBuf[tiSize], Source, SizeOf(TDateTime));
        Inc(Source, SizeOf(TDateTime));
        Inc(tiSize, SizeOf(TDateTime));
      end;

      tiPDateTime:
      begin
        SetLength(tiBuf, Length(tiBuf) + SizeOf(TDateTime));
        CopyMemory(@tiBuf[tiSize], PDWORD(Source), SizeOf(TDateTime));
        Inc(Source, SizeOf(Pointer));
        Inc(tiSize, SizeOf(TDateTime));
      end;

      // Static Array
      tiByte_Array:
      begin
        SetLength(tiBuf, Length(tiBuf) + (StaticArrayLength[M] * SizeOf(Byte)));
        CopyMemory(@tiBuf[tiSize], Source, (StaticArrayLength[M] *SizeOf(Byte)));
        Inc(Source, (StaticArrayLength[M] * SizeOf(Byte)));
        Inc(tiSize, (StaticArrayLength[M] * SizeOf(Byte)));
      end;
      tiWord_Array:
      begin
        SetLength(tiBuf, Length(tiBuf) + (StaticArrayLength[M] * SizeOf(Word)));
        CopyMemory(@tiBuf[tiSize], Source, (StaticArrayLength[M] * SizeOf(Word)));
        Inc(Source, (StaticArrayLength[M] * SizeOf(Word)));
        Inc(tiSize, (StaticArrayLength[M] * SizeOf(Word)));
      end;
      tiInteger_Array:
      begin
        SetLength(tiBuf, Length(tiBuf) + (StaticArrayLength[M] * SizeOf(Integer)));
        CopyMemory(@tiBuf[tiSize], Source, (StaticArrayLength[M] * SizeOf(Integer)));
        Inc(Source, (StaticArrayLength[M] *SizeOf(Integer)));
        Inc(tiSize, (StaticArrayLength[M] * SizeOf(Integer)));
      end;
      tiInt64_Array:
      begin
        SetLength(tiBuf, Length(tiBuf) + (StaticArrayLength[M] * SizeOf(Int64)));
        CopyMemory(@tiBuf[tiSize], Source, (StaticArrayLength[M] * SizeOf(Int64)));
        Inc(Source, (StaticArrayLength[M] * SizeOf(Int64)));
        Inc(tiSize, (StaticArrayLength[M] * SizeOf(Int64)));
      end;
      tiString_Array:
      begin
        for A := 0 to StaticArrayLength[M] - 1 do
        begin
          S := PChar(PDWORD(Source)^);
          SetLength(tiBuf, Length(tiBuf) + Length(S) + SizeOf(Byte));
          if Length(S) > 0 then
            CopyMemory(@tiBuf[tiSize], @S[1], Length(S) + SizeOf(Byte));
          Inc(Source, SizeOf(Pointer));
          Inc(tiSize, Length(S) +  SizeOf(Byte));
        end;
      end;
      tiWideString_Array:
      begin
        for A := 0 to StaticArrayLength[M] - 1 do
        begin
          WS := PWideChar(PDWORD(Source)^);
          SetLength(tiBuf, Length(tiBuf) + (Length(WS) + SizeOf(Byte)) * 2);
          if Length(WS) > 0 then
            CopyMemory(@tiBuf[tiSize], @WS[1], (Length(WS) + SizeOf(Byte)) * 2);
          Inc(Source, SizeOf(Pointer));
          Inc(tiSize, (Length(WS) + SizeOf(Byte)) * 2);
        end;
      end;

      // Dynamic Array
      tiByte_Dyn_Array:
      begin
        if Len > 0 then
        begin
          SetLength(tiBuf, Length(tiBuf) + (Len * SizeOf(Byte)));
          CopyMemory(@tiBuf[tiSize], PDWORD(PDWORD(Source)^), (Len *SizeOf(Byte)));
          Inc(tiSize, (Len * SizeOf(Byte)));
        end;
        Inc(Source, SizeOf(Pointer));
      end;
      tiWord_Dyn_Array:
      begin
        if Len > 0 then
        begin
          SetLength(tiBuf, Length(tiBuf) + (Len * SizeOf(Word)));
          CopyMemory(@tiBuf[tiSize], PDWORD(PDWORD(Source)^), (Len * SizeOf(Word)));
          Inc(tiSize, (Len * SizeOf(Word)));
        end;
        Inc(Source, SizeOf(Pointer));
      end;
      tiInteger_Dyn_Array:
      begin
        if Len > 0 then
        begin
          SetLength(tiBuf, Length(tiBuf) + (Len * SizeOf(Integer)));
          CopyMemory(@tiBuf[tiSize], PDWORD(PDWORD(Source)^), (Len * SizeOf(Integer)));
          Inc(tiSize, (Len * SizeOf(Integer)));
        end;
        Inc(Source, SizeOf(Pointer));
      end;
      tiInt64_Dyn_Array:
      begin
        if Len > 0 then
        begin
          SetLength(tiBuf, Length(tiBuf) + (Len * SizeOf(Int64)));
          CopyMemory(@tiBuf[tiSize], PDWORD(PDWORD(Source)^), (Len * SizeOf(Int64)));
          Inc(tiSize, (Len * SizeOf(Int64)));
        end;
        Inc(Source, SizeOf(Pointer));
      end;
      tiString_Dyn_Array:
      begin
        for A := 0 to Len - 1 do
        begin
          S := PChar(PDWORD(PDWORD(Source)^ + G)^);
          SetLength(tiBuf, Length(tiBuf) + Length(S) + SizeOf(Byte));
          if Length(S) > 0 then
            CopyMemory(@tiBuf[tiSize], @S[1], Length(S) + SizeOf(Byte));
          Inc(G, SizeOf(Pointer));
          Inc(tiSize, Length(S) +  SizeOf(Byte));
        end;
        Inc(Source, SizeOf(Pointer));
      end;
      tiWideString_Dyn_Array:
      begin
        for A := 0 to Len - 1 do
        begin
          WS := PWideChar(PDWORD(PDWORD(Source)^ + G)^);
          SetLength(tiBuf, Length(tiBuf) + (Length(WS) + SizeOf(Byte)) * 2);
          if Length(WS) > 0 then
            CopyMemory(@tiBuf[tiSize], @WS[1], (Length(WS) + SizeOf(Byte)) * 2);
          Inc(G, SizeOf(Pointer));
          Inc(tiSize, (Length(WS) + SizeOf(Byte)) * 2);
        end;
        Inc(Source, SizeOf(Pointer));
      end;

    // Skip
    tiByte_Skip:
      begin
        Inc(Source, SizeOf(Byte));
      end;
    tiWord_Skip:
      begin
        Inc(Source, SizeOf(Word));
      end;
    tiInteger_Skip:
      begin
        Inc(Source, SizeOf(Integer));
      end;
    tiInt64_Skip:
      begin
        Inc(Source, SizeOf(Int64));
      end;
    tiString_Skip:
      begin
        Inc(Source, SizeOf(Pointer));
      end;
    tiWideString_Skip:
      begin
        Inc(Source, SizeOf(Pointer));
      end;
      tiTFileTime_Skip:
      begin
        Inc(Source, SizeOf(TFileTime));
      end;
       tiPFileTime_Skip:
      begin
        Inc(Source, SizeOf(Pointer));
      end;
       tiTRect_Skip:
      begin
        Inc(Source, SizeOf(TRect));
      end;

      tiTByteDynArray_Dyn_Array:
      begin
        for A := 0 to Len - 1 do
        begin
          if  PDWORD(PDWORD(Source)^ + G)^ <> 0 then
          begin
            Len2 := PDWORD(PDWORD(PDWORD(Source)^ + G)^-4)^;
            if AutoSaveLength then
            begin
              SetLength(tiBuf, Length(tiBuf) + SizeOf(DWORD));
              CopyMemory(@tiBuf[tiSize], @Len2, SizeOf(DWORD));
              Inc(tiSize, SizeOf(DWORD));
            end;
            if Len2 > 0 then
            begin
              SetLength(tiBuf, Length(tiBuf) + (Len2 * SizeOf(Byte)));
              CopyMemory(@tiBuf[tiSize], PDWORD(PDWORD(PDWORD(Source)^ + G)^), (Len2 * SizeOf(Byte)));
              Inc(tiSize, (Len2 * SizeOf(Byte)));
            end;
          end
          else
          begin
            if AutoSaveLength then
            begin
              SetLength(tiBuf, Length(tiBuf) + SizeOf(DWORD));
              Inc(tiSize, SizeOf(DWORD));
            end;
          end;
          Inc(G, SizeOf(Pointer));
        end;
        Inc(Source, SizeOf(Pointer));
      end;
    end;

    case TypInfo[I] of
      tiByte_Array, tiWord_Array, tiInteger_Array, tiInt64_Array, tiString_Array, tiWideString_Array: Inc(M);
    end;
  end;
  if tiSize > 0 then
  begin
    Dest^.DataSize := tiSize;
    //Dest^.Data := tiBuf;
    Dest^.Data := @tiBuf[0];
  end;
end;

procedure RecordToArray(Dest: PTypData; Source: PByte; const TypInfo: array of Integer; const StaticArrayLength: array of Integer; const Record_Special_Info: array of Integer; AutoSaveLength: Boolean = False; FreeOldBuffer: Boolean = True);
var
  I, A, G, M, X, Len: Integer;
  IncSrc: DWORD;
begin
  ZeroMemory(Dest, SizeOf(TTypData));
  if FreeOldBuffer then
  begin
    SetLength(tiBuf2, 0);
    tiSize2 := 0;
  end;
  I := 0;
  M := 0;
  while I < Length(TypInfo) do
  begin
    Len := 0;
    case TypInfo[I] of
      tiRecord:
      begin
        for X := 0 to Record_Special_Info[M] - 1 do
        begin
          TypToArray(Dest, Source, TypInfo[I + Succ(X)], StaticArrayLength[I + Succ(X)], IncSrc, AutoSaveLength);
          if Dest.DataSize > 0 then
          begin
            SetLength(tiBuf2, Length(tiBuf2) + Dest.DataSize);
            CopyMemory(@tiBuf2[tiSize2], Dest.Data, Dest.DataSize);
            Inc(Source, IncSrc);
            Inc(tiSize2, Dest.DataSize);
          end;
        end;
      end;
      tiRecord_Array:
      begin
        for A := 0 to StaticArrayLength[I] - 1 do
        begin
          for X := 0 to Record_Special_Info[M] - 1 do
          begin
            TypToArray(Dest, Source, TypInfo[I + Succ(X)], StaticArrayLength[I + Succ(X)], IncSrc, AutoSaveLength);
            if Dest.DataSize > 0 then
            begin
              SetLength(tiBuf2, Length(tiBuf2) + Dest.DataSize);
              CopyMemory(@tiBuf2[tiSize2], Dest.Data, Dest.DataSize);
              Inc(Source, IncSrc);
              Inc(tiSize2, Dest.DataSize);
            end;
          end;
        end;
        Inc(I, Record_Special_Info[M]);
        Inc(M);
      end;
      tiRecord_Dyn_Array:
      begin
        if  PDWORD(Source)^ <> 0 then
        begin
          Len := PDWORD(PDWORD(Source)^-4)^;
          G := 0;
          for A := 0 to Len - 1 do
          begin
            for X := 0 to Record_Special_Info[M] - 1 do
            begin
              TypToArray(Dest, PByte(PDWORD(Source)^ + G), TypInfo[I + Succ(X)], StaticArrayLength[I + Succ(X)], IncSrc, AutoSaveLength);
              if Dest.DataSize > 0 then
              begin
                SetLength(tiBuf2, Length(tiBuf2) + Dest.DataSize);
                CopyMemory(@tiBuf2[tiSize2], Dest.Data, Dest.DataSize);
                Inc(G, IncSrc);
                Inc(tiSize2, Dest.DataSize);
              end;
            end;
          end;
        end;
        Inc(Source, SizeOf(Pointer));
        Inc(I, Record_Special_Info[M]);
        Inc(M);
      end;
    else
      TypToArray(Dest, Source, TypInfo[I], StaticArrayLength[M], IncSrc, AutoSaveLength);
      if Dest^.DataSize > 0 then
      begin
        SetLength(tiBuf2, Length(tiBuf2) + Dest.DataSize);
        CopyMemory(@tiBuf2[tiSize2], Dest.Data, Dest.DataSize);
        Inc(tiSize2, Dest.DataSize);
      end;
      Inc(Source, IncSrc);
      case TypInfo[I] of
        tiByte_Array, tiWord_Array, tiInteger_Array, tiInt64_Array, tiString_Array, tiWideString_Array: Inc(M);
      end;
    end;
    Inc(I);
  end;
  if tiSize2 > 0 then
  begin
    Dest^.DataSize := tiSize2;
    //Dest^.Data := tiBuf2;
    Dest^.Data := @tiBuf2[0];
  end;
end;

type
  PByteArray = ^TByteArray;
  TByteArray = array of Byte;

type
  PWordArray = ^TWordArray;
  TWordArray = array of Word;

type
  PDWORDArray = ^TDWORDArray;
  TDWORDArray = array of DWORD;

type
  PInt64Array = ^TInt64Array;
  TInt64Array = array of Int64;

type
  PStringArray = ^TStringArray;
  TStringArray = array of String;

type
  PWideStringArray = ^TWideStringArray;
  TWideStringArray = array of WideString;

procedure ArrayToRecord(Dest: PByte; Source: PByte; const TypInfo: array of Integer; const StaticArrayLength: array of Integer);
var
  I, A, G, M, Len: Integer;
  S: string;
  WS: WideString;
begin
  M := 0;
  for I := Low(TypInfo) to High(TypInfo) do
  begin
    G := 0;
    Len := 0;
    case TypInfo[I] of
      tiByte:
      begin
        CopyMemory(Dest, Source, SizeOf(Byte));
        Inc(Source, SizeOf(Byte));
        Inc(Dest, SizeOf(Byte));
      end;
      tiWord:
      begin
        CopyMemory(Dest, Source, SizeOf(Word));
        Inc(Source, SizeOf(Word));
        Inc(Dest, SizeOf(Word));
      end;
      tiInteger:
      begin
        CopyMemory(Dest, Source, SizeOf(Integer));
        Inc(Source, SizeOf(Integer));
        Inc(Dest, SizeOf(Integer));
      end;
      tiInt64:
      begin
        CopyMemory(Dest, Source, SizeOf(Int64));
        Inc(Source, SizeOf(Int64));
        Inc(Dest, SizeOf(Int64));
      end;
      tiString:
      begin
        S := PChar(Source);
        if Length(S) > 0 then
        begin
          SetLength(String(PDWORD(Dest)^), Length(S));
          CopyMemory(PString(PDWORD(Dest)^), @S[1], Length(S));
        end;
        Inc(Source, Length(S) + SizeOf(Byte));
        Inc(Dest, SizeOf(Pointer));
      end;
      tiWideString:
      begin
        WS := PWideChar(Source);
        if Length(WS) > 0 then
        begin
          SetLength(WideString(PDWORD(Dest)^), Length(WS));
          CopyMemory(PWideString(PDWORD(Dest)^), @WS[1], Length(WS) * 2);
        end;
        Inc(Source, (Length(WS) + SizeOf(Byte)) * 2);
        Inc(Dest, SizeOf(Pointer));
      end;

      tiTFileTime:
      begin
        CopyMemory(Dest, Source, SizeOf(TFileTime));
        Inc(Source, SizeOf(TFileTime));
        Inc(Dest, SizeOf(TFileTime));
      end;

      tiPFileTime:
      begin
        CopyMemory(PFileTime(PDWORD(Dest)^), Source, SizeOf(TFileTime));
        Inc(Source, SizeOf(TFileTime));
        Inc(Dest, SizeOf(Pointer));
      end;

      tiTRect:
      begin
        CopyMemory(Dest, Source, SizeOf(TRect));
        Inc(Source, SizeOf(TRect));
        Inc(Dest, SizeOf(TRect));
      end;

      tiTDateTime:
      begin
        CopyMemory(Dest, Source, SizeOf(TDateTime));
        Inc(Source, SizeOf(TDateTime));
        Inc(Dest, SizeOf(TDateTime));
      end;

      tiPDateTime:
      begin
        CopyMemory(PFileTime(PDWORD(Dest)^), Source, SizeOf(TDateTime));
        Inc(Source, SizeOf(TDateTime));
        Inc(Dest, SizeOf(Pointer));
      end;

      // Static Array
      tiByte_Array:
      begin
        CopyMemory(Dest, Source, (StaticArrayLength[M] * SizeOf(Byte)));
        Inc(Source, (StaticArrayLength[M] * SizeOf(Byte)));
        Inc(Dest, (StaticArrayLength[M] * SizeOf(Byte)));
      end;
      tiWord_Array:
      begin
        CopyMemory(Dest, Source, (StaticArrayLength[M] * SizeOf(Word)));
        Inc(Source, (StaticArrayLength[M] * SizeOf(Word)));
        Inc(Dest, (StaticArrayLength[M] * SizeOf(Word)));
      end;
      tiInteger_Array:
      begin
        CopyMemory(Dest, Source, (StaticArrayLength[M] * SizeOf(Integer)));
        Inc(Source, (StaticArrayLength[M] *SizeOf(Integer)));
        Inc(tiSize, (StaticArrayLength[M] * SizeOf(Integer)));
      end;
      tiInt64_Array:
      begin
        CopyMemory(Dest, Source, (StaticArrayLength[M] * SizeOf(Int64)));
        Inc(Source, (StaticArrayLength[M] * SizeOf(Int64)));
        Inc(Dest, (StaticArrayLength[M] * SizeOf(Int64)));
      end;
      tiString_Array:
      begin
        for A := 0 to StaticArrayLength[M] - 1 do
        begin
          S := PChar(Source);
          if Length(S) > 0 then
          begin
            SetLength(String(PDWORD(Dest)^), Length(S));
            CopyMemory(PString(PDWORD(Dest)^), @S[1], Length(S));
          end;
          Inc(Source, Length(S) +  SizeOf(Byte));
          Inc(Dest, SizeOf(Pointer));
        end;
      end;
      tiWideString_Array:
      begin
        for A := 0 to StaticArrayLength[M] - 1 do
        begin
          WS := PWideChar(Source);
          if Length(WS) > 0 then
          begin
            SetLength(WideString(PDWORD(Dest)^), Length(WS));
            CopyMemory(PWideString(PDWORD(Dest)^), @WS[1], Length(WS) * 2);
          end;
          Inc(Source, (Length(WS) + SizeOf(Byte)) * 2);
          Inc(Dest, SizeOf(Pointer));
        end;
      end;

      // Dynamic Array
      tiByte_Dyn_Array:
      begin
        CopyMemory(@Len, Source, SizeOf(DWORD));
        Inc(Source, SizeOf(DWORD));
        if Len > 0 then
        begin
          SetLength(PByteArray(PDWORD(Dest))^, Len);
          CopyMemory(PDWORD(PDWORD(Dest)^), Source, (Len * SizeOf(Byte)));
          Inc(Source, Len * SizeOf(Byte));
        end;
        Inc(Dest, SizeOf(Pointer));
      end;
      tiWord_Dyn_Array:
      begin
        CopyMemory(@Len, Source, SizeOf(DWORD));
        Inc(Source, SizeOf(DWORD));
        if Len > 0 then
        begin
          SetLength(PWordArray(PDWORD(Dest))^, Len);
          CopyMemory(PDWORD(PDWORD(Dest)^), Source, (Len * SizeOf(Word)));
          Inc(Source, Len * SizeOf(Word));
        end;
        Inc(Dest, SizeOf(Pointer));
      end;
      tiInteger_Dyn_Array:
      begin
        CopyMemory(@Len, Source, SizeOf(DWORD));
        Inc(Source, SizeOf(DWORD));
        if Len > 0 then
        begin
          SetLength(PDWORDArray(PDWORD(Dest))^, Len);
          CopyMemory(PDWORD(PDWORD(Dest)^), Source, (Len * SizeOf(DWORD)));
          Inc(Source, Len * SizeOf(DWORD));
        end;
        Inc(Dest, SizeOf(Pointer));
      end;
      tiInt64_Dyn_Array:
      begin
        CopyMemory(@Len, Source, SizeOf(DWORD));
        Inc(Source, SizeOf(DWORD));
        if Len > 0 then
        begin
          SetLength(PInt64Array(PDWORD(Dest))^, Len);
          CopyMemory(PDWORD(PDWORD(Dest)^), Source, (Len * SizeOf(Int64)));
          Inc(Source, Len * SizeOf(Int64));
        end;
        Inc(Dest, SizeOf(Pointer));
      end;
      tiString_Dyn_Array:
      begin
        CopyMemory(@Len, Source, SizeOf(DWORD));
        Inc(Source, SizeOf(DWORD));
        if Len > 0 then
          SetLength(PStringArray(PDWORD(Dest))^, Len);
        for A := 0 to Len - 1 do
        begin
          S := PChar(Source);
          if Length(S) > 0 then
          begin
            SetLength(String(PDWORD(PDWORD(Dest)^ + G)^), Length(S));
            CopyMemory(PString(PDWORD(PDWORD(Dest)^ + G)^), @S[1], Length(S));
          end;
          Inc(G, SizeOf(Pointer));
          Inc(Source, Length(S) +  SizeOf(Byte));
        end;
        Inc(Dest, SizeOf(Pointer));
      end;
      tiWideString_Dyn_Array:
      begin
        CopyMemory(@Len, Source, SizeOf(DWORD));
        Inc(Source, SizeOf(DWORD));
        if Len > 0 then
          SetLength(PWideStringArray(PDWORD(Dest))^, Len);
        for A := 0 to Len - 1 do
        begin
          WS := PWideChar(Source);
          if Length(WS) > 0 then
          begin
            SetLength(WideString(PDWORD(PDWORD(Dest)^ + G)^), Length(WS));
            CopyMemory(PWideString(PDWORD(PDWORD(Dest)^ + G)^), @WS[1], Length(WS) * 2);
          end;
          Inc(G, SizeOf(Pointer));
          Inc(Source, (Length(WS) + SizeOf(Byte)) * 2);
        end;
        Inc(Dest, SizeOf(Pointer));
      end;

    // Skiped
    tiByte_Skip:
      begin
        Inc(Dest, SizeOf(Byte));
      end;
    tiWord_Skip:
      begin
        Inc(Dest, SizeOf(Word));
      end;
    tiInteger_Skip:
      begin
        Inc(Dest, SizeOf(Integer));
      end;
    tiInt64_Skip:
      begin
        Inc(Dest, SizeOf(Int64));
      end;
    tiString_Skip:
      begin
        Inc(Dest, SizeOf(Pointer));
      end;
    tiWideString_Skip:
      begin
        Inc(Dest, SizeOf(Pointer));
      end;
      tiTFileTime_Skip:
      begin
        Inc(Dest, SizeOf(TFileTime));
      end;
      tiPFileTime_Skip:
      begin
        Inc(Dest, SizeOf(Pointer));
      end;
      tiTRect_Skip:
      begin
        Inc(Dest, SizeOf(TRect));
      end;
    end;
    case TypInfo[I] of
      tiByte_Array, tiWord_Array, tiInteger_Array, tiInt64_Array, tiString_Array, tiWideString_Array: Inc(M);
    end;
  end;
end;


initialization
  
finalization
  SetLength(tiBuf, 0);
  SetLength(tiBuf2, 0);

end.
