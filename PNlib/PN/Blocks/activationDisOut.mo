within PNlib.PN.Blocks;
block activationDisOut "Activation of a discrete transition"
  parameter input Integer nOut "number of output places";
  input Integer tIntOut[:] "tokens of output places";
  input Integer arcWeightIntOut[:] "arc weights of output places";
  input Integer maxTokensInt[:] "maximum capacities of output places";
  input Boolean firingCon "firing condition of transition";
  output Boolean active "activation of transition";
algorithm
  active:=true;
  //check input places
  //check output places
  for i in 1:nOut loop
      if not (tIntOut[i]+arcWeightIntOut[i] <= maxTokensInt[i]) then
        active:=false;
      end if;
  end for;
  active:=active and firingCon;
end activationDisOut;
