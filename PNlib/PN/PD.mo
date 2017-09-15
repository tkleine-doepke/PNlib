within PNlib.PN;
model PD "Discrete Place"
  discrete Integer t(start = startTokens, fixed=true) "marking";
  parameter Integer nIn=0 "number of input transitions" annotation(Dialog(connectorSizing=true));
  parameter Integer nOut=0 "number of output transitions" annotation(Dialog(connectorSizing=true));
  //****MODIFIABLE PARAMETERS AND VARIABLES BEGIN****//
  parameter Integer startTokens = 0 "start tokens" annotation(Dialog(enable = true, group = "Tokens"));
  parameter Integer minTokens = 0 "minimum capacity" annotation(Dialog(enable = true, group = "Tokens"));
  parameter Integer maxTokens=PNlib.Constants.Integer_inf "maximum capacity" annotation(Dialog(enable = true, group = "Tokens"));
  parameter Integer enablingPrioIn[nIn]=1:nIn
    "enabling priorities of input transitions" annotation(Dialog(enable =true, group = "Enabling"));
  parameter Integer enablingPrioOut[nOut]=1:nOut
    "enabling priorities of output transitions" annotation(Dialog(enable = true, group = "Enabling"));
  //****MODIFIABLE PARAMETERS AND VARIABLES END****//
protected
  discrete Integer pret "pre marking";
  Boolean tokeninout(start=false, fixed=true) "change of tokens?";
  Integer arcWeightIn[nIn] "Integer weights of input arcs";
  Boolean fireIn[nIn] "Do input transtions fire?";
  Boolean activeIn[nIn] "Are delays passed of input transitions?";
  Boolean enabledByInPlaces[nIn]
    "Are input transitions are enabled by all their input places?";
  Integer arcWeightOut[nOut] "Integer weights of output arcs";
  Boolean fireOut[nOut] "Do output transitions fire?";
  Boolean activeOut[nOut](each start=false, each fixed=true) "Are delay passed of output transitions?";
  //****BLOCKS BEGIN****// since no events are generated within functions!!!
  //Does any delay passed of a connected transition?
  Blocks.anyTrue delayPassedOut(vec=activeOut) if nOut>0;
  Blocks.anyTrue delayPassedIn(vec=activeIn) if nIn>0;
  //firing sum calculation
  PN.Blocks.firingSumDis firingSumIn(fire=fireIn, arcWeight=arcWeightIn) if nIn>0;
  PN.Blocks.firingSumDis firingSumOut(fire=fireOut, arcWeight=arcWeightOut) if nOut>0;
  //Enabling process
  PN.Blocks.enablingOutDis enableOut(delayPassed=delayPassedOut.anytrue, nOut=nOut, arcWeight=arcWeightOut, t=pret, minTokens=minTokens, TAout=activeOut, enablingPrio=enablingPrioOut) if nOut>0;
  PN.Blocks.enablingInDis enableIn(delayPassed=delayPassedIn.anytrue, active=activeIn, nIn=nIn, arcWeight=arcWeightIn, t=pret, maxTokens=maxTokens, TAein=if nIn>0 then enabledByInPlaces and activeIn else fill(true, nOut), enablingPrio=enablingPrioIn) if nIn>0;
  //****BLOCKS END****//

public
  PNlib.PN.Interfaces.DisPlaceIn inTransition[nIn](
    each tint=pret,
    each maxTokensint=maxTokens,
    enable=enableIn.TEin_,
    fire=fireIn,
    arcWeightint=arcWeightIn,
    active=activeIn,
    enabledByInPlaces=enabledByInPlaces) if nIn > 0 "connector for input transitions" annotation(Placement(transformation(extent={{-114, -10}, {-98, 10}}, rotation=0), iconTransformation(extent={{-116, -10}, {-100, 10}})));
  PNlib.PN.Interfaces.DisPlaceOut outTransition[nOut](
    each tint=pret,
    each minTokensint=minTokens,
    enable=enableOut.TEout_,
    each tokenInOut=pre(tokeninout),
    fire=fireOut,
    arcWeightint=arcWeightOut,
    active=activeOut) if nOut > 0 "connector for output transitions" annotation(Placement(transformation(extent={{100, -10}, {116, 10}}, rotation=0)));
equation
  //****MAIN BEGIN****//
  //recalculation of tokens
  pret=pre(t);

  //tokeninout = (if nIn>0 then pre(firingSumIn.firingSum) > 0 else false) or (if nOut>0 then pre(firingSumOut.firingSum) > 0 else false);
  if nIn>0 and nOut>0 then
    tokeninout = pre(firingSumIn.firingSum) > 0 or pre(firingSumOut.firingSum) > 0;
  elseif nIn>0 then
    tokeninout = pre(firingSumIn.firingSum) > 0;
    elseif nOut>0 then
    tokeninout = pre(firingSumOut.firingSum) > 0;
  else
     tokeninout = false;
  end if;

  when {if nIn>0 then pre(firingSumIn.firingSum) > 0 else false, if nOut>0 then pre(firingSumOut.firingSum) > 0 else false} then
    t = pret + (if nIn>0 then pre(firingSumIn.firingSum)  else 0) - (if nOut>0 then pre(firingSumOut.firingSum) else 0);
  end when;
  //****MAIN END****//
  //****ERROR MESSENGES BEGIN****//
  assert(PNlib.Functions.OddsAndEnds.prioCheck(enablingPrioIn,nIn) or nIn==0, "The priorities of the input priorities may be given only once and must be selected from 1 to nIn");
  assert(PNlib.Functions.OddsAndEnds.prioCheck(enablingPrioOut,nOut) or nOut==0, "The priorities of the output priorities may be given only once and must be selected from 1 to nOut");
  assert(startTokens>=minTokens and startTokens<=maxTokens, "minTokens<=startTokens<=maxTokens");
  //****ERROR MESSENGES END****//
  annotation(defaultComponentName = "P1", Icon(graphics={Ellipse(
          extent={{-100, 96}, {100, -100}},
          lineColor={0, 0, 0},
          fillColor={255, 255, 255},
          fillPattern=FillPattern.Solid),
      Text(
        extent={{-1.5, 25.5}, {-1.5, -21.5}},
        lineColor={0, 0, 0},
        textString=DynamicSelect("%startTokens",realString(t, 1, 0))),
        Text(
          extent={{-90, 130}, {-90, 116}},
          lineColor={0, 0, 0},
          textString=DynamicSelect(" ", if true then if maxTokens>1073741822 then  "[%minTokens, inf]" else "[%minTokens, %maxTokens]" else " ")),
                                          Text(
          extent={{-74, -113}, {-74, -138}},
          lineColor={0, 0, 0},
          textString="%name")}),
                           Diagram(graphics));
end PD;
