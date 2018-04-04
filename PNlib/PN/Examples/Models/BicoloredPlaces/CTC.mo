within PNlib.PN.Examples.Models.BicoloredPlaces;
model CTC
  parameter Integer nIn=0 "number of input transitions" annotation(Dialog(connectorSizing=true));
  parameter Integer nOut=0 "number of output transitions" annotation(Dialog(connectorSizing=true));

  Real maximumSpeed = 1 "maximum speed" annotation(Dialog(enable = true, group = "Maximum Speed"));
  Boolean fire = transition_.fire "Does the transition fire?";
  Real instantaneousSpeed = transition_.instantaneousSpeed "instantaneous speed";
  Real actualSpeed = transition_.actualSpeed;
  Real arcWeightIn[nIn, numColors] = fill(1,nIn,numColors) "arc weights of input places" annotation(Dialog(enable = true, group = "Arc Weights"));
  Real arcWeightOut[nOut, numColors] = fill(1,nOut,numColors) "arc weights of output places" annotation(Dialog(enable = true, group = "Arc Weights"));

  PNlib.PN.Interfaces.ConTransitionIn[nIn, numColors] inPlaces annotation(Placement(transformation(extent={{-56,-10},{-40,10}})));
  PNlib.PN.Interfaces.ConTransitionOut[nOut, numColors] outPlaces annotation(Placement(transformation(extent={{40,-10},{56,10}})));
protected
  outer PNlib.PN.Components.Settings settings "global settings for animation and display";
  PNlib.PN.Components.TC transition_(nInCon=numColors*nIn, nOutCon=numColors*nOut, maximumSpeed=maximumSpeed, arcWeightInCon=arcWeightIn_flat, arcWeightOutCon=arcWeightOut_flat);
  Real arcWeightIn_flat[nIn*numColors];
  Real arcWeightOut_flat[nOut*numColors];
equation
  for i in 1:nIn loop
    for j in 1:numColors loop
      connect(inPlaces[i,j], transition_.inPlacesCon[j + (i-1)*numColors]);
      arcWeightIn_flat[j + (i-1)*numColors] = arcWeightIn[i,j];
    end for;
  end for;

  for i in 1:nOut loop
    for j in 1:numColors loop
      connect(outPlaces[i,j], transition_.outPlacesCon[j + (i-1)*numColors]);
      arcWeightOut_flat[j + (i-1)*numColors] = arcWeightOut[i,j];
    end for;
  end for;

  annotation(Icon(graphics={Rectangle(extent={{-40,100},{40,-100}}, lineColor={0,0,0}, fillColor=DynamicSelect({255,255,255}, color), fillPattern=FillPattern.Solid)}));
end CTC;
