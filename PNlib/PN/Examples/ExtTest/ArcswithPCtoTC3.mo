within PNlib.PN.Examples.ExtTest;

model ArcswithPCtoTC3
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(
    Placement(visible = true, transformation(extent = {{-100, 60}, {-80, 80}}, rotation = 0)));
  PNlib.PN.Components.PC P1(minMarks = 1, nOut = 1, nOutExt = 1, startMarks = 2) annotation(
    Placement(visible = true, transformation(origin = {-40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P2(nIn = 1) annotation(
    Placement(visible = true, transformation(origin = {40, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P3(minMarks = 1, nOut = 1, nOutExt = 1, startMarks = 2) annotation(
    Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P4(nIn = 1) annotation(
    Placement(visible = true, transformation(origin = {40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P5(minMarks = 1, nOut = 1, nOutExt = 1, startMarks = 2) annotation(
    Placement(visible = true, transformation(origin = {-40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P6(nIn = 1) annotation(
    Placement(visible = true, transformation(origin = {40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P7(minMarks = 1, nOut = 1, nOutExt = 1, startMarks = 2) annotation(
    Placement(visible = true, transformation(origin = {-40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PC P8(nIn = 1) annotation(
    Placement(visible = true, transformation(origin = {40, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TC T1(nInExt = 1, nOut = 1) annotation(
    Placement(visible = true, transformation(origin = {10, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TC T2(nInExt = 1, nOut = 1) annotation(
    Placement(visible = true, transformation(origin = {10, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TC T3(nInExt = 1, nOut = 1) annotation(
    Placement(visible = true, transformation(origin = {10, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TC T4(nInExt = 1, nOut = 1) annotation(
    Placement(visible = true, transformation(origin = {10, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.EA EA1 annotation(
    Placement(visible = true, transformation(origin = {-8, 66}, extent = {{-9.8, 0.4}, {2.8, 4.8}}, rotation = 0)));
  PNlib.PN.Components.EA EA2(Arc = PNlib.Types.ArcType.TestArc)  annotation(
    Placement(visible = true, transformation(origin = {-8, 26}, extent = {{-9.8, 0.4}, {2.8, 4.8}}, rotation = 0)));
  PNlib.PN.Components.EA EA3(Arc = PNlib.Types.ArcType.RealInhibitorArc)  annotation(
    Placement(visible = true, transformation(origin = {-8, -14}, extent = {{-9.8, 0.4}, {2.8, 4.8}}, rotation = 0)));
  PNlib.PN.Components.EA EA4(Arc = PNlib.Types.ArcType.InhibitorArc)  annotation(
    Placement(visible = true, transformation(origin = {-8, -54}, extent = {{-9.8, 0.4}, {2.8, 4.8}}, rotation = 0)));
  PNlib.PN.Components.TC T5(nIn = 4, nOut = 0)  annotation(
    Placement(visible = true, transformation(origin = {-84, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(EA4.outExt, T4.extIn[1]) annotation(
    Line(points = {{-4, -52}, {4, -52}, {4, -50}, {6, -50}}));
  connect(EA3.outExt, T3.extIn[1]) annotation(
    Line(points = {{-4, -12}, {4, -12}, {4, -10}, {6, -10}}));
  connect(EA2.outExt, T2.extIn[1]) annotation(
    Line(points = {{-4, 28}, {4, 28}, {4, 30}, {6, 30}}));
  connect(EA1.outExt, T1.extIn[1]) annotation(
    Line(points = {{-4, 68}, {4, 68}, {4, 70}, {6, 70}}));
  connect(P7.extOut[1], EA4.inExt) annotation(
    Line(points = {{-32, -52}, {-20, -52}, {-20, -52}, {-18, -52}}, thickness = 0.5));
  connect(P5.extOut[1], EA3.inExt) annotation(
    Line(points = {{-32, -12}, {-20, -12}, {-20, -12}, {-18, -12}}, thickness = 0.5));
  connect(P3.extOut[1], EA2.inExt) annotation(
    Line(points = {{-32, 28}, {-20, 28}, {-20, 28}, {-18, 28}}, thickness = 0.5));
  connect(P1.extOut[1], EA1.inExt) annotation(
    Line(points = {{-32, 68}, {-18, 68}, {-18, 68}, {-18, 68}}, thickness = 0.5));
  connect(T4.outPlaces[1], P8.inTransition[1]) annotation(
    Line(points = {{14, -60}, {30, -60}, {30, -60}, {30, -60}}, thickness = 0.5));
  connect(T3.outPlaces[1], P6.inTransition[1]) annotation(
    Line(points = {{14, -20}, {30, -20}, {30, -20}, {30, -20}}, thickness = 0.5));
  connect(T2.outPlaces[1], P4.inTransition[1]) annotation(
    Line(points = {{14, 20}, {30, 20}, {30, 20}, {30, 20}}, thickness = 0.5));
  connect(T1.outPlaces[1], P2.inTransition[1]) annotation(
    Line(points = {{14, 60}, {28, 60}, {28, 60}, {30, 60}}, thickness = 0.5));
  connect(P7.outTransition[1], T5.inPlaces[4]) annotation(
    Line(points = {{-30, -60}, {-26, -60}, {-26, -78}, {-66, -78}, {-66, 0}, {-80, 0}, {-80, 0}}, thickness = 0.5));
  connect(P5.outTransition[1], T5.inPlaces[3]) annotation(
    Line(points = {{-30, -20}, {-26, -20}, {-26, -36}, {-66, -36}, {-66, 0}, {-80, 0}, {-80, 0}}, thickness = 0.5));
  connect(P3.outTransition[1], T5.inPlaces[2]) annotation(
    Line(points = {{-30, 20}, {-26, 20}, {-26, 0}, {-78, 0}, {-78, 0}, {-80, 0}}, thickness = 0.5));
  connect(P1.outTransition[1], T5.inPlaces[1]) annotation(
    Line(points = {{-30, 60}, {-26, 60}, {-26, 38}, {-66, 38}, {-66, 0}, {-80, 0}, {-80, 0}}, thickness = 0.5));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -80}, {60, 80}})),
    experiment(StartTime = 0.0, StopTime = 2.0, Tolerance = 1e-6));
end ArcswithPCtoTC3;
