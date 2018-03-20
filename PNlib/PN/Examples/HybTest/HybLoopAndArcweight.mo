within PNlib.PN.Examples.HybTest;

model HybLoopAndArcweight
  extends Modelica.Icons.Example;
  PNlib.PN.Components.PC P1(nOut = 1, nIn = 1, startMarks=2) annotation(Placement(transformation(extent = {{-10, -30}, {10, -10}})));
  PNlib.PN.Components.TD T1(nIn = 1, nOut = 1, arcWeightIn={1.5}, arcWeightOut={2.5}) annotation(Placement(transformation(extent = {{8, 10}, {-12, 30}})));
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent = {{20, 40}, {40, 60}})));
equation
  connect(P1.outTransition[1], T1.inPlaces[1]) annotation(Line(points = {{10.8, -20}, {20, -20}, {20, 20}, {2.8, 20}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T1.outPlaces[1], P1.inTransition[1]) annotation(Line(points = {{-6.8, 20}, {-20, 20}, {-20, -20}, {-10.8, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-40, -40}, {40, 60}}), graphics), experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end HybLoopAndArcweight;
