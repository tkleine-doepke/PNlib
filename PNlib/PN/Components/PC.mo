within PNlib.PN.Components;
model PC "Continuous Place"
  Real t "marking";
  parameter Integer nIn(min=0)= 0 "number of input transitions" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nOut(min=0)= 0 "number of output transitions" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nInDis(min=0)= 0 "number of discrete input transitions" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nOutDis(min=0)= 0 "number of discrete hybrid output transitions" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nOutExt(min=0)=0 "number of output transitions" annotation(Dialog(enable=true,group="Connector sizing"));
  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter Real startMarks = 0 "start marks" annotation(Dialog(enable = true, group = "Marks"));
  parameter Real minMarks = 0 "minimum capacity" annotation(Dialog(enable = true, group = "Marks"));
  parameter Real maxMarks=PNlib.Constants.inf "maximum capacity" annotation(Dialog(enable = true, group = "Marks"));
  parameter Boolean showTokenFlow=false;
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
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//
  PNlib.PN.Blocks.tokenFlowCon tokenFlow(nIn=nIn, nOut=nOut, conFiringSumIn=firingSumInCon.conFiringSum, conFiringSumOut=firingSumOutCon.conFiringSum, fireIn=fireIn, fireOut=fireOut, arcWeightIn=arcWeightIn, arcWeightOut=arcWeightOut, instSpeedIn=instSpeedIn, instSpeedOut=instSpeedOut) if showTokenFlow;
  parameter Integer localSeedIn = PNlib.Functions.Random.counter() "Local seed to initialize random number generator for input conflicts" annotation(Dialog(enable = true, group = "Random Number Generator"));
  parameter Integer localSeedOut = PNlib.Functions.Random.counter() "Local seed to initialize random number generator for output conflicts" annotation(Dialog(enable = true, group = "Random Number Generator"));
  PNlib.PN.Interfaces.ConPlaceIn inTransition[nIn](
  each t=t_,
  each maxTokens=maxMarks,
  each emptied = emptying.anytrue,
  decreasingFactor = decFactorIn.value,
  each speedSum= firingSumOutCon.conFiringSum,
  fire=fireInCon,
  active=activeInCon,
  arcWeight=arcWeightInCon,
  instSpeed=instSpeedIn,
  maxSpeed=maxSpeedIn,
  prelimSpeed=prelimSpeedIn) if nIn > 0 "connector for input transitions" annotation(Placement(
        transformation(extent={{-114, -10}, {-98, 10}}, rotation=0),
    iconTransformation(extent={{-116, -10}, {-100, 10}})));
  PNlib.PN.Interfaces.ConPlaceOut outTransition[nOut](
  each t = t_,
  each minTokens=minMarks,
  each fed=feeding.anytrue,
  decreasingFactor=decFactorOut.value,
  each speedSum=firingSumInCon.conFiringSum,
  fire=fireOutCon,
  active=activeOutCon,
  arcWeight=arcWeightOutCon,
  instSpeed=instSpeedOut,
  maxSpeed=maxSpeedOut,
  prelimSpeed=prelimSpeedOut) if nOut > 0 "connector for output transitions" annotation(Placement(
        transformation(extent={{100, -10}, {116, 10}}, rotation=0)));
  PNlib.PN.Interfaces.HybPlaceIn inTransitionDis[nIn](
  each t=t_,
  each maxTokens=maxTokens,
  enable=enableIn.value,
  fire=fireInDis,
  arcWeight=arcWeightInDis,
  active=activeInDis,
  enabledByInPlaces=enabledByInPlaces) if nInDis > 0 "connector for input transitions" annotation(Placement(visible = true,transformation(extent={{-114, -52}, {-98, -32}}, rotation=0), iconTransformation(extent = {{-86, -82}, {-70, -62}}, rotation = 45)));
  PNlib.PN.Interfaces.HybPlaceOut outTransitionDis[nOut](
  each t=t_,
  each minTokens=minTokens,
  enable=enableOut.value,
  each tokenInOut=pre(disMarksInOut.value),
  fire=fireOutDis,
  arcWeight=arcWeightOutDis,
  active=activeOutDis) if nOutDis > 0 "connector for output transitions" annotation(Placement(visible = true, transformation(extent = {{100, -44}, {116, -24}}, rotation = 0), iconTransformation(extent = {{68, -82}, {84, -62}}, rotation = -45)));


  PNlib.PN.Interfaces.PlaceOutExt extOut[nOutExt](each t=t) if nOutExt > 0 "connector for output extended Arcs" annotation(Placement(transformation(extent={{70, 62}, {86, 82}}, rotation =45)));


  PNlib.PN.Interfaces.RealConIn decFactorIn1 [nIn] (value=decreasingFactorCon.decFactorIn) if (nIn>0 and nOut>0);
  PNlib.PN.Interfaces.RealConIn decFactorIn2 [nIn](each value=1.0) if not (nIn>0 and nOut>0);
  PNlib.PN.Interfaces.RealConOut decFactorIn [nIn];

  PNlib.PN.Interfaces.RealConIn decFactorOut1 [nOut] (value=decreasingFactorCon.decFactorOut) if (nIn>0 and nOut>0);
  PNlib.PN.Interfaces.RealConIn decFactorOut2 [nOut] (each value=1.0) if not (nIn>0 and nOut>0);
  PNlib.PN.Interfaces.RealConOut decFactorOut [nOut];
  // Discrete
  PNlib.PN.Interfaces.BooleanConIn disMarksInOut1(value=(pre(disMarksIn.anytrue) > 0 or pre(disMarksOut.anytrue) > 0)) if (nInDis>0 and nOutDis>0);
  PNlib.PN.Interfaces.BooleanConIn disMarksInOut2(value=pre(disMarksIn.anytrue) > 0) if (nInDis>0 and nOutDis==0);
  PNlib.PN.Interfaces.BooleanConIn disMarksInOut3(value=pre(disMarksOut.anytrue) > 0) if (nInDis==0 and nOutDis>0);
  PNlib.PN.Interfaces.BooleanConIn disMarksInOut4(value=false) if (nInDis==0 and nOutDis==0);
  PNlib.PN.Interfaces.BooleanConOut disMarksInOut;

  PNlib.PN.Interfaces.BooleanConIn PrioIn [nIn](value=enableInPrio.TEin_) if (nIn>0 and enablingType==PNlib.Types.EnablingType.Priority);
  PNlib.PN.Interfaces.BooleanConIn PrioOut[nOut](value=enableOutPrio.TEout_) if (nOut>0 and enablingType==PNlib.Types.EnablingType.Priority);
  PNlib.PN.Interfaces.BooleanConIn enableInDummy[nIn](value=false) if (nIn==0);
  PNlib.PN.Interfaces.BooleanConIn enableOutDummy[nOut](value=false) if (nOut==0);
  PNlib.PN.Interfaces.BooleanConOut enableIn[nIn];
  PNlib.PN.Interfaces.BooleanConOut enableOut[nOut];

  PNlib.PN.Interfaces.RealConIn firingSum1Dis(value=firingSumIn.firingSum) if nIn>0;
  PNlib.PN.Interfaces.RealConIn firingSum2Dis(value=firingSumOut.firingSum) if nOut>0;
  PNlib.PN.Interfaces.RealConIn firingSum3Dis(value=0) if nIn==0;
  PNlib.PN.Interfaces.RealConIn firingSum4Dis(value=0) if nOut==0;
  PNlib.PN.Interfaces.RealConOut firingSumInputDis;
  PNlib.PN.Interfaces.RealConOut firingSumOutputDis;
protected
  outer PNlib.PN.Components.Settings settings "global settings for animation and display";
  Real conMarkChange "continuous mark change";
  Real arcWeightInCon[nIn] "weights of input arcs";
  Real arcWeightOutCon[nOut] "weights of output arcs";
  Real instSpeedIn[nIn] "instantaneous speed of input transitions";
  Real instSpeedOut[nOut] "instantaneous speed of output transitions";
  Real maxSpeedIn[nIn] "maximum speed of input transitions";
  Real maxSpeedOut[nOut] "maximum speed of output transitions";
  Real prelimSpeedIn[nIn] "preliminary speed of input transitions";
  Real prelimSpeedOut[nOut] "preliminary speed of output transitions";
  Real t_(start=startMarks, fixed=true) "marking";
  Boolean preFireIn[nIn] "pre-value of fireIn";
  Boolean preFireOut[nOut] "pre-value of fireOut";
  Boolean fireInCon[nIn](each start=false, each fixed=true) "Does any input transition fire?";
  Boolean fireOutCon[nOut](each start=false, each fixed=true) "Does any output transition fire?";
  Boolean activeInCon[nIn] "Are the input transitions active?";
  Boolean activeOutCon[nOut] "Are the output transitions active?";
  // Discrete
  Real disMarkChange "discrete mark change";
  Real arcWeightInDis[nInDis] "Integer weights of input arcs";
  Real arcWeightOutDis[nOutDis] "Integer weights of output arcs";
  Boolean fireInDis[nInDis] "Do input transtions fire?";
  Boolean activeInDis[nInDis] "Are times passed of input transitions?";
  Boolean enabledByInPlaces[nInDis] "Are input transitions are enabled by all their input places?";
  Boolean fireOutDis[nOutDis] "Do output transitions fire?";
  Boolean activeOutDis[nOutDis](each start=false, each fixed=true) "Are time passed of output transitions?";
  //****BLOCKS BEGIN****// since no events are generated within functions!!!
  //Is the place fed by input transitions?
  PNlib.PN.Blocks.anyTrue feeding(vec=preFireIn);
  //Is the place emptied by output transitions?"
  PNlib.PN.Blocks.anyTrue emptying(vec=preFireOut);
  //firing sum calculation for Continuous
  PNlib.PN.Blocks.firingSumCon firingSumInCon(fire=preFireIn, arcWeight=arcWeightInCon, instSpeed=instSpeedIn);
  PNlib.PN.Blocks.firingSumCon firingSumOutCon(fire=preFireOut, arcWeight=arcWeightOutCon, instSpeed=instSpeedOut);
  PNlib.PN.Blocks.decreasingFactor decreasingFactorCon (nIn=nIn, nOut=nOut, t=t_, minMarks=minMarks, maxMarks=maxMarks, speedIn= firingSumInCon.conFiringSum, speedOut= firingSumOutCon.conFiringSum, maxSpeedIn=maxSpeedIn, maxSpeedOut=maxSpeedOut, prelimSpeedIn=prelimSpeedIn, prelimSpeedOut=prelimSpeedOut, arcWeightIn=arcWeightInCon, arcWeightOut=arcWeightOutCon, firingIn=fireInCon, firingOut=fireOutCon) if nIn>0 and nOut>0 ;
  //Does any time passed of a connected transition?
  PNlib.Blocks.anyTrue timePassedOut(vec=activeOutDis) if nOutDis>0;
  PNlib.Blocks.anyTrue timePassedIn(vec=activeInDis) if nInDis>0;
  //firing sum calculation for Discrete
  PN.Blocks.firingSumDis firingSumInDis(fire=fireInDis, arcWeight=arcWeightInDis) if nInDis>0;
  PN.Blocks.firingSumDis firingSumOutDis(fire=fireOutDis, arcWeight=arcWeightOutDis) if nOutDis>0;
  //Enabling process Prio
  PNlib.PN.Blocks.enablingOutConPrio enableOutPrio(timePassed=timePassedOut.anytrue, nOut=nOutDis, arcWeight=arcWeightOutDis, t=t_, minTokens=minTokens, TAout=activeOutDis, enablingPrio=enablingPrioOut) if (nOutDis>0 and enablingType==PNlib.Types.EnablingType.Priority);
  PNlib.PN.Blocks.enablingInConPrio enableInPrio(timePassed=timePassedIn.anytrue, active=activeInDis, nIn=nInDis, arcWeight=arcWeightInDis, t=t_, maxTokens=maxTokens, TAein=if nInDis>0 then enabledByInPlacesDis and activeInDis else fill(true, nOutDis), enablingPrio=enablingPrioIn) if (nInDis>0 and enablingType==PNlib.Types.EnablingType.Priority);
  //Does any discrete transition fire?
  PNlib.PN.Blocks.anyTrue disMarksOut(vec=fireOutDis);
  PNlib.PN.Blocks.anyTrue disMarksIn(vec=fireInDis);

//****BLOCKS END****//
equation
//decreasing factor calculation
  for i in 1:nIn loop
    connect(decFactorIn[i], decFactorIn1[i]);
    connect(decFactorIn[i], decFactorIn2[i]);
  end for;
  for i in 1:nOut loop
    connect(decFactorOut[i],decFactorOut1[i]);
    connect(decFactorOut[i],decFactorOut2[i]);
  end for;
//Discrete
  connect(disMarksInOut, disMarksInOut1);
  connect(disMarksInOut,disMarksInOut2);
  connect(disMarksInOut,disMarksInOut3);
  connect(disMarksInOut,disMarksInOut4);
for i in 1:nInDis loop
  connect(enableIn[i],PrioIn[i]);
end for;
for i in 1:nOutDis loop
  connect(enableOut[i],PrioOut[i]);
end for;
  connect(firingSumInputDis,firingSum1Dis);
  connect(firingSumInputDis,firingSum3Dis);
  connect(firingSumOutputDis,firingSum2Dis);
  connect(firingSumOutputDis,firingSum4Dis);
//calculation of continuous mark change
  conMarkChange = firingSumInCon.conFiringSum - firingSumOutCon.conFiringSum;
  der(t_)=conMarkChange;
  for i in 1:nOut loop
    preFireOut[i]=pre(fireOutCon[i]);
  end for;
  for i in 1:nIn loop
    preFireIn[i]= pre(fireInCon[i]);
  end for;
  t = noEvent(if t_ < minMarks then minMarks elseif t_ > maxMarks then maxMarks else t_);
//calculation of Discrete mark change
  disMarkChange = firingSumInputDis.value - firingSumOutputDis.value;
  when disMarksInOut.value then
    reinit(t_, t_ + pre(disMarkChange));
  end when;
//****MAIN END****//
//****ERROR MESSENGES BEGIN****//
  assert(startMarks >= minMarks and startMarks <= maxMarks, "minMarks<=startMarks<=maxMarks");
  assert(PNlib.Functions.OddsAndEnds.prioCheck(enablingPrioIn,nIn) or nIn==0, "The priorities of the input priorities may be given only once and must be selected from 1 to nIn");
  assert(PNlib.Functions.OddsAndEnds.prioCheck(enablingPrioOut,nOut) or nOut==0, "The priorities of the output priorities may be given only once and must be selected from 1 to nOut");
  assert(PNlib.Functions.OddsAndEnds.isEqual(sum(enablingProbIn), 1.0, 1e-6) or nIn==0 or enablingType==PNlib.Types.EnablingType.Priority, "The sum of input enabling probabilities has to be equal to 1");
  assert(PNlib.Functions.OddsAndEnds.isEqual(sum(enablingProbOut), 1.0, 1e-6) or nOut==0 or enablingType==PNlib.Types.EnablingType.Priority, "The sum of output enabling probabilities has to be equal to 1");
//****ERROR MESSENGES END****//
   annotation(defaultComponentName = "P1", Icon(graphics={
        Ellipse(
          extent={{-100, 98}, {100, -96}},
          lineColor={0, 0, 0},
          fillColor={255, 255, 255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-88, 86}, {88, -86}},
          lineColor={0, 0, 0},
          fillColor=DynamicSelect({255, 255, 255}, color),
          fillPattern=FillPattern.Solid),
      Text(
        extent={{-1.5, 25.5}, {-1.5, -21.5}},
        lineColor={0, 0, 0},
        origin={0.5, -0.5},
        rotation=0,
        textString=DynamicSelect("%startMarks", if animateMarking then if t>0 then realString(t, 1, 2) else "0.0" else " ")),
        Text(
          extent={{0, -130}, {0, -116}},
          lineColor={0, 0, 0},
          textString=DynamicSelect("Cmax=%maxTokens", "Cmax=%maxTokens")),
                  Text(
          extent={{0, -150}, {0, -136}},
          lineColor={0, 0, 0},
          textString=DynamicSelect("Cmin=%minTokens", "Cmin=%minTokens" )),
                                          Text(
          extent={{-0, 113}, {-0, 138}},
          lineColor={0, 0, 0},
          textString="%name")}),
  Diagram(graphics));
end PC;
