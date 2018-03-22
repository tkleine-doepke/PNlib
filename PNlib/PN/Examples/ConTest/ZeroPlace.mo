within PNlib.PN.Examples.ConTest;
model ZeroPlace
  extends Modelica.Icons.Example;

  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{40, 20},
            {60, 40}})));
  PNlib.PN.Components.TC T1(nOutCon = 1) annotation(Placement(transformation(extent={{-60, -10}, {
            -40, 10}})));
  PNlib.PN.Components.PC P1(nInCon = 1, nOutCon = 1) annotation(Placement(transformation(extent={{-30, -10},
            {-10, 10}})));
  PNlib.PN.Components.TC T2(maximumSpeed = 2,nInCon = 1, nOutCon = 1) annotation(Placement(transformation(extent={{0, -10},
            {20, 10}})));
  PNlib.PN.Components.PC P2(nInCon = 1) annotation(Placement(transformation(extent={{30, -10}, {50,
            10}})));
equation
  connect(T1.outPlacesCon[1], P1.inTransitionCon[1]) annotation(Line(points={{-45.2, 0},
          {-30.8, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(P1.outTransitionCon[1], T2.inPlacesCon[1]) annotation(Line(points={{-9.2, 0},
          {5.2, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T2.outPlacesCon[1], P2.inTransitionCon[1]) annotation(Line(points={{14.8, 0},
          {29.2, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-60, -20},
            {60, 40}}), graphics), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end ZeroPlace;
