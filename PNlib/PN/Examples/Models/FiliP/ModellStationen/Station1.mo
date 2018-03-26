within PNlib.PN.Examples.Models.FiliP.ModellStationen;

model Station1
  extends Modelica.Icons.Example;
  extends PNlib.PN.Examples.Models.FiliP.AllgemeineParameter;
  PNlib.PN.Examples.Models.FiliP.Station station(APND = 1, nP = 1, APFD = 1, APSD = 1) annotation(
    Placement(visible = true, transformation(extent = {{-20, 20}, {20, 60}}, rotation = 0)));
  PNlib.PN.Examples.Models.FiliP.Pflegekraft pflegekraft(Dienstbereit(maxTokens = 1), WEF = 1) annotation(
    Placement(visible = true, transformation(extent = {{-60, -80}, {0, -20}}, rotation = 0)));
  inner PNlib.PN.Components.Settings settings annotation(
    Placement(visible = true, transformation(origin = {90, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(station.placeOutDis[1], pflegekraft.transitionInDis[1]);
  connect(station.placeOutDis[2], pflegekraft.transitionInDis[2]);
  connect(station.placeOutDis[3], pflegekraft.transitionInDis[3]);

  connect(station.placeInDis[1], pflegekraft.transitionOutDis[1]);
  connect(station.placeInDis[2], pflegekraft.transitionOutDis[2]);
  connect(station.placeInDis[3], pflegekraft.transitionOutDis[3]);
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    experiment(StartTime = 0, StopTime = 365, Tolerance = 1e-06));
end Station1;
