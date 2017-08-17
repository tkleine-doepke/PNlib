within PNlib.CPN.Blocks;
block activationDis "Activation of a discrete transition"
  parameter input Integer nIn "number of input places";
  parameter input Integer nOut "number of output places";
  input Integer tIntIn[:] "tokens of input places";
  input Integer tIntOut[:] "tokens of output places";
  input Integer arcWeightIntIn[:] "arc weights of input places";
  input Integer arcWeightIntOut[:] "arc weights of output places";
  input Integer minTokensInt[:] "minimum capacities of input places";
  input Integer maxTokensInt[:] "maximum capacities of output places";
  input Boolean firingCon "firing condition of transition";
  output Boolean active "activation of transition";
algorithm
  active:=true;
  //check input places
  for i in 1:nIn loop
      if not (tIntIn[i]-arcWeightIntIn[i]  >= minTokensInt[i]) then
        active:=false;
      end if;
  end for;
  //check output places
  for i in 1:nOut loop
      if not (tIntOut[i]+arcWeightIntOut[i] <= maxTokensInt[i]) then
        active:=false;
      end if;
  end for;
  active:=active and firingCon;
end activationDis;
