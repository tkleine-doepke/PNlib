within PNlib.CPN;
model TD "Discrete Transition with delay "
  parameter Integer nIn = 0 "number of input places" annotation(Dialog(connectorSizing=true));
  parameter Integer nOut = 0 "number of output places" annotation(Dialog(connectorSizing=true));
  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  Real delay = 1 "delay of timed transition" annotation(Dialog(enable = true, group = "Delay"));
  Integer arcWeightIntIn[nIn] = fill(1, nIn) "arc weights of input places" annotation(Dialog(enable = true, group = "Arc Weights"));
  Integer arcWeightIntOut[nOut] = fill(1, nOut) "arc weights of output places" annotation(Dialog(enable = true, group = "Arc Weights"));
  Boolean firingCon=true "additional firing condition" annotation(Dialog(enable = true, group = "Firing Condition"));
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//
protected
  outer PNlib.Settings settings "global settings for animation and display";
  Boolean showTransitionName=settings.showTransitionName "only for transition animation and display (Do not change!)";
  Boolean showDelay=settings.showTime "only for transition animation and display (Do not change!)";
  Real color[3] "only for transition animation and display (Do not change!)";
  Real firingTime "next putative firing time";
  Real fireTime "for transition animation";
  Real delay_ = if delay < 1e-6 then 1e-6 else delay "due to event problems if delay==0";
  Integer tIntIn[nIn] "integer tokens of input places (for generating events!)";
  Integer tIntOut[nOut]
    "integer tokens of output places (for generating events!)";
  PNlib.Types.ArcType arcType[nIn]
    "type of input arcs 1=normal, 2=real test arc,  3=test arc, 4=real inhibitor arc, 5=inhibitor arc, 6=read arc";
  Integer minTokensInt[nIn]
    "Integer minimum tokens of input places (for generating events!)";
  Integer maxTokensInt[nOut]
    "Integer maximum tokens of output places (for generating events!)";
  Integer testValueInt[nIn]
    "Integer test values of input arcs (for generating events!)";
  Boolean normalArc[nIn]
    "1=no, 2=yes, i.e. double arc: test and normal arc or inhibitor and normal arc";
  Boolean enableIn[nIn] "Is the transition enabled by input places?";
  Boolean enableOut[nOut] "Is the transition enabled by output places?";
  Boolean delayPassed(start=false, fixed=true) "Is the delay passed?";
  Boolean ani "for transition animation";

  //****BLOCKS BEGIN****// since no events are generated within functions!!!
  //activation process
  CPN.Blocks.activationDis activation(testValueInt=testValueInt, normalArc=normalArc, nIn=nIn, nOut=nOut, tIntIn=tIntIn, tIntOut=tIntOut, arcType=arcType,  arcWeightIntIn=arcWeightIntIn, arcWeightIntOut=arcWeightIntOut, minTokensInt=minTokensInt, maxTokensInt=maxTokensInt, firingCon=firingCon);
  //Is the transition enabled by all input places?
  Boolean enabledByInPlaces = PNlib.Functions.OddsAndEnds.allTrue(enableIn);
   //Is the transition enabled by all output places?
  Boolean enabledByOutPlaces = PNlib.Functions.OddsAndEnds.allTrue(enableOut);
  //****BLOCKS END****//
public
  Boolean active "Is the transition active?";
  Boolean fire "Does the transition fire?";
  PNlib.CPN.Interfaces.TransitionIn inPlaces[nIn](
    each active=delayPassed,
    arcWeightint=arcWeightIntIn,
    each fire=fire,
    tint=tIntIn,
    arcType=arcType,
    minTokensint=minTokensInt,
    enable=enableIn,
    testValueint=testValueInt,
    normalArc=normalArc) if nIn > 0 "connector for input places" annotation(Placement(transformation(extent={{-56, -10}, {-40, 10}}, rotation=0)));
  PNlib.CPN.Interfaces.TransitionOut outPlaces[nOut](
    each active=delayPassed,
    arcWeightint=arcWeightIntOut,
    each fire=fire,
    each enabledByInPlaces=enabledByInPlaces,
    tint=tIntOut,
    maxTokensint=maxTokensInt,
    enable=enableOut) if nOut > 0 "connector for output places" annotation(Placement(transformation(extent={{40, -10}, {56, 10}}, rotation=0)));
equation
  //****MAIN BEGIN****//
   //reset active when delay passed
   active = activation.active and not pre(delayPassed);
   //save next putative firing time
   when active then
      firingTime = time + delay_;
   end when;
   //delay passed?
   delayPassed= active and time>=firingTime;
   //firing process
   fire=if nOut==0 then enabledByInPlaces else enabledByOutPlaces;
   //****MAIN END****//
    //****ANIMATION BEGIN****//
    when fire then
     fireTime=time;
     ani=true;
   end when;
   color=if (fireTime+settings.timeFire>=time and settings.animateTransition and ani) then {255, 255, 0} else {0, 0, 0};
   //****ANIMATION END****//
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
        fillColor=DynamicSelect({0, 0, 0}, color),
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-2, -112}, {-2, -140}},
          lineColor={0, 0, 0},
          textString=DynamicSelect("d=%delay", if showTime then "d=%delay" else " ")),
                                          Text(
          extent={{-4, 139}, {-4, 114}},
          lineColor={0, 0, 0},
          textString="%name")}), Diagram(graphics));
end TD;
