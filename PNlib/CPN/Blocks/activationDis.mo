within PNlib.CPN.Blocks;
block activationDis "Activation of a discrete transition"
  parameter input Integer nIn "number of input places";
  parameter input Integer nOut "number of output places";
  input Integer tIntIn[:] "tokens of input places";
  input Integer tIntOut[:] "tokens of output places";
  input PNlib.Types.ArcType arcType[:] "arc type of input places";
  input Integer arcWeightIntIn[:] "arc weights of input places";
  input Integer arcWeightIntOut[:] "arc weights of output places";
  input Integer minTokensInt[:] "minimum capacities of input places";
  input Integer maxTokensInt[:] "maximum capacities of output places";
  input Boolean firingCon "firing condition of transition";
  input Boolean normalArc[:] "normal or double arc?";
  input Integer testValueInt[:] "integer test values of test and inhibitor arcs";
  output Boolean active "activation of transition";
algorithm
  active:=true;
  //check input places
  for i in 1:nIn loop
      if (arcType[i]==PNlib.Types.ArcType.NormalArc or not normalArc[i]) and not (tIntIn[i]-arcWeightIntIn[i]  >= minTokensInt[i]) then
        active:=false;
      elseif arcType[i]==PNlib.Types.ArcType.RealTestArc and not (tIntIn[i] > testValueInt[i]) then
        active:=false;
      elseif arcType[i]==PNlib.Types.ArcType.TestArc and not (tIntIn[i] >= testValueInt[i]) then
        active:=false;
      elseif arcType[i]==PNlib.Types.ArcType.RealInhibitorArc and not (tIntIn[i] < testValueInt[i]) then
        active:=false;
      elseif arcType[i]==PNlib.Types.ArcType.InhibitorArc and not (tIntIn[i] <= testValueInt[i]) then
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
