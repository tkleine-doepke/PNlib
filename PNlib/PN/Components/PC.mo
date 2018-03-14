within PNlib.PN.Components;
model PC "Continuous Place"
  Real t "marking";
  parameter Integer nIn(min=0)= 0 "number of input transitions" annotation(Dialog(enable=true,group="Connector sizing"));
parameter Integer nOut(min=0)= 0 "number of output transitions" annotation(Dialog(enable=true,group="Connector sizing"));
  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter Real startMarks = 0 "start marks" annotation(Dialog(enable = true, group = "Marks"));
  parameter Real minMarks = 0 "minimum capacity" annotation(Dialog(enable = true, group = "Marks"));
  parameter Real maxMarks=PNlib.Constants.inf "maximum capacity" annotation(Dialog(enable = true, group = "Marks"));
  parameter Boolean showTokenFlow=false;
  parameter PNlib.Types.EnablingType enablingType=PNlib.Types.EnablingType.Priority
    "resolution type of actual conflict (type-1-conflict)" annotation(Dialog(enable = true, group = "Enabling"));
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//

  PNlib.PN.Blocks.tokenFlowCon tokenFlow(nIn=nIn, nOut=nOut, conFiringSumIn=firingSumIn.conFiringSum, conFiringSumOut=firingSumOut.conFiringSum, fireIn=fireIn, fireOut=fireOut, arcWeightIn=arcWeightIn, arcWeightOut=arcWeightOut, instSpeedIn=instSpeedIn, instSpeedOut=instSpeedOut) if showTokenFlow;
  parameter Integer localSeedIn = PNlib.Functions.Random.counter() "Local seed to initialize random number generator for input conflicts" annotation(Dialog(enable = true, group = "Random Number Generator"));
  parameter Integer localSeedOut = PNlib.Functions.Random.counter() "Local seed to initialize random number generator for output conflicts" annotation(Dialog(enable = true, group = "Random Number Generator"));
protected
  outer PNlib.PN.Components.Settings settings "global settings for animation and display";
  Real conMarkChange "continuous mark change";
  Real arcWeightIn[nIn] "weights of input arcs";
  Real arcWeightOut[nOut] "weights of output arcs";
  Real instSpeedIn[nIn] "instantaneous speed of input transitions";
  Real instSpeedOut[nOut] "instantaneous speed of output transitions";
  Real maxSpeedIn[nIn] "maximum speed of input transitions";
  Real maxSpeedOut[nOut] "maximum speed of output transitions";
  Real prelimSpeedIn[nIn] "preliminary speed of input transitions";
  Real prelimSpeedOut[nOut] "preliminary speed of output transitions";
  Real t_(start=startMarks, fixed=true) "marking";
  Boolean preFireIn[nIn] "pre-value of fireIn";
  Boolean preFireOut[nOut] "pre-value of fireOut";
  Boolean fireIn[nIn](each start=false, each fixed=true) "Does any input transition fire?";
  Boolean fireOut[nOut](each start=false, each fixed=true) "Does any output transition fire?";
  Boolean activeIn[nIn] "Are the input transitions active?";
  Boolean activeOut[nOut] "Are the output transitions active?";
  //****BLOCKS BEGIN****// since no events are generated within functions!!!
  //Is the place fed by input transitions?
  PNlib.PN.Blocks.anyTrue feeding(vec=preFireIn);
  //Is the place emptied by output transitions?"
  PNlib.PN.Blocks.anyTrue emptying(vec=preFireOut);
  //firing sum calculation
  PNlib.PN.Blocks.firingSumCon firingSumIn(fire=preFireIn, arcWeight=arcWeightIn, instSpeed=instSpeedIn);
  PNlib.PN.Blocks.firingSumCon firingSumOut(fire=preFireOut, arcWeight=arcWeightOut, instSpeed=instSpeedOut);
  //****BLOCKS END****//
  Real decFactorIn[nIn] "decreasing factors for input transitions";
  Real decFactorOut[nOut] "decreasing factors for output transitions";
public
  PNlib.PN.Interfaces.ConPlaceIn inTransition[nIn](
  each t=t_,
  each maxTokens=maxMarks,
  each emptied = emptying.anytrue,
  decreasingFactor = decFactorIn,
  each speedSum= firingSumOut.conFiringSum,
  fire=fireIn,
  active=activeIn,
  arcWeight=arcWeightIn,
  instSpeed=instSpeedIn,
  maxSpeed=maxSpeedIn,
  prelimSpeed=prelimSpeedIn) if nIn > 0 "connector for input transitions" annotation(Placement(
        transformation(extent={{-114, -10}, {-98, 10}}, rotation=0),
    iconTransformation(extent={{-116, -10}, {-100, 10}})));
  PNlib.PN.Interfaces.ConPlaceOut outTransition[nOut](
  each t = t_,
  each minTokens=minMarks,
  each fed=feeding.anytrue,
  decreasingFactor=decFactorOut,
  each speedSum=firingSumIn.conFiringSum,
  fire=fireOut,
  active=activeOut,
  arcWeight=arcWeightOut,
  instSpeed=instSpeedOut,
  maxSpeed=maxSpeedOut,
  prelimSpeed=prelimSpeedOut) if nOut > 0 "connector for output transitions" annotation(Placement(
        transformation(extent={{100, -10}, {116, 10}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput pc_t=t
    "connector for Simulink connection" annotation(Placement(
        transformation(extent={{-36, 68}, {-16, 88}}), iconTransformation(
        extent={{-10, -10}, {10, 10}},
        rotation=90,
        origin={0, 108})));
equation
  //decreasing factor calculation
  (decFactorIn, decFactorOut) = PNlib.PN.Functions.decreasingFactor(nIn=nIn, nOut=nOut, t=t_, minMarks=minMarks, maxMarks=maxMarks, speedIn= firingSumIn.conFiringSum, speedOut= firingSumOut.conFiringSum, maxSpeedIn=maxSpeedIn, maxSpeedOut=maxSpeedOut, prelimSpeedIn=prelimSpeedIn, prelimSpeedOut=prelimSpeedOut, arcWeightIn=arcWeightIn, arcWeightOut=arcWeightOut, firingIn=fireIn, firingOut=fireOut);
  //calculation of continuous mark change
  conMarkChange=firingSumIn.conFiringSum-firingSumOut.conFiringSum;
  der(t_)=conMarkChange;

  for i in 1:nOut loop
    preFireOut[i]=pre(fireOut[i]);
  end for;
  for i in 1:nIn loop
    preFireIn[i]= pre(fireIn[i]);
  end for;
  t = noEvent(if t_ < minMarks then minMarks elseif t_ > maxMarks then maxMarks else t_);
  //****MAIN END****//
  //****ERROR MESSENGES BEGIN****//
  assert(startMarks>=minMarks and startMarks<=maxMarks, "minMarks<=startMarks<=maxMarks");
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
          extent={{-74, -103}, {-74, -128}},
          lineColor={0, 0, 0},
          textString="%name")}),
  Diagram(graphics));
end PC;
