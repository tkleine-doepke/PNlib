within PNlib.PN.Interfaces;
connector DisTransitionOut "part of transition model to connect transitions to output places"
  input Integer tint "Integer markings of output places" annotation(HideResult=true);
  input Integer maxTokensint "Integer maximum capacities of output places" annotation(HideResult=true);
  input Boolean enable "Is the transition enabled by output places?" annotation(HideResult=true);
  output Boolean active "Is the transition active?" annotation(HideResult=true);
  output Boolean fire "Does the transition fire?" annotation(HideResult=true);
  output Integer arcWeightint "Integer output arc weights of the transition" annotation(HideResult=true);
  output Boolean enabledByInPlaces "Is the transition enabled by all input places?" annotation(HideResult=true);
  annotation(Icon(graphics={Polygon(points={{-100, 100}, {98, 0}, {-100, -100}, {-100, 100}}, lineColor={0, 0, 0}, fillColor={255, 255, 255}, fillPattern=FillPattern.Solid)}));
end DisTransitionOut;
