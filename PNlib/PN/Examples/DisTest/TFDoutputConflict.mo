within PNlib.PN.Examples.DisTest;

model TFDoutputConflict
  extends Modelica.Icons.Example;
  inner PNlib.PN.Components.Settings settings annotation(
    Placement(visible = true, transformation(extent = {{40, 20}, {60, 40}}, rotation = 0)));
  PNlib.PN.Components.PD P1(enablingType = PNlib.Types.EnablingType.Probability, localSeedIn = 1, localSeedOut = 2,nIn = 1, nOut = 2, startTokens = 0) annotation(
    Placement(visible = true, transformation(extent = {{-30, -6}, {-10, 14}}, rotation = 0)));
  PNlib.PN.Components.PD P2(localSeedIn = 3, localSeedOut = 4, nIn = 1) annotation(
    Placement(visible = true, transformation(origin = {40, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T1(nIn = 1, nOut = 1, timeType = PNlib.Types.TimeType.FireDuration) annotation(
    Placement(visible = true, transformation(origin = {10, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T3(nOut = 1)  annotation(
    Placement(visible = true, transformation(origin = {-44, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T2(nIn = 1, nOut = 1, timeType = PNlib.Types.TimeType.FireDuration)  annotation(
    Placement(visible = true, transformation(origin = {10, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P3(localSeedIn = 5, localSeedOut = 6, nIn = 1)  annotation(
    Placement(visible = true, transformation(origin = {40, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(P1.outTransitionDis[1], T1.inPlacesDis[1]) annotation(
    Line(points = {{-9.2, 4}, {5, 4}}));
  connect(T1.outPlacesDis[1], P2.inTransitionDis[1]) annotation(
    Line(points = {{15, 4}, {29, 4}}));
  connect(T2.inPlacesDis[1], P1.outTransitionDis[2]) annotation(
    Line(points = {{5, -24}, {-8.8, -24}, {-8.8, 4}, {-10.8, 4}}));
  connect(T2.outPlacesDis[1], P3.inTransitionDis[1]) annotation(
    Line(points = {{15, -24}, {29, -24}}));
  connect(T3.outPlacesDis[1], P1.inTransitionDis[1]) annotation(
    Line(points = {{-39.2, 4}, {-30.2, 4}}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-60, -40}, {60, 40}}), graphics),
    experiment(StartTime = 0.0, StopTime = 10.0, Tolerance = 1e-6));
end TFDoutputConflict;
