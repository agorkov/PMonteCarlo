unit UFMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, ExtCtrls, StdCtrls;

type
  TFMain = class(TForm)
    VLECoordinates: TValueListEditor;
    BDraw: TButton;
    Image: TImage;
    LETestCount: TLabeledEdit;
    BStartTest: TButton;
    Label1: TLabel;
    BStartTest2: TButton;
    Label2: TLabel;
    CBShow: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure BDrawClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ImageClick(Sender: TObject);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BStartTestClick(Sender: TObject);
    procedure BStartTest2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}
var
maxx,minx,maxy,miny,posx,posy: integer;
fl: boolean;

procedure Fill(posx,posy: integer);
begin
  FMain.Image.Canvas.Pixels[posx,posy]:=clGreen;

  if FMain.Image.Canvas.Pixels[posx+1,posy]=clWhite then
    Fill(posx+1,posy);
  if FMain.Image.Canvas.Pixels[posx-1,posy]=clWhite then
    Fill(posx-1,posy);
  if FMain.Image.Canvas.Pixels[posx,posy+1]=clWhite then
    Fill(posx,posy+1);
  if FMain.Image.Canvas.Pixels[posx,posy-1]=clWhite then
    Fill(posx,posy-1);
end;

procedure TFMain.BDrawClick(Sender: TObject);
var
i: word;
x,y: integer;
begin

  maxx:=strtoint(VLECoordinates.Cells[0,1]);
  minx:=strtoint(VLECoordinates.Cells[0,1]);
  maxy:=strtoint(VLECoordinates.Cells[1,1]);
  miny:=strtoint(VLECoordinates.Cells[1,1]);
  for i:=2 to VLECoordinates.RowCount-1 do
  begin
    x:=strtoint(VLECoordinates.Cells[0,i]);
    if x>maxx then
      maxx:=x;
    if x<minx then
      minx:=x;

    y:=strtoint(VLECoordinates.Cells[1,i]);
    if y>maxy then
      maxy:=y;
    if y<miny then
      miny:=y;
  end;

  Image.Canvas.Pen.Color:=clBlack;
  Image.Canvas.Rectangle(0,0,Image.Width,Image.Height);
  Image.Canvas.Pen.Color:=clRed;
  Image.Canvas.Rectangle(minx,200-miny,maxx,200-maxy);

  Image.Canvas.Pen.Color:=clBlack;
  x:=strtoint(VLECoordinates.Cells[0,1]);
  y:=200-strtoint(VLECoordinates.Cells[1,1]);
  Image.Canvas.MoveTo(x,y);
  for i:=2 to VLECoordinates.RowCount-1 do
  begin
    x:=strtoint(VLECoordinates.Cells[0,i]);
    y:=200-strtoint(VLECoordinates.Cells[1,i]);
    Image.Canvas.LineTo(x,y);
  end;
  x:=strtoint(VLECoordinates.Cells[0,1]);
  y:=200-strtoint(VLECoordinates.Cells[1,1]);
  Image.Canvas.LineTo(x,y);

  if not fl then
    ShowMessage('ўелкните мышкой внутри нарисованной фигуры')
  else
    Fill(posx,posy);

  BStartTest.Enabled:=true;
  BStartTest2.Enabled:=true;
end;


procedure TFMain.BStartTest2Click(Sender: TObject);
  function PointIn(x,y: integer): boolean;
    function Intersection(ax1,ay1,ax2,ay2,bx1,by1,bx2,by2: integer):boolean;
    var v1,v2,v3,v4:real;
    begin
      v1:=(bx2-bx1)*(ay1-by1)-(by2-by1)*(ax1-bx1);
      v2:=(bx2-bx1)*(ay2-by1)-(by2-by1)*(ax2-bx1);
      v3:=(ax2-ax1)*(by1-ay1)-(ay2-ay1)*(bx1-ax1);
      v4:=(ax2-ax1)*(by2-ay1)-(ay2-ay1)*(bx2-ax1);
      Intersection:=(v1*v2<0) and (v3*v4<0);
    end;
  var
  i: word;
  fl: boolean;
  ax1,ay1,ax2,ay2,bx1,by1,bx2,by2: integer;
  begin
    fl:=false;
    bx1:=x; by1:=y; bx2:=maxx; by2:=y;
    for i:=1 to VLECoordinates.RowCount-1 do
    begin
      ax1:=strtoint(VLECoordinates.Cells[0,i]);
      ay1:=strtoint(VLECoordinates.Cells[1,i]);
      if i=VLECoordinates.RowCount-1 then
      begin
        ax2:=strtoint(VLECoordinates.Cells[0,1]);
        ay2:=strtoint(VLECoordinates.Cells[1,1]);
      end
      else
      begin
        ax2:=strtoint(VLECoordinates.Cells[0,i+1]);
        ay2:=strtoint(VLECoordinates.Cells[1,i+1]);
      end;
      if Intersection(ax1,ay1,ax2,ay2,bx1,by1,bx2,by2) then
        fl:=not fl;
    end;
    Result:=fl;
  end;
var
PointsCount,i: LongWord;
x,y: integer;
InPointsCount: LongWord;
S: real;
begin
  BDrawClick(nil);
  InPointsCount:=0;
  PointsCount:=strtoint(LETestCount.Text);
  for i:=1 to PointsCount do
  begin
    x:=minx+random(maxx-minx)+1;
    y:=miny+random(maxy-miny)+1;
    if PointIn(x,y) then
      InPointsCount:=InPointsCount+1;
    if CBShow.Checked then
      Image.Canvas.Rectangle(x-1,200-(y-1),x+1,200-(y+1));
  end;
  S:=(maxx-minx)*(maxy-miny)*(InPointsCount/PointsCount);
  Label2.Caption:='S='+floattostr(S)+'(или '+floattostr(InPointsCount/PointsCount)+'*S описывающего четырЄхугольника';
end;

procedure TFMain.BStartTestClick(Sender: TObject);
var
PointsCount,i: LongWord;
x,y: integer;
InPointsCount: LongWord;
S: real;
begin
  BDrawClick(nil);
  InPointsCount:=0;
  PointsCount:=strtoint(LETestCount.Text);
  for i:=1 to PointsCount do
  begin
    x:=minx+random(maxx-minx)+1;
    y:=miny+random(maxy-miny)+1;
    if Image.Canvas.Pixels[x,200-y]=clGreen then
      InPointsCount:=InPointsCount+1;
    if CBShow.Checked then
      Image.Canvas.Rectangle(x-1,200-(y-1),x+1,200-(y+1));
  end;
  S:=(maxx-minx)*(maxy-miny)*(InPointsCount/PointsCount);
  Label1.Caption:='S='+floattostr(S)+'(или '+floattostr(InPointsCount/PointsCount)+'*S описывающего четырЄхугольника';
end;

procedure TFMain.Button1Click(Sender: TObject);
begin
  fl:=true;
end;

procedure TFMain.FormActivate(Sender: TObject);
begin
  VLECoordinates.DefaultColWidth:=VLECoordinates.Width div 2;
  Image.Canvas.Rectangle(0,0,Image.Width,Image.Height);
end;

procedure TFMain.ImageClick(Sender: TObject);
begin
  if not fl then
  begin
    fl:=true;
    Fill(posx,posy);
  end;
end;

procedure TFMain.ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if not fl then
  begin
    posx:=x;
    posy:=y;
  end;
end;

end.
