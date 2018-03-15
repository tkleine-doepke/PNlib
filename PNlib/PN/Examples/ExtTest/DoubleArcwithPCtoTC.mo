within PNlib.PN.Examples.ExtTest;
model DoubleArcwithPCtoTC
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{-60, 40}, {-40, 60}})));
  PNlib.PN.Components.EA Es1(Arc = PNlib.Types.ArcType.RealInhibitorArc,testValue=3) annotation(Placement(visible = true, transformation(extent = {{-22, 36}, {-8, 42}}, rotation = 0)));
  PNlib.PN.Components.PC P1(nOut=2, nOutExt = 2, startMarks=5) annotation(Placement(transformation(extent={{-54, -10}, {-34, 10}})));
  PNlib.PN.Components.PC P2(nIn=1) annotation(Placement(transformation(extent={{30, 20}, {50, 40}})));
  PNlib.PN.Components.PC P3(nIn=1) annotation(Placement(transformation(extent={{30, -40}, {50, -20}})));
  PNlib.PN.Components.EA EA2(Arc = PNlib.Types.ArcType.RealTestArc, testValue=2) annotation(Placement(visible = true, transformation(extent = {{-20, -24}, {-6, -18}}, rotation = 0)));
  PNlib.PN.Components.TC T1( nIn=1, nInExt = 1,nOut=1) annotation(Placement(transformation(extent={{6, 20}, {26, 40}})));
  PNlib.PN.Components.TC T2(nIn=1, nInExt = 1, nOut=1) annotation(Placement(transformation(extent={{6, -40}, {26, -20}})));
equation
  connect(T2.outPlaces[1], P3.inTransition[1]) annotation(
    Line(points = {{20, -30}, {28, -30}, {28, -30}, {30, -30}}, thickness = 0.5));
  connect(T1.outPlaces[1], P2.inTransition[1]) annotation(
    Line(points = {{20, 30}, {28, 30}, {28, 30}, {30, 30}}, thickness = 0.5));
  connect(P1.extOut[1], EA2.inExt) annotation(
    Line(points = {{-36, 8}, {-30, 8}, {-30, -20}, {-22, -20}, {-22, -20}}, thickness = 0.5));
  connect(P1.extOut[1], Es1.inExt) annotation(
    Line(points = {{-36, 8}, {-30, 8}, {-30, 40}, {-24, 40}, {-24, 40}, {-24, 40}}, thickness = 0.5));
  connect(Es1.outExt, T1.extIn[1]) annotation(
    Line(points = {{-8, 40}, {10, 40}, {10, 40}, {12, 40}}));
  connect(EA2.outExt, T2.extIn[1]) annotation(
    Line(points = {{-6, -20}, {12, -20}, {12, -20}, {12, -20}}));
  connect(P1.outTransition[1], T1.inPlaces[1]) annotation(
    Line(points = {{-34, 0}, {4, 0}, {4, 30}, {12, 30}, {12, 30}}, thickness = 0.5));
  connect(P1.outTransition[2], T2.inPlaces[1]) annotation(
    Line(points = {{-34, 0}, {4, 0}, {4, -30}, {12, -30}, {12, -30}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-60, -60}, {60, 60}})), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end DoubleArcwithPCtoTC;
