within PNlib.CPN.Interfaces;
connector PlaceOut "part of place model to connect places to output transitions"
  import PNlib.Types.ArcType;
  input Boolean active "Are the output transitions active?" annotation(HideResult=true);
  input Boolean fire "Do the output transitions fire?" annotation(HideResult=true);
  input Integer arcWeightint "Integer arc weights of output transitions" annotation(HideResult=true);
  output Integer tint "Integer marking of the place" annotation(HideResult=true);
  output Integer minTokensint "Integer minimum capacity of the place" annotation(HideResult=true);
  output Boolean enable "Which of the output transitions are enabled by the place?" annotation(HideResult=true);
  output Boolean tokenInOut "Does the place have a discrete token change?" annotation(HideResult=true);
  annotation(Icon(graphics={Polygon( points={{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}}, lineColor={0, 0, 0}, fillColor={255, 255, 255}, fillPattern=FillPattern.Solid)}));
end PlaceOut;
