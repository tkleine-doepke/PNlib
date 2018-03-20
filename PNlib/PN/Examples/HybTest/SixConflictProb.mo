within PNlib.PN.Examples.HybTest;
model SixConflictProb
  extends Modelica.Icons.Example;
  PNlib.PN.Components.PC P1(enablingType = PNlib.Types.EnablingType.Probability, nOut = 6, startMarks=1,
    localSeedIn=1,
    localSeedOut=2)                                     annotation(Placement(transformation(extent = {{-50, -10}, {-30, 10}})));
  PNlib.PN.Components.TD T1(nIn = 1) annotation(Placement(transformation(extent = {{-20, 30}, {0, 50}})));
  PNlib.PN.Components.TD T2(nIn = 1) annotation(Placement(transformation(extent = {{0, 20}, {20, 40}})));
  PNlib.PN.Components.TD T3(nIn = 1) annotation(Placement(transformation(extent = {{20, 10}, {40, 30}})));
  PNlib.PN.Components.TD T4(nIn = 1) annotation(Placement(transformation(extent = {{20, -30}, {40, -10}})));
  PNlib.PN.Components.TD T5(nIn = 1) annotation(Placement(transformation(extent = {{0, -40}, {20, -20}})));
  PNlib.PN.Components.TD T6(nIn = 1) annotation(Placement(transformation(extent = {{-20, -50}, {0, -30}})));
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent = {{-60, 40}, {-40, 60}})));
equation
  connect(P1.outTransition[1], T1.inPlaces[1]) annotation(Line(points={{-29.2,
          -0.833333}, {-20, -0.833333}, {-20, 40}, {-14.8, 40}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T2.inPlaces[1], P1.outTransition[2]) annotation(Line(points = {{5.2, 30}, {0, 30}, {0, -0.5}, {-29.2, -0.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T3.inPlaces[1], P1.outTransition[3]) annotation(Line(points={{25.2, 20},
          {20, 20}, {20, -0.166667}, {-29.2, -0.166667}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T4.inPlaces[1], P1.outTransition[4]) annotation(Line(points={{25.2,
          -20}, {20, -20}, {20, 0.166667}, {-29.2, 0.166667}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T5.inPlaces[1], P1.outTransition[5]) annotation(Line(points = {{5.2, -30}, {0, -30}, {0, 0.5}, {-29.2, 0.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T6.inPlaces[1], P1.outTransition[6]) annotation(Line(points={{-14.8,
          -40}, {-20, -40}, {-20, 0.833333}, {-29.2, 0.833333}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -60}, {40, 60}}), graphics), experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end SixConflictProb;
