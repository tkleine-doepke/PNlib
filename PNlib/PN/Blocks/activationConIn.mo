within PNlib.PN.Blocks;
block activatioConIn "Activation of a discrete transition"
  parameter input Integer nIn "number of input places";
  input Real tIn[:] "tokens of input places";
  input Real arcWeightIn[:] "arc weights of input places";
  input Real minTokens[:] "minimum capacities of input places";
  input Boolean firingCon "firing condition of transition";
  output Boolean active "activation of transition";
algorithm
  active:=true;
  //check input places
  for i in 1:nIn loop
      if not (tIn[i]-arcWeightIn[i]  >= minTokens[i]) then
        active:=false;
      end if;
  end for;
  active:=active and firingCon;
end activatioConIn;
