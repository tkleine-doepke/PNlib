within PNlib.PN.Examples.Models.FiliP;
model KrankUrlaub
  parameter Real UrlaubStartTermine[:] = {10,20,30};
  parameter Real UrlaubEndTermine[:] = {15,25,35};
  parameter Real WkeitKrankDauer[:] = {10,20,30};
  Real WkeitKrank =1  annotation(Dialog(enable = true));
  
    PNlib.PN.Components.TD Gesund1(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Delay, timeValue = {0}) annotation(
      Placement(visible = true, transformation(extent = {{14, -90}, {-6, -70}}, rotation = 0)));
    PNlib.PN.Examples.Models.FiliP.PNerweiterungen.PDwkeit Krankpruefer1(enablingProbOut = {WK, 1 - WK}, enablingType = PNlib.Types.EnablingType.Probability, nInDis = 1, nOutDis = 2) annotation(
      Placement(visible = true, transformation(extent = {{40, -90}, {20, -70}}, rotation = 0)));
    PNlib.PN.Components.TD Arbeitet1(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Delay, timeValue = {0}) annotation(
      Placement(visible = true, transformation(extent = {{66, -90}, {46, -70}}, rotation = 0)));
    PNlib.PN.Components.TD T12(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Immediate, timeValue = {0}) annotation(
      Placement(visible = true, transformation(extent = {{-54, -90}, {-74, -70}}, rotation = 0)));
    PNlib.PN.Components.PD KannArbeiteten(nInDis = 3, nOutDis = 1) annotation(
      Placement(visible = true, transformation(extent = {{-30, -90}, {-50, -70}}, rotation = 0)));
    PNlib.PN.Interfaces.DisTransitionOut transitionOutDis annotation(
      Placement(visible = true, transformation(origin = {-116.06, 0.392857}, extent = {{16.7164, -20}, {-16.7164, 20}}, rotation = 0), iconTransformation(origin = {-117.955, -2.23214}, extent = {{18.6119, -22.2679}, {-18.6119, 22.2679}}, rotation = 0)));
    PNlib.PN.Interfaces.DisPlaceIn placeInDis [3] annotation(
      Placement(visible = true, transformation(origin = {116.236, -0.234045}, extent = {{16.8909, -19.766}, {-16.8909, 19.766}}, rotation = 0), iconTransformation(origin = {120.636, 0.191491}, extent = {{18.6364, -21.8085}, {-18.6364, 21.8085}}, rotation = 0)));
    Real WK;
    //Real WU;
    PNlib.PN.Components.TS Krank(E =1:31, P = {75 / 237, 41 / 237, 24 / 237, 19 / 237, 22 / 237, 10 / 237, 13 / 237, 4 / 237, 2 / 237, 3 / 237, 2 / 237, 1 / 237, 3 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237, 1 / 237}, distributionType = PNlib.Types.DistributionType.Discrete, nInDis = 1, nOutDis = 1, timeType = PNlib.Types.StoTimeType.FireDuration) annotation(
      Placement(visible = true, transformation(origin = {4, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    PNlib.PN.Components.TD TUrlaubEnde(nInDis = 1, nOutDis = 1, timeType = PNlib.Types.TimeType.Event,timeValue = UrlaubEndTermine) annotation(
      Placement(visible = true, transformation(origin = {4, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    PNlib.PN.Components.TD TUrlaubStart( nOutDis = 1, timeType = PNlib.Types.TimeType.Event,timeValue = UrlaubStartTermine) annotation(
      Placement(visible = true, transformation(origin = {4, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    PNlib.PN.Components.PD ImUrlaub(nInDis = 1, nOutDis = 1) annotation(
      Placement(visible = true, transformation(origin = {30, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD Urlaubgeber(nInDis = 2, nOutDis = 1, timeType = PNlib.Types.TimeType.Delay, timeValue = {0})  annotation(
      Placement(visible = true, transformation(origin = {52, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD P1(nInDis = 1, nOutDis = 2)  annotation(
      Placement(visible = true, transformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.TD T1( nInDis = 1, timeType = PNlib.Types.TimeType.Event,timeValue = UrlaubEndTermine) annotation(
      Placement(visible = true, transformation(origin = {84, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  PNlib.PN.Components.PD Urlaubpruefer(nInDis = 3, nOutDis = 2)  annotation(
      Placement(visible = true, transformation(origin = {80, -80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  protected
    outer PNlib.PN.Components.Settings settings "global settings for animation and display";
  equation
  connect(ImUrlaub.outTransitionDis[1], TUrlaubEnde.inPlacesDis[1]) annotation(
    Line(points = {{20, 0}, {10, 0}, {10, 0}, {8, 0}}, thickness = 0.5));
  connect(ImUrlaub.inTransitionDis[1], Urlaubgeber.outPlacesDis[1]) annotation(
    Line(points = {{40, 0}, {49, 0}}, thickness = 0.5));
  connect(P1.outTransitionDis[2], Urlaubgeber.inPlacesDis[2]) annotation(
    Line(points = {{60, 50}, {62, 50}, {62, 0}, {59, 0}}, thickness = 0.5));
  connect(Urlaubpruefer.outTransitionDis[1], Urlaubgeber.inPlacesDis[1]) annotation(
    Line(points = {{70, -80}, {66, -80}, {66, 0}, {59, 0}}, thickness = 0.5));
  connect(T12.outPlacesDis[1], transitionOutDis) annotation(
    Line(points = {{-68, -80}, {-78, -80}, {-78, -4}, {-116, -4}, {-116, 0}}, thickness = 0.5));
  connect(Krankpruefer1.outTransitionDis[2], Gesund1.inPlacesDis[1]) annotation(
    Line(points = {{20, -80}, {10, -80}, {10, -80}, {8, -80}}, thickness = 0.5));
  connect(Krankpruefer1.outTransitionDis[1], Krank.inPlacesDis[1]) annotation(
    Line(points = {{20, -80}, {14, -80}, {14, -40}, {8, -40}, {8, -40}}, thickness = 0.5));
  connect(Arbeitet1.outPlacesDis[1], Krankpruefer1.inTransitionDis[1]) annotation(
    Line(points = {{52, -80}, {42, -80}, {42, -80}, {40, -80}}, thickness = 0.5));
    connect(Urlaubpruefer.outTransitionDis[2], Arbeitet1.inPlacesDis[1]) annotation(
      Line(points = {{70, -80}, {60, -80}, {60, -80}, {60, -80}}, thickness = 0.5));
    connect(Urlaubpruefer.inTransitionDis[3], placeInDis[3]) annotation(
      Line(points = {{90, -80}, {96, -80}, {96, 0}, {116, 0}, {116, 0}}, thickness = 0.5));
    connect(Urlaubpruefer.inTransitionDis[2], placeInDis[2]) annotation(
      Line(points = {{90, -80}, {96, -80}, {96, 0}, {116, 0}, {116, 0}}, thickness = 0.5));
    connect(Urlaubpruefer.inTransitionDis[1], placeInDis[1]) annotation(
      Line(points = {{90, -80}, {96, -80}, {96, 0}, {116, 0}, {116, 0}}, thickness = 0.5));
    connect(P1.outTransitionDis[1], T1.inPlacesDis[1]) annotation(
      Line(points = {{60, 50}, {80, 50}, {80, 50}, {80, 50}}, thickness = 0.5));
    connect(TUrlaubStart.outPlacesDis[1], P1.inTransitionDis[1]) annotation(
      Line(points = {{11, 50}, {40, 50}}, thickness = 0.5));
    connect(KannArbeiteten.inTransitionDis[1], Gesund1.outPlacesDis[1]) annotation(
      Line(points = {{-29.2, -80}, {-1.2, -80}, {-1.2, -80}, {0.800078, -80}}, thickness = 0.5));
    connect(KannArbeiteten.inTransitionDis[2], Krank.outPlacesDis[1]) annotation(
      Line(points = {{-29.2, -80}, {-19.2, -80}, {-19.2, -40}, {0.800078, -40}, {0.800078, -40}}, thickness = 0.5));
    connect(KannArbeiteten.inTransitionDis[3], TUrlaubEnde.outPlacesDis[1]) annotation(
      Line(points = {{-29.2, -80}, {-19.2, -80}, {-19.2, 0}, {0.800078, 0}, {0.800078, 0}}, thickness = 0.5));
    connect(KannArbeiteten.outTransitionDis[1], T12.inPlacesDis[1]) annotation(
      Line(points = {{-50.8, -80}, {-60.8, -80}}));
    WK = if time <= 744 then 0.0117 else if time <= 1464 then 0.008 else if time <= 2208 then 0.0196 else if time <= 2928 then 0.0325 else if time <= 3672 then 0.0276 else if time <= 4416 then 0.031 else if time <= 5088 then 0.0344 else if time <= 5832 then 0.0458 else if time <= 6552 then 0.0084 else if time <= 7296 then 0.0118 else if time <= 8016 then 0.0315 else 0.0188;
//WU = if time <= 744 then 0.0212 else if time <= 1464 then 0.0531 else if time <= 2208 then 0.0310 else if time <= 2928 then 0.0458 else if time <= 3672 then 0.0671 else if time <= 4416 then 0.046 else if time <= 5088 then 0.0135 else if time <= 5832 then 0.0304 else if time <= 6552 then 0.03 else if time <= 7296 then 0.0446 else if time <= 8016 then 0.0372 else 0.0618;
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
      Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.2), graphics = {Rectangle(origin = {0, -2}, fillColor = {255, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
  end KrankUrlaub;
