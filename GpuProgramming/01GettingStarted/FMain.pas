unit FMain;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Math.Vectors,
  FMX.Types,
  FMX.Controls,
  FMX.Forms3D,
  FMX.Types3D,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Controls3D,
  FMX.Layers3D,
  FMX.Objects3D,
  FMX.Ani,
  Materials;

type
  TFormMain = class(TForm3D)
    Layer3D: TLayer3D;
    LabelBackend: TLabel;
    Plane: TPlane;
    FloatAnimationRotationY: TFloatAnimation;
    procedure Form3DCreate(Sender: TObject);
    procedure Form3DRender(Sender: TObject; Context: TContext3D);
  private
    { Private declarations }
    FMaterialSource: TBlueMaterialSource;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

procedure TFormMain.Form3DCreate(Sender: TObject);
begin
  LabelBackend.Text := 'Backend: ' + Context.ClassName;
  FMaterialSource := TBlueMaterialSource.Create(Self);
  Plane.MaterialSource := FMaterialSource;
end;

procedure TFormMain.Form3DRender(Sender: TObject; Context: TContext3D);
begin
  {$IF Defined(MACOS) and not Defined(IOS)}
  { Workaround for https://quality.embarcadero.com/browse/RSP-32121 }
  if (GlobalUseMetal) then
    Context.FillRect(Point3D(-Width, -Height, 100), Point3D(Width, Height, 100), 1, Color);
  {$ENDIF}
end;

end.
