within PNlib.PN.Blocks;
block activationConOut "Activation of a discrete transition"
  parameter input Integer nOut "number of output places";
  input Real tOut[:] "tokens of output places";
  input Real arcWeightOut[:] "arc weights of output places";
  input Real maxTokens[:] "maximum capacities of output places";
  input Boolean firingCon "firing condition of transition";
  output Boolean active "activation of transition";
algorithm
  active:=true;
  //check input places
  //check output places
  for i in 1:nOut loop
      if not (tOut[i]+arcWeightOut[i] <= maxTokens[i]) then
        active:=false;
      end if;
  end for;
  active:=active and firingCon;
end activationonOut;
