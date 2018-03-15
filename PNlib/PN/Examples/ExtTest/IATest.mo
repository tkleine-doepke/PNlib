within PNlib.PN.Examples.ExtTest;
model IATest
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{100, 20}, {120, 40}})));
  PNlib.PN.Components.EA EA1(Arc = PNlib.Types.ArcType.RealInhibitorArc, testValue = 1) annotation(Placement(visible = true, transformation(extent = {{-40, 8}, {-26, 12}}, rotation = 0)));
  PNlib.PN.Components.EA EA2(Arc = PNlib.Types.ArcType.RealInhibitorArc, testValue = 2) annotation(Placement(visible = true, transformation(origin = {54, 9}, extent = {{-6, -3}, {6, 3}}, rotation = 0)));
  PNlib.PN.Components.PC P1( nIn=1,nOut=2, nOutExt = 1, startMarks = 2) annotation(Placement(transformation(extent={{-70, -10}, {-50, 10}})));
  PNlib.PN.Components.PC P2(nIn=1, nOutExt=1, startMarks = 1) annotation(Placement(transformation(extent={{10, -10}, {30, 10}})));
  PNlib.PN.Components.PC P3(nIn=1) annotation(Placement(transformation(extent={{90, -10}, {110, 10}})));
  PNlib.PN.Components.TC T1( nIn=1, nInExt = 1,nOut=1) annotation(Placement(transformation(extent={{-20, -10}, {0, 10}})));
  PNlib.PN.Components.TC T2(nOut=1, maximumSpeed=1.5) annotation(Placement(transformation(extent={{-100, -10}, {-80, 10}})));
  PNlib.PN.Components.TC T3( arcWeightIn={ 2}, maximumSpeed = 2,nIn= 1, nInExt = 1, nOut=1) annotation(Placement(transformation(extent={{-10, -10}, {10, 10}}, rotation=0, origin={80, 0})));
equation
  connect(EA1.outExt, T1.extIn[1]) annotation(
    Line(points = {{-26, 10}, {-16, 10}, {-16, 10}, {-14, 10}}));
  connect(EA1.inExt, P1.extOut[1]) annotation(
    Line(points = {{-42, 10}, {-52, 10}, {-52, 8}, {-52, 8}, {-52, 8}}));
  connect(T1.outPlaces[1], P2.inTransition[1]) annotation(
    Line(points = {{-6, 0}, {8, 0}, {8, 0}, {10, 0}}, thickness = 0.5));
  connect(T3.outPlaces[1], P3.inTransition[1]) annotation(
    Line(points = {{84, 0}, {90, 0}, {90, 0}, {90, 0}}, thickness = 0.5));
  connect(P2.extOut[1], EA2.inExt) annotation(
    Line(points = {{28, 8}, {28, 8}, {28, 10}, {48, 10}, {48, 10}}, thickness = 0.5));
  connect(EA2.outExt, T3.extIn[1]) annotation(
    Line(points = {{62, 10}, {74, 10}, {74, 10}, {76, 10}}));
  connect(P1.outTransition[2], T3.inPlaces[1]) annotation(
    Line(points = {{-50, 0}, {-34, 0}, {-34, -24}, {68, -24}, {68, 0}, {76, 0}, {76, 0}}, thickness = 0.5));
  connect(P1.outTransition[1], T1.inPlaces[1]) annotation(
    Line(points = {{-50, 0}, {-16, 0}, {-16, 0}, {-14, 0}}, thickness = 0.5));
  connect(T2.outPlaces[1], P1.inTransition[1]) annotation(
    Line(points = {{-86, 0}, {-70, 0}, {-70, 0}, {-70, 0}}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100, -40}, {120, 40}})), experiment(StartTime=0.0, StopTime=6.0, Tolerance = 1e-6));
end IATest;
