unit hns_fast;
//{$mode objfpc}{$H+}


interface

uses
  Classes, SysUtils, Dialogs, graphics,
  {$ifdef fpc}
  graphtype,
  {$else}
  System.Types, {for tpoint}
  {$endif}
  hns_main;

type

  TFastBitmapPixel = Cardinal;
  (*TFastBitmapPixel = record
    Blue: Byte;
    Green: Byte;
    Red: Byte;
  end;*)
  PFastBitmapPixel = ^TFastBitmapPixel;

  TFastBitmapPixelComponents = packed record
    B, G, R, A: Byte;
  end;

const
  FastPixelSize = SizeOf(TFastBitmapPixel);

type
  { TFastBitmap }

  TFastBitmap = class
  private
    FPixelsData: PByte;
    FSize: TPoint;
    x_min1,x_max1,y_min1,y_max1: integer;{used to define area fastbitmap used}
    function GetPixel(X, Y: Integer): TFastBitmapPixel; inline;
    procedure SetPixel(X, Y: Integer; const AValue: TFastBitmapPixel); inline;
    procedure SetSize(const AValue: TPoint);
  public
    constructor Create;
    destructor Destroy; override;
    property Size: TPoint read FSize write SetSize;
    property x_min: integer read x_min1 write x_min1;
    property y_min: integer read y_min1 write y_min1;
    property x_max: integer read x_max1 write x_max1;
    property y_max: integer read y_max1 write y_max1;
    property Pixels[X, Y: Integer]: TFastBitmapPixel read GetPixel write SetPixel;
    property PixelsData: PByte read FPixelsData;
  end;

procedure clear_FastBitmap(FastBitmap: TFastBitmap; color1: cardinal);{clear fastbitmap}
procedure clear_FastBitmap_selective(FastBitmap: TFastBitmap; color1: cardinal);{clear fastbitmap used part only}
procedure FastBitmapToCanvas(FastBitmap: TFastBitmap; canvas2 :tcanvas);{fastbitmap to canvas,  speed is achieved by writing each pixel only once. Combining is done in fastbitmap}

//procedure FastBitmapToBitmap(FastBitmap: TFastBitmap; Bitmap: TBitmap);{move memory pixel array to bitmap}
//function SwapBRComponent(Value: Cardinal): Cardinal; inline;

implementation

{ TFastBitmap }


function TFastBitmap.GetPixel(X, Y: Integer): TFastBitmapPixel;
begin
  Result := PFastBitmapPixel(FPixelsData + (Y * FSize.X + X) * FastPixelSize)^;
end;

procedure TFastBitmap.SetPixel(X, Y: Integer; const AValue: TFastBitmapPixel);
var
  position1: pbyte;
begin   {note this only recompiles if hns_main code is changed !!!}
  if ((X>=0) and (X<Fsize.x) and (Y>=0) and (Y<Fsize.y)) then {within range}
  begin

    position1:=FPixelsData + (Y * FSize.X + X) * FastPixelSize ;
    if ( (Avalue>colors[0]) and  (Avalue> PFastBitmapPixel(position1)^) or {normal image, sky=black}
         (Avalue<colors[0]) and  (Avalue< PFastBitmapPixel(position1)^) )  {reverse image, sky=white}
      then {update pixel only if avalue is brighter the previous, to preserve stars in FITS image. This will look only to one color but is a simple rule}
      PFastBitmapPixel(position1)^ :=AValue;

    if x<x_min1 then x_min1:=x{minimum x used, determine which area is used of the full screen area}
    else
    if x>x_max1 then x_max1:=x;{maximum x used}

    if y<y_min1 then y_min1:=y {minimum y used}
    else
    if y>y_max1 then y_max1:=y;{maximum y used}
  end;
end;


procedure TFastBitmap.SetSize(const AValue: TPoint);
begin
  if (FSize.X = AValue.X) and (FSize.Y = AValue.X) then Exit;
  FSize := AValue;
  {$ifdef fpc}
  FPixelsData := ReAllocMem(FPixelsData, FSize.X * FSize.Y * FastPixelSize);
  {$else}{delphi}
  ReAllocMem(FPixelsData, FSize.X * FSize.Y * FastPixelSize);
  {$endif}
  x_min1:=fsize.x;{minimum x used}
  x_max1:=0;      {maximum y used}
  y_min1:=fsize.y;
  y_max1:=0;
end;

constructor TFastBitmap.Create;
begin
  Size := Point(0, 0);
end;

destructor TFastBitmap.Destroy;
begin
  FreeMem(FPixelsData);
  inherited Destroy;
end;

procedure clear_FastBitmap(FastBitmap: TFastBitmap; color1: cardinal);{clear fastbitmap}
var
  X, Y: Integer;
begin
  with Fastbitmap do
  begin
    for Y := 0 to Size.Y - 1 do
    begin
      for X := 0 to Size.X - 1 do
      begin
        PFastBitmapPixel(FPixelsData + (Y * FSize.X + X) * FastPixelSize)^ := color1;
      end;
    end;
    x_min:=size.x;{minimum x used}
    x_max:=0;     {maximum x used}
    y_min:=size.y;
    y_max:=0;
  end;
end;

procedure clear_FastBitmap_selective(FastBitmap: TFastBitmap; color1: cardinal);{clear fastbitmap used part only}
var
  X, Y: Integer;
begin
  with Fastbitmap do
  begin
    for Y := y_min to y_max do
    begin
      for X := x_min to x_max do
      begin
        PFastBitmapPixel(FPixelsData + (Y * FSize.X + X) * FastPixelSize)^ := color1;
      end;
    end;
    x_min:=size.x;{minimum x used}
    x_max:=0;     {maximum x used}
    y_min:=size.y;
    y_max:=0;
  end;
end;


procedure FastBitmapToCanvas(FastBitmap: TFastBitmap; canvas2 :tcanvas); {speed is achieved by writing each pixel only once. Combining is done in fastbitmap}
var
  X, Y: Integer;
  background_color: integer;
begin
  background_color:=colors[0];
  with fastbitmap do
  for Y := y_min to y_max do {write only square area of fastbitmap used}
  begin
    for X := x_min to x_max do
    begin
      if Pixels[X, Y]<>background_color  then
      begin
        canvas2.pixels[x,y]:=Pixels[X, Y]; {write to canvas, only in the area used and if different from background color}
      end;
    end;
  end;
end;


//function SwapBRComponent(Value: Cardinal): Cardinal;
//begin
//  Result := (Value and $00ff00) or ((Value shr 16) and $ff) or ((Value and $ff) shl 16);
//  Result := Value;
//  TFastBitmapPixelComponents(Result).R := TFastBitmapPixelComponents(Value).B;
//  TFastBitmapPixelComponents(Result).B := TFastBitmapPixelComponents(Value).R;
//end;

//procedure FastBitmapToBitmap(FastBitmap: TFastBitmap; Bitmap: TBitmap);
//var
//  X, Y: Integer;
//  PixelPtr: PInteger;
//  PixelRowPtr: PInteger;
//  P: TPixelFormat;
//  RawImage: TRawImage;
//  BytePerPixel: Integer;
//begin
//  try
//    Bitmap.BeginUpdate(False);
//    RawImage := Bitmap.RawImage;
//    PixelRowPtr := PInteger(RawImage.Data);
//    BytePerPixel := RawImage.Description.BitsPerPixel div 8;
//    with fastbitmap do
//    for Y := 0 to Size.Y - 1 do begin
//      PixelPtr := PixelRowPtr;
//      for X := 0 to Size.X - 1 do begin

//         // {$ifdef mswindows}
//         // color1:=Pixels[X, Y];
//         // {$else} {unix}
//         // color1:=SwapBRComponent(Pixels[X, Y]);{swap red and blue}
//         // {$endif}


//        PixelPtr^ := PixelPtr^+Pixels[X, Y];{add rather then overwrite}
//        Inc(PByte(PixelPtr), BytePerPixel);
//      end;
//      Inc(PByte(PixelRowPtr), RawImage.Description.BytesPerLine);
//    end;
//  finally
//    Bitmap.EndUpdate(False);
//  end;
//end;



end.

