within PNlib.CPN;
model PD "Discrete Place"
  discrete Integer t(start = startTokens, fixed=true) "marking";
  parameter Integer nIn=0 "number of input transitions" annotation(Dialog(connectorSizing=true));
  parameter Integer nOut=0 "number of output transitions" annotation(Dialog(connectorSizing=true));
  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter Integer startTokens = 0 "start tokens" annotation(Dialog(enable = true, group = "Tokens"));
  parameter Integer minTokens = 0 "minimum capacity" annotation(Dialog(enable = true, group = "Tokens"));
  parameter Integer maxTokens=PNlib.Constants.Integer_inf "maximum capacity" annotation(Dialog(enable = true, group = "Tokens"));
  Boolean reStart(start=false, fixed=true)=false "restart condition" annotation(Dialog(enable = true, group = "Tokens"));
  parameter Integer reStartTokens=startTokens "number of tokens at restart" annotation(Dialog(enable = true, group = "Tokens"));
  parameter PNlib.Types.EnablingType enablingType=PNlib.Types.EnablingType.Priority
    "resolution type of actual conflict (type-1-conflict)" annotation(Dialog(enable = true, group = "Enabling"));
  parameter Integer enablingPrioIn[nIn]=1:nIn
    "enabling priorities of input transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Priority then true else false, group = "Enabling"));
  parameter Integer enablingPrioOut[nOut]=1:nOut
    "enabling priorities of output transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Priority then true else false, group = "Enabling"));
  parameter Real enablingProbIn[nIn]=fill(1/nIn, nIn)
    "enabling probabilities of input transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Probability then true else false, group = "Enabling"));
  parameter Real enablingProbOut[nOut]=fill(1/nOut, nOut)
    "enabling probabilities of output transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Probability then true else false, group = "Enabling"));
  parameter Real enablingBeneIn[nIn]=1:nIn
      "enabling benefit of input transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Benefit then true else false, group = "Enabling"));
  parameter Real enablingBeneOut[nOut]=1:nOut
      "enabling benefit of output transitions" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Benefit then true else false, group = "Enabling"));
  parameter PNlib.Types.BenefitType benefitType=PNlib.Types.BenefitType.Greedy
        "enabling strategy for benefit" annotation(Dialog(enable = if enablingType==PNlib.Types.EnablingType.Benefit then true else false, group = "Enabling"));
  parameter Integer N=settings.N "N+1=amount of levels" annotation(Dialog(enable = true, group = "Level Concentrations"));
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//
  Real levelCon
    "conversion of tokens to level concentration according to M and N of the settings box";
  Boolean showCapacity=settings.showCapacity
    "only for place animation and display (Do not change!)";
  Boolean animateMarking=settings.animateMarking
    "only for place animation and display (Do not change!)";
  Real color[3] "only for place animation and display (Do not change!)";
  parameter Integer localSeedIn = PNlib.Functions.Random.counter() "Local seed to initialize random number generator for input conflicts" annotation(Dialog(enable = true, group = "Random Number Generator"));
  parameter Integer localSeedOut = PNlib.Functions.Random.counter() "Local seed to initialize random number generator for output conflicts" annotation(Dialog(enable = true, group = "Random Number Generator"));
protected
  outer PNlib.Settings settings "global settings for animation and display";
  Real tokenscale "only for place animation and display";
  discrete Integer pret "pre marking";
  Integer arcWeightIn[nIn] "Integer weights of input arcs";
  Integer arcWeightOut[nOut] "Integer weights of output arcs";
  Boolean tokeninout(start=false, fixed=true) "change of tokens?";
  Boolean fireIn[nIn] "Do input transtions fire?";
  Boolean fireOut[nOut] "Do output transitions fire?";
  Boolean activeIn[nIn] "Are delays passed of input transitions?";
  Boolean activeOut[nOut](each start=false, each fixed=true) "Are delay passed of output transitions?";
  Boolean enabledByInPlaces[nIn]
    "Are input transitions are enabled by all their input places?";
  //****BLOCKS BEGIN****// since no events are generated within functions!!!
  //Does any delay passed of a connected transition?
  Blocks.anyTrue delayPassedOut(vec=activeOut);
  Blocks.anyTrue delayPassedIn(vec=activeIn);
  //firing sum calculation
  Blocks.firingSumDis firingSumIn(fire=fireIn, arcWeight=arcWeightIn);
  Blocks.firingSumDis firingSumOut(fire=fireOut, arcWeight=arcWeightOut);
  //Enabling process
  CPN.Blocks.enablingOutDis enableOut(delayPassed=delayPassedOut.anytrue, nOut=nOut, arcWeight=arcWeightOut, t=pret, minTokens=minTokens, TAout=activeOut, enablingType=enablingType, enablingPrio=enablingPrioOut, enablingProb=enablingProbOut, enablingBene=enablingBeneOut, benefitType=benefitType, localSeed=localSeedOut, globalSeed=settings.globalSeed);
  CPN.Blocks.enablingInDis enableIn(delayPassed=delayPassedIn.anytrue, active=activeIn, nIn=nIn, arcWeight=arcWeightIn, t=pret, maxTokens=maxTokens, TAein=enabledByInPlaces and activeIn, enablingType=enablingType, enablingPrio=enablingPrioIn, enablingProb=enablingProbIn, enablingBene=enablingBeneIn, benefitType=benefitType, localSeed=localSeedIn, globalSeed=settings.globalSeed);
  //****BLOCKS END****//

public
  PNlib.CPN.Interfaces.PlaceIn inTransition[nIn](
    each tint=pret,
    each maxTokensint=maxTokens,
    enable=enableIn.TEin_,
    fire=fireIn,
    arcWeightint=arcWeightIn,
    active=activeIn,
    enabledByInPlaces=enabledByInPlaces) if nIn > 0 "connector for input transitions" annotation(Placement(transformation(extent={{-114, -10}, {-98, 10}}, rotation=0), iconTransformation(extent={{-116, -10}, {-100, 10}})));
  PNlib.CPN.Interfaces.PlaceOut outTransition[nOut](
    each tint=pret,
    each minTokensint=minTokens,
    enable=enableOut.TEout_,
    each arcType=PNlib.Types.ArcType.NormalArc,
    each tokenInOut=pre(tokeninout),
    fire=fireOut,
    arcWeightint=arcWeightOut,
    active=activeOut,
    each testValueint=-1,
    each normalArc=false) if nOut > 0 "connector for output transitions" annotation(Placement(transformation(extent={{100, -10}, {116, 10}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput pd_t=t
    "connector for Simulink connection" annotation(Placement(
        transformation(extent={{-36, 68}, {-16, 88}}), iconTransformation(
        extent={{-10, -10}, {10, 10}},
        rotation=90,
        origin={0, 106})));
equation
  //****MAIN BEGIN****//
  //recalculation of tokens
  pret=pre(t);
  tokeninout = pre(firingSumIn.firingSum) > 0 or pre(firingSumOut.firingSum) > 0;
  when pre(reStart) then
    t = reStartTokens;
  elsewhen {pre(firingSumIn.firingSum) > 0, pre(firingSumOut.firingSum) > 0} then
    t = pret + pre(firingSumIn.firingSum) - pre(firingSumOut.firingSum);
  end when;
  //Conversion of tokens to level concentrations
  levelCon=t*settings.M/N;
  //****MAIN END****//
  //****ANIMATION BEGIN****//
  tokenscale= t*settings.scale;
  color=if settings.animatePlace then if tokenscale<100 then {255, 255-2.55*tokenscale, 255-2.55*tokenscale} else {255, 0, 0} else {255, 255, 255};
  //****ANIMATION END****//
  //****ERROR MESSENGES BEGIN****//
  assert(PNlib.Functions.OddsAndEnds.prioCheck(enablingPrioIn,nIn) or nIn==0 or enablingType==PNlib.Types.EnablingType.Probability, "The priorities of the input priorities may be given only once and must be selected from 1 to nIn");
  assert(PNlib.Functions.OddsAndEnds.prioCheck(enablingPrioOut,nOut) or nOut==0 or enablingType==PNlib.Types.EnablingType.Probability, "The priorities of the output priorities may be given only once and must be selected from 1 to nOut");
  assert(PNlib.Functions.OddsAndEnds.isEqual(sum(enablingProbIn), 1.0, 1e-6) or nIn==0 or enablingType==PNlib.Types.EnablingType.Priority, "The sum of input enabling probabilities has to be equal to 1");
  assert(PNlib.Functions.OddsAndEnds.isEqual(sum(enablingProbOut), 1.0, 1e-6) or nOut==0 or enablingType==PNlib.Types.EnablingType.Priority, "The sum of output enabling probabilities has to be equal to 1");
  assert(startTokens>=minTokens and startTokens<=maxTokens, "minTokens<=startTokens<=maxTokens");
  //****ERROR MESSENGES END****//
  annotation(defaultComponentName = "P1", Icon(graphics={Ellipse(
          extent={{-100, 96}, {100, -100}},
          lineColor={0, 0, 0},
          fillColor=DynamicSelect({255, 255, 255}, color),
          fillPattern=FillPattern.Solid),
      Text(
        extent={{-1.5, 25.5}, {-1.5, -21.5}},
        lineColor={0, 0, 0},
        textString=DynamicSelect("%startTokens", if animateMarking then realString(t, 1, 0) else " ")),
        Text(
          extent={{-90, 130}, {-90, 116}},
          lineColor={0, 0, 0},
          textString=DynamicSelect(" ", if showCapacity then if maxTokens>1073741822 then  "[%minTokens, inf]" else "[%minTokens, %maxTokens]" else " ")),
                                          Text(
          extent={{-74, -113}, {-74, -138}},
          lineColor={0, 0, 0},
          textString="%name")}),
                           Diagram(graphics));
end PD;
