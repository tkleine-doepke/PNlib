within PNlib.PN.Blocks;
block enablingOutDisBene "enabling process of output transitions"
  parameter input Integer nOut "number of output transitions";
  input Integer arcWeight[:] "arc weights of output transitions";
  input Integer t "current token number";
  input Integer minTokens "minimum capacity";
  input Boolean TAout[:] "active output transitions with passed delay";
  input Real enablingBene[:] "enabling benefit of output transitions";
  input PNlib.Types.BenefitType benefitType "algorithm for benefit";
  input Boolean delayPassed "Does any delayPassed of a output transition";
  output Boolean TEout_[nOut] "enabled output transitions";
protected
  Boolean TEout[nOut] "enabled output transitions";
  Integer arcWeightSum "arc weight sum";
  Integer Index "benefit Index";
  Real enablingBene_[nOut]  "Benefit";
  Real enablingBeneQuo[nOut]  "Benefit Quotient";
  Real BestValue "Max Benefit";
  discrete Real benefitMax "theoretical benefit";
  Boolean valid "valid solution";
  discrete Real benefitLimit "best valid benefit";
algorithm
  TEout := fill(false, nOut);
  arcWeightSum := 0;
  when delayPassed then
      arcWeightSum := PNlib.Functions.OddsAndEnds.conditionalSumInt(arcWeight, TAout);  //arc weight sum of all active output transitions
      if t - arcWeightSum >= minTokens then  //Place has no actual conflict; all active output transitions are enabled
        TEout := TAout;
      elseif benefitType==PNlib.Types.BenefitType.Greedy then
        enablingBene_:=enablingBene;
        arcWeightSum := 0;
        for i in 1: nOut loop
          BestValue:=max(enablingBene_);
          Index:=Modelica.Math.Vectors.find(BestValue,enablingBene_);
          if Index>0 and TAout[Index] and t-(arcWeightSum+arcWeight[Index]) >= minTokens then
            TEout[Index] := true;
            arcWeightSum := arcWeightSum + arcWeight[Index];
          end if;
          enablingBene_[Index]:=-1;
        end for;
      elseif benefitType==PNlib.Types.BenefitType.BenefitQuotient then
          enablingBeneQuo:=enablingBene ./arcWeight;
          arcWeightSum := 0;
          for i in 1: nOut loop
            BestValue:=max(enablingBeneQuo);
            Index:=Modelica.Math.Vectors.find(BestValue,enablingBeneQuo);
            if Index>0 and TAout[Index] and t-(arcWeightSum+arcWeight[Index]) >= minTokens then
              TEout[Index] := true;
              arcWeightSum := arcWeightSum + arcWeight[Index];
            end if;
            enablingBeneQuo[Index]:=-1;
          end for;
      else
           arcWeightSum := 0;
           benefitMax:=sum(enablingBene);
           benefitLimit:=0;
           (TEout, arcWeightSum,  benefitMax, valid, benefitLimit):=PNlib.PN.Functions.Enabling.benefitBaBDisOut(1, nOut, enablingBene, arcWeight, enablingBene ./arcWeight, t, benefitMax, minTokens, TEout, 0, benefitLimit, TAout);
      end if;
  end when;
  // hack for Dymola 2017
  // TEout_ := TEout and TAout;
  for i in 1:nOut loop
    TEout_[i] := TEout[i] and TAout[i];
  end for;
end enablingOutDisBene;
