within PNlib.PN.Examples.DisTest;
model InputConflictBeneBaB
  extends Modelica.Icons.Example;

  PNlib.PN.Components.PD P1(benefitType = PNlib.Types.BenefitType.BranchAndBound, enablingBeneIn = {6, 5}, enablingType = PNlib.Types.EnablingType.Benefit,maxTokens = 5, nIn = 2, nOut = 1) annotation(Placement(transformation(extent={{10, -10},
            {30, 10}})));
  PNlib.PN.Components.TD T1(arcWeightIn = {3}, nIn = 1) annotation(Placement(visible = true, transformation(extent = {{40, -10}, {60, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T2(arcWeightOut = {3},nIn = 1, nOut = 1) annotation(Placement(transformation(extent={{-20, 10},
            {0, 30}})));
  PNlib.PN.Components.TD T3(arcWeightOut = {2},nIn = 1, nOut = 1) annotation(Placement(transformation(extent={{-20, -30},
            {0, -10}})));
  PNlib.PN.Components.PD P2(startTokens = 5, nOut = 1) annotation(Placement(transformation(extent={{-50, 10},
            {-30, 30}})));
  PNlib.PN.Components.PD P3(startTokens = 5, nOut = 1) annotation(Placement(transformation(extent={{-50, -30},
            {-30, -10}})));
  inner PNlib.PN.Components.Settings settings annotation(Placement(transformation(extent={{40, 20},
            {60, 40}})));
equation
  connect(T1.inPlacesDis[1], P1.outTransitionDis[1]) annotation(Line(points = {{45, 0}, {30.8, 0}}));
  connect(P2.outTransitionDis[1], T2.inPlacesDis[1]) annotation(Line(points={{-29.2, 20},
          {-14.8, 20}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(P3.outTransitionDis[1], T3.inPlacesDis[1]) annotation(Line(points={{-29.2, -20},
          {-14.8, -20}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T2.outPlacesDis[1], P1.inTransitionDis[1]) annotation(Line(points={{-5.2, 20},
          {0, 20}, {0, -0.5}, {9.2, -0.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(T3.outPlacesDis[1], P1.inTransitionDis[2]) annotation(Line(points={{-5.2, -20},
          {0, -20}, {0, 0.5}, {9.2, 0.5}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent={{-60, -40},
            {60, 40}}), graphics), experiment(StartTime=0.0, StopTime=10.0, Tolerance = 1e-6));
end InputConflictBeneBaB;
