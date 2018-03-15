within PNlib.PN.Components;
model TD "Discrete Transition with delay "
  parameter Integer nIn = 0 "number of input places" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nOut = 0 "number of output places" annotation(Dialog(enable=true,group="Connector sizing"));
  parameter Integer nInExt = 0 "number of input places" annotation(Dialog(enable=true,group="Connector sizing"));
  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter PNlib.Types.TimeType timeType=PNlib.Types.TimeType.Delay;
  parameter Real timeValue [:] = {1} "time Value of transition" annotation(Dialog(enable = true, group = "Discrete Time Concept"));
  Integer arcWeightIntIn[nIn] = fill(1, nIn) "arc weights of input places" annotation(Dialog(enable = true, group = "Arc Weights"));
  Integer arcWeightIntOut[nOut] = fill(1, nOut) "arc weights of output places" annotation(Dialog(enable = true, group = "Arc Weights"));
  Boolean firingCon=true "additional firing condition" annotation(Dialog(enable = true, group = "Firing Condition"));
  Boolean active;
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
  Boolean extendedCondition[nInExt] "Is the extended Arc Condition true?";
  Boolean allExtendedCondition =PNlib.Functions.OddsAndEnds.allTrue(extendedCondition) "Are all the extended Arc Condition true?" ;
  //Boolean delayPassed(start=false, fixed=true) "Is the delay passed?";

  //****BLOCKS BEGIN****// since no events are generated within functions!!!
  //activation process
  //PN.Blocks.activationDis activation(nIn=nIn, nOut=nOut, tIntIn=tIntIn, tIntOut=tIntOut, arcWeightIntIn=arcWeightIntIn, arcWeightIntOut=arcWeightIntOut, minTokensInt=minTokensInt, maxTokensInt=maxTokensInt, firingCon=firingCon);

  PN.Blocks.activationDisIn activationIn(nIn=nIn, tIntIn=tIntIn, arcWeightIntIn=arcWeightIntIn, minTokensInt=minTokensInt, firingCon=firingCon);
  PN.Blocks.activationDisOut activationOut(nOut=nOut, tIntOut=tIntOut, arcWeightIntOut=arcWeightIntOut, maxTokensInt=maxTokensInt, firingCon=firingCon);

  PN.Blocks.delay fireDelay (nIn=nIn, nOut=nOut, delay=timeValue[1], active=active and allExtendedCondition, firingCon=firingCon, enabledIn=enabledIn.value, enabledOut=enabledOut.value) if  timeType==PNlib.Types.TimeType.Delay;
  PN.Blocks.duration fireDuration (nIn=nIn, nOut=nOut, duration=timeValue[1], activeIn=activationIn.active, activeOut=activationOut.active, firingCon=firingCon, enabledIn=enabledIn.value, enabledOut=enabledOut.value) if  timeType==PNlib.Types.TimeType.FireDuration;
  PN.Blocks.event fireEvent (nIn=nIn, nOut=nOut, event=timeValue, active=active, firingCon=firingCon, enabledIn=enabledIn.value, enabledOut=enabledOut.value) if  timeType==PNlib.Types.TimeType.Event;
  PN.Blocks.tact fireTact (nIn=nIn, nOut=nOut, tactTime=timeValue, active=active, firingCon=firingCon, enabledIn=enabledIn.value, enabledOut=enabledOut.value) if  timeType==PNlib.Types.TimeType.Tact;
  PN.Blocks.immediate fireImmediate (nIn=nIn, nOut=nOut, active=active, firingCon=firingCon, enabledIn=enabledIn.value, enabledOut=enabledOut.value) if  timeType==PNlib.Types.TimeType.Immediate;
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
    each enabledByInPlaces=if nIn>0 and not timeType==PNlib.Types.TimeType.FireDuration then enabledIn.value else true,
    tint=tIntOut,
    maxTokensint=maxTokensInt,
    enable=enableOut) if nOut > 0 "connector for output places" annotation(Placement(transformation(extent={{40, -10}, {56, 10}}, rotation=0)));
  PNlib.PN.Interfaces.TransitionInExt extIn[nInExt](
        condition=extendedCondition) if nInExt > 0 "connector for output extended Arcs" annotation(Placement(transformation(extent={{-56, 80}, {-40, 100}}, rotation =0)));
  // Enable
    PNlib.PN.Interfaces.BooleanConIn enabledIn1(value=PNlib.Functions.OddsAndEnds.allTrue(enableIn)) if nIn>0;
    PNlib.PN.Interfaces.BooleanConIn enabledOut1(value=PNlib.Functions.OddsAndEnds.allTrue(enableOut)) if nOut>0;
    PNlib.PN.Interfaces.BooleanConIn enabledIn2(value=false) if nIn==0;
    PNlib.PN.Interfaces.BooleanConIn enabledOut2(value=false) if nOut==0;
    PNlib.PN.Interfaces.BooleanConOut enabledIn;
    PNlib.PN.Interfaces.BooleanConOut enabledOut;
  // Delay
    PNlib.PN.Interfaces.BooleanConIn fireInDelay(value=fireDelay.fire) if  timeType==PNlib.Types.TimeType.Delay;
    PNlib.PN.Interfaces.BooleanConIn fireOutDelay(value=fireDelay.fire) if  timeType==PNlib.Types.TimeType.Delay;
    PNlib.PN.Interfaces.BooleanConIn timePassedInDelay(value=fireDelay.delayPassed) if  timeType==PNlib.Types.TimeType.Delay;
    PNlib.PN.Interfaces.BooleanConIn timePassedOutDelay(value=fireDelay.delayPassed) if  timeType==PNlib.Types.TimeType.Delay;
  // Duration
    PNlib.PN.Interfaces.BooleanConIn fireInDuration(value=fireDuration.fireIn) if  timeType==PNlib.Types.TimeType.FireDuration;
    PNlib.PN.Interfaces.BooleanConIn fireOutDuration(value=fireDuration.fireOut) if  timeType==PNlib.Types.TimeType.FireDuration;
    PNlib.PN.Interfaces.BooleanConIn timePassedInDuration(value=fireDuration.durationPassedIn) if  timeType==PNlib.Types.TimeType.FireDuration;
    PNlib.PN.Interfaces.BooleanConIn timePassedOutDuration(value=fireDuration.durationPassedOut) if  timeType==PNlib.Types.TimeType.FireDuration;
    PNlib.PN.Interfaces.BooleanConIn TransitionDurationFire (value=fireDuration.fire) if  timeType==PNlib.Types.TimeType.FireDuration;
  // Event
    PNlib.PN.Interfaces.BooleanConIn fireInEvent(value=fireEvent.fire) if  timeType==PNlib.Types.TimeType.Event;
    PNlib.PN.Interfaces.BooleanConIn fireOutEvent(value=fireEvent.fire) if  timeType==PNlib.Types.TimeType.Event;
    PNlib.PN.Interfaces.BooleanConIn timePassedInEvent(value=fireEvent.eventPassed) if  timeType==PNlib.Types.TimeType.Event;
    PNlib.PN.Interfaces.BooleanConIn timePassedOutEvent(value=fireEvent.eventPassed) if  timeType==PNlib.Types.TimeType.Event;
  // Event
    PNlib.PN.Interfaces.BooleanConIn fireInTact(value=fireTact.fire) if  timeType==PNlib.Types.TimeType.Tact;
    PNlib.PN.Interfaces.BooleanConIn fireOutTact(value=fireTact.fire) if  timeType==PNlib.Types.TimeType.Tact;
    PNlib.PN.Interfaces.BooleanConIn timePassedInTact(value=fireTact.tactPassed) if  timeType==PNlib.Types.TimeType.Tact;
    PNlib.PN.Interfaces.BooleanConIn timePassedOutTact(value=fireTact.tactPassed) if  timeType==PNlib.Types.TimeType.Tact;
  // Immediate
    PNlib.PN.Interfaces.BooleanConIn fireInImmediate(value=fireImmediate.fire) if  timeType==PNlib.Types.TimeType.Immediate;
    PNlib.PN.Interfaces.BooleanConIn fireOutImmediate(value=fireImmediate.fire) if  timeType==PNlib.Types.TimeType.Immediate;
    PNlib.PN.Interfaces.BooleanConIn timePassedInImmediate(value=fireImmediate.Passed) if  timeType==PNlib.Types.TimeType.Immediate;
    PNlib.PN.Interfaces.BooleanConIn timePassedOutImmediate(value=fireImmediate.Passed) if  timeType==PNlib.Types.TimeType.Immediate;
  // Dummy
    PNlib.PN.Interfaces.BooleanConOut fireIn;
    PNlib.PN.Interfaces.BooleanConOut fireOut;
    PNlib.PN.Interfaces.BooleanConOut timePassedIn;
    PNlib.PN.Interfaces.BooleanConOut timePassedOut;
equation
  active=activationIn.active and activationOut.active and allExtendedCondition;
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
// Event
  connect(fireIn,fireInEvent);
  connect(fireOut,fireOutEvent);
  connect(timePassedIn,timePassedInEvent);
  connect(timePassedOut,timePassedOutEvent);
// Tact
  connect(fireIn,fireInTact);
  connect(fireOut,fireOutTact);
  connect(timePassedIn,timePassedInTact);
  connect(timePassedOut,timePassedOutTact);
// Immediate
  connect(fireIn,fireInImmediate);
  connect(fireOut,fireOutImmediate);
  connect(timePassedIn,timePassedInImmediate);
  connect(timePassedOut,timePassedOutImmediate);

   //****ERROR MESSENGES BEGIN****//
   for i in 1:nIn loop
      assert(arcWeightIntIn[i]>=0, "Input arc weights must be positive.");
   end for;
   for i in 1:nOut loop
      assert(arcWeightIntOut[i]>=0, "Output arc weights must be positive.");
   end for;

   if timeType==PNlib.Types.TimeType.Delay then
      assert(size(timeValue,1)==1, "Only one Value at timeValue for Delay");
   elseif timeType==PNlib.Types.TimeType.FireDuration then
      assert(size(timeValue,1)==1, "Only one Value at timeValue for Fire Duration");
   elseif timeType==PNlib.Types.TimeType.Event then
      assert(PNlib.Functions.OddsAndEnds.eventCheck(timeValue), "The event times must be greater than zero and must be specified in a larger order at timeValue");
   elseif timeType==PNlib.Types.TimeType.Tact then
     assert(size(timeValue,1)==2, "Exact two Values at timeValue for Tact");
   else
     assert(size(timeValue,1)==1 and timeValue[1]==0, "Only one Value at timeValue for Delay");
   end if;

   //****ERROR MESSENGES END****//

  annotation(defaultComponentName = "T1", Icon(graphics={Rectangle(
          extent={{-40, 100}, {40, -100}},
          lineColor={0, 0, 0},
        fillColor={0, 0, 0},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-2, -112}, {-2, -140}},
          lineColor={0, 0, 0},
          textString=DynamicSelect("%timeType","%timeType")),
        Text(
          extent={{-2, -152}, {-2, -180}},
          lineColor={0, 0, 0},
          textString=DynamicSelect("%timeValue","%timeValue")),
        Text(
          extent={{-4, 139}, {-4, 114}},
          lineColor={0, 0, 0},
          textString="%name")}), Diagram(graphics));

end TD;
