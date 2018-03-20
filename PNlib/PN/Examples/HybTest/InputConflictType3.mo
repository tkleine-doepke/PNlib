within PNlib.PN.Examples.HybTest;
model InputConflictType3
  extends Modelica.Icons.Example;
  PNlib.PN.Components.PC P1(nIn = 2, nOut = 1, maxMarks=2) annotation(Placement(transformation(extent={{10, -10}, {30, 10}})));
  PNlib.PN.Components.TC T1(nIn = 1) annotation(Placement(transformation(extent = {{40, -10}, {60, 10}})));
  PNlib.PN.Components.TD T2(nIn = 1, nOut = 1) annotation(Placement(transformation(extent = {{-20, 10}, {0, 30}})));
  PNlib.PN.Components.TC T3(nIn = 1, nOut = 1, maximumSpeed=2) annotation(Placement(transformation(extent = {{-20, -30}, {0, -10}})));
  PNlib.PN.Components.PD P2(startTokens = 5, nOut = 1) annotation(Placement(transformation(extent = {{-50, 10}, {-30, 30}})));
  PNlib.PN.Components.PC P3(nOut = 1, startMarks=5) annotation(Placement(transformation(extent = {{-50, -30}, {-30, -10}})));
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent = {{40, 20}, {60, 40}})));
equation
  connect(P2.outTransition[1], T2.inPlaces[1]) annotation(Line(points = {{-29.2, 20}, {-14.8, 20}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(P3.outTransition[1], T3.inPlaces[1]) annotation(Line(points = {{-29.2, -20}, {-14.8, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T2.outPlaces[1], P1.inTransition[1]) annotation(Line(points={{-5.2, 20}, {0, 20}, {0, -0.5}, {9.2, -0.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T3.outPlaces[1], P1.inTransition[2]) annotation(Line(points={{-5.2, -20}, {0, -20}, {0, 0.5}, {9.2, 0.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T1.inPlaces[1], P1.outTransition[1]) annotation(Line(points={{45.2, 0}, {30.8, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -40}, {60, 40}}), graphics), experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end InputConflictType3;
