within PNlib.PN.Components;
model TD "Discrete Transition with delay "
  parameter Integer nIn = 0 "number of input places" annotation(Dialog(connectorSizing=true));
  parameter Integer nOut = 0 "number of output places" annotation(Dialog(connectorSizing=true));
  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter PNlib.Types.TimeType timeType=PNlib.Types.TimeType.Delay;
  Real delay = 1 "delay of timed transition" annotation(Dialog(enable = if timeType==PNlib.Types.TimeType.Delay then true else false, group = "Discrete Time Concept"));
  Real duration = 1 "duration of timed transition" annotation(Dialog(enable = if timeType==PNlib.Types.TimeType.FireDuration then true else false, group = "Discrete Time Concept"));
  Real event[:] = {1,2,3} "Event time of timed transition" annotation(Dialog(enable = if timeType==PNlib.Types.TimeType.Event then true else false, group = "Discrete Time Concept"));
  parameter Real tactIntervall = 1 "tact intervall of timed transition" annotation(Dialog(enable = if timeType==PNlib.Types.TimeType.Tact then true else false, group = "Discrete Time Concept"));
  parameter Real tactStart = 1 "tact start of timed transition" annotation(Dialog(enable = if timeType==PNlib.Types.TimeType.Tact then true else false, group = "Discrete Time Concept"));
  annotation(Dialog(enable = if timeType==PNlib.Types.TimeType.Delay then true else false, group = "Discrete Time Concept"));
  Integer arcWeightIntIn[nIn] = fill(1, nIn) "arc weights of input places" annotation(Dialog(enable = true, group = "Arc Weights"));
  Integer arcWeightIntOut[nOut] = fill(1, nOut) "arc weights of output places" annotation(Dialog(enable = true, group = "Arc Weights"));
  Boolean firingCon=true "additional firing condition" annotation(Dialog(enable = true, group = "Firing Condition"));
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//
protected
  //Real firingTime "next putative firing time";
  //Real delay_ = if delay < 1e-6 then 1e-6 else delay "due to event problems if delay==0";
  Integer tIntIn[nIn] "integer tokens of input places (for generating events!)";
  Integer tIntOut[nOut]
    "integer tokens of output places (for generating events!)";
  Integer minTokensInt[nIn]
    "Integer minimum tokens of input places (for generating events!)";
  Integer maxTokensInt[nOut]
    "Integer maximum tokens of output places (for generating events!)";
  Boolean enableIn[nIn] "Is the transition enabled by input places?";
  Boolean enableOut[nOut] "Is the transition enabled by output places?";
  //Boolean delayPassed(start=false, fixed=true) "Is the delay passed?";

  //****BLOCKS BEGIN****// since no events are generated within functions!!!
  //activation process
  //PN.Blocks.activationDis activation(nIn=nIn, nOut=nOut, tIntIn=tIntIn, tIntOut=tIntOut, arcWeightIntIn=arcWeightIntIn, arcWeightIntOut=arcWeightIntOut, minTokensInt=minTokensInt, maxTokensInt=maxTokensInt, firingCon=firingCon);

  PN.Blocks.activationDisIn activationIn(nIn=nIn, tIntIn=tIntIn, arcWeightIntIn=arcWeightIntIn, minTokensInt=minTokensInt, firingCon=firingCon);
  PN.Blocks.activationDisOut activationOut(nOut=nOut, tIntOut=tIntOut, arcWeightIntOut=arcWeightIntOut, maxTokensInt=maxTokensInt, firingCon=firingCon);

  PN.Blocks.delay fireDelay (nIn=nIn, nOut=nOut, delay=delay, active=activationIn.active and activationOut.active, firingCon=firingCon, enabledIn=enabledIn.value, enabledOut=enabledOut.value) if  timeType==PNlib.Types.TimeType.Delay;
  PN.Blocks.duration fireDuration (nIn=nIn, nOut=nOut, duration=duration, activeIn=activationIn.active, activeOut=activationOut.active, firingCon=firingCon, enabledIn=enabledIn.value, enabledOut=enabledOut.value) if  timeType==PNlib.Types.TimeType.FireDuration;
  //Is the transition enabled by all input places?
  //Boolean enabledByInPlaces = PNlib.Functions.OddsAndEnds.allTrue(enableIn) if nIn>0;
   //Is the transition enabled by all output places?
  //Boolean enabledByOutPlaces = PNlib.Functions.OddsAndEnds.allTrue(enableOut) if nOut>0;
  //****BLOCKS END****//
public
  //Boolean active "Is the transition active?";
  //Boolean fire "Does the transition fire?";
  PNlib.PN.Interfaces.DisTransitionIn inPlacesDis[nIn](
    each active=timePassedIn.value,
    arcWeightint=arcWeightIntIn,
    each fire=fireIn.value,
    tint=tIntIn,
    minTokensint=minTokensInt,
    enable=enableIn) if nIn > 0 "connector for input places" annotation(Placement(transformation(extent={{-56, -10}, {-40, 10}}, rotation=0)));
  PNlib.PN.Interfaces.DisTransitionOut outPlacesDis[nOut](
    each active=timePassedOut.value,
    arcWeightint=arcWeightIntOut,
    each fire=fireOut.value,
    each enabledByInPlaces=if nIn>0 and not timeType==PNlib.Types.TimeType.FireDuration then enabledIn else true,
    tint=tIntOut,
    maxTokensint=maxTokensInt,
    enable=enableOut) if nOut > 0 "connector for output places" annotation(Placement(transformation(extent={{40, -10}, {56, 10}}, rotation=0)));
  // Enable
    PNlib.PN.Interfaces.BooleanCon enabledIn1(value=PNlib.Functions.OddsAndEnds.allTrue(enableIn)) if nIn>0;
    PNlib.PN.Interfaces.BooleanCon enabledOut1(value=PNlib.Functions.OddsAndEnds.allTrue(enableOut)) if nOut>0;
    PNlib.PN.Interfaces.BooleanCon enabledIn2(value=false) if nIn==0;
    PNlib.PN.Interfaces.BooleanCon enabledOut2(value=false) if nOut==0;
    PNlib.PN.Interfaces.BooleanCon enabledIn;
    PNlib.PN.Interfaces.BooleanCon enabledOut;
  // Delay
    PNlib.PN.Interfaces.BooleanCon fireInDelay(value=fireDelay.fire) if  timeType==PNlib.Types.TimeType.Delay;
    PNlib.PN.Interfaces.BooleanCon fireOutDelay(value=fireDelay.fire) if  timeType==PNlib.Types.TimeType.Delay;
    PNlib.PN.Interfaces.BooleanCon timePassedInDelay(value=fireDelay.delayPassed) if  timeType==PNlib.Types.TimeType.Delay;
    PNlib.PN.Interfaces.BooleanCon timePassedOutDelay(value=fireDelay.delayPassed) if  timeType==PNlib.Types.TimeType.Delay;
  // Duration
    PNlib.PN.Interfaces.BooleanCon fireInDuration(value=fireDuration.fireIn) if  timeType==PNlib.Types.TimeType.FireDuration;
    PNlib.PN.Interfaces.BooleanCon fireOutDuration(value=fireDuration.fireOut) if  timeType==PNlib.Types.TimeType.FireDuration;
    PNlib.PN.Interfaces.BooleanCon timePassedInDuration(value=fireDuration.durationPassedIn) if  timeType==PNlib.Types.TimeType.FireDuration;
    PNlib.PN.Interfaces.BooleanCon timePassedOutDuration(value=fireDuration.durationPassedOut) if  timeType==PNlib.Types.TimeType.FireDuration;
  // Dummy
    PNlib.PN.Interfaces.BooleanCon fireIn;
    PNlib.PN.Interfaces.BooleanCon fireOut;
    PNlib.PN.Interfaces.BooleanCon timePassedIn;
    PNlib.PN.Interfaces.BooleanCon timePassedOut;
equation
// Enable
  connect(enabledIn,enabledIn1);
  connect(enabledIn,enabledIn2);
  connect(enabledOut,enabledOut1);
  connect(enabledOut,enabledOut2);
// Delay
  connect(fireIn,fireInDelay);
  connect(fireOut,fireOutDelay);
  connect(timePassedIn,timePassedInDelay);
  connect(timePassedOut,timePassedOutDelay);
// Duration
  connect(fireIn,fireInDuration);
  connect(fireOut,fireOutDuration);
  connect(timePassedIn,timePassedInDuration);
  connect(timePassedOut,timePassedOutDuration);
   //****ERROR MESSENGES BEGIN****//
   for i in 1:nIn loop
      assert(arcWeightIntIn[i]>=0, "Input arc weights must be positive.");
   end for;
   for i in 1:nOut loop
      assert(arcWeightIntOut[i]>=0, "Output arc weights must be positive.");
   end for;
   //****ERROR MESSENGES END****//

  annotation(defaultComponentName = "T1", Icon(graphics={Rectangle(
          extent={{-40, 100}, {40, -100}},
          lineColor={0, 0, 0},
        fillColor={0, 0, 0},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-2, -112}, {-2, -140}},
          lineColor={0, 0, 0},
          textString=DynamicSelect("d=%delay","d=%delay")),
                                          Text(
          extent={{-4, 139}, {-4, 114}},
          lineColor={0, 0, 0},
          textString="%name")}), Diagram(graphics));
end TD;
