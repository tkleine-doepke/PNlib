within PNlib.PN.Components;
model TC "Continuous Transition"
  parameter Integer nIn(min=0)= 0 "number of input places" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nOut(min=0)= 0 "number of output places" annotation(Dialog(enable=true,group="Connector sizing"));
  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  Real maximumSpeed=1 "maximum speed" annotation(Dialog(enable = true, group = "Maximum Speed"));
  Real arcWeightIn[nIn]=fill(1, nIn) "arc weights of input places" annotation(Dialog(enable = true, group = "Arc Weights"));
  Real arcWeightOut[nOut]=fill(1, nOut) "arc weights of output places" annotation(Dialog(enable = true, group = "Arc Weights"));
  Boolean firingCon=true "Optinalonal firing condition" annotation(Dialog(enable = true, group = "Firing Condition"));
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//
  Boolean fire "Does the transition fire?";
  Real instantaneousSpeed "instantaneous speed";
  Real actualSpeed = if fire then instantaneousSpeed else 0.0;
protected
  Real prelimSpeed "preliminary speed";
  Real tIn[nIn] "tokens of input places";
  Real tOut[nOut] "tokens of output places";
  Real minTokens[nIn] "minimum tokens of input places";
  Real maxTokens[nOut] "maximum tokens of output places";
  Real speedSumIn[nIn] "Input speeds of continuous input places";
  Real speedSumOut[nOut] "Output speeds of continuous output places";
  Real decreasingFactorIn[nIn] "decreasing factors of input places";
  Real decreasingFactorOut[nOut] "decreasing factors of output places";
  Boolean fed[nIn] "Are the input places fed by their input transitions?";
  Boolean emptied[nOut] "Are the output places emptied by their output transitions?";
  //****BLOCKS BEGIN****// since no events are generated within functions!!!
  //activation process
  PNlib.PN.Blocks.activationCon activation(nIn=nIn, nOut=nOut, tIn=tIn, tOut=tOut, arcWeightIn=arcWeightIn, arcWeightOut=arcWeightOut, minTokens=minTokens, maxTokens=maxTokens, firingCon=firingCon, fed=fed, emptied=emptied);
  //firing process
  //Boolean fire_ = PNlib.Functions.OddsAndEnds.allTrue(/* hack for Dymola 2017 */ PNlib.Functions.OddsAndEnds.boolOr(enableIn, not disPlaceIn));
  //****BLOCKS END****//
public
  PNlib.PN.Interfaces.ConTransitionIn[nIn] inPlaces(
    each active=activation.active,
    each fire=fire,
    arcWeight=arcWeightIn,
    each instSpeed = instantaneousSpeed,
    each prelimSpeed = prelimSpeed,
    each maxSpeed =  maximumSpeed,
    t=tIn,
    minTokens=minTokens,
    fed=fed,
    speedSum=speedSumIn,
    decreasingFactor=decreasingFactorIn) if nIn > 0 "connector for input places" annotation(Placement(transformation(extent={{ -56, -10}, {-40, 10}}, rotation=0)));
  PNlib.PN.Interfaces.ConTransitionOut[nOut] outPlaces(
    each active=activation.active,
    each fire=fire,
    arcWeight=arcWeightOut,
    each instSpeed = instantaneousSpeed,
    each prelimSpeed = prelimSpeed,
    each maxSpeed =  maximumSpeed,
    t=tOut,
    maxTokens=maxTokens,
    emptied=emptied,
    speedSum=speedSumOut,
    decreasingFactor=decreasingFactorOut) if nOut > 0  "connector for output places" annotation(Placement(transformation(extent={{40, -10}, {56, 10}}, rotation=0)));
equation
  //****MAIN BEGIN****//
  //preliminary speed calculation
  prelimSpeed = PNlib.PN.Functions.preliminarySpeed(nIn=nIn, nOut=nOut, arcWeightIn=arcWeightIn, arcWeightOut=arcWeightOut, speedSumIn=speedSumIn, speedSumOut=speedSumOut, maximumSpeed=maximumSpeed, weaklyInputActiveVec=activation.weaklyInputActiveVec, weaklyOutputActiveVec=activation.weaklyOutputActiveVec);
  //firing process
  fire=activation.active and not maximumSpeed<=0;
  //instantaneous speed calculation
  instantaneousSpeed=min(min(min(decreasingFactorIn), min(decreasingFactorOut))*maximumSpeed, prelimSpeed);
  //****MAIN END****//
  //****ERROR MESSENGES BEGIN****//  hier noch Message gleiches Kantengewicht und auch Kante dis Place!!
  for i in 1:nIn loop
    assert(arcWeightIn[i]>=0, "Input arc weights must be positive.");
  end for;
  for i in 1:nOut loop
    assert(arcWeightOut[i]>=0, "Output arc weights must be positive.");
  end for;
  //****ERROR MESSENGES END****//
  annotation(defaultComponentName = "T1",
   Icon(graphics={Rectangle(extent={{-40, 100}, {40, -100}},
    lineColor={0, 0, 0},
     fillColor=DynamicSelect({255, 255, 255}, color),
      fillPattern=FillPattern.Solid),
       Text(
          extent={{-2, -116}, {-2, -144}},
          lineColor={0, 0, 0},
          textString=DynamicSelect("vmax=%maximumSpeed ", if animateSpeed then "vmax=%maximumSpeed " else " ")),
      Text(
          extent={{-2, -156}, {-2, -184}},
          lineColor={0, 0, 0},
          textString=DynamicSelect(" ", if animateSpeed and fire then if instantaneousSpeed>0 then "vakt="+realString(instantaneousSpeed, 1, 2) else "vakt=0.0" else " ")),
      Text(
          extent={{-4, 139}, {-4, 114}},
          lineColor={0, 0, 0},
          textString="%name")}));
end TC;
