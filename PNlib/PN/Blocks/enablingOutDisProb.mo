within PNlib.PN.Blocks;
block enablingOutDisProb "enabling process of output transitions"
  parameter input Integer nOut "number of output transitions";
  input Integer arcWeight[:] "arc weights of output transitions";
  input Integer t "current token number";
  input Integer minTokens "minimum capacity";
  input Boolean TAout[:] "active output transitions with passed time";
  input Real enablingProb[:] "enabling probabilites of output transitions";
  input Boolean timePassed "Does any timePassed of a output transition";
  parameter input Integer localSeed "Local seed to initialize random number generator";
  parameter input Integer globalSeed "Global seed to initialize random number generator";
  output Boolean TEout_[nOut] "enabled output transitions";
protected
  discrete Integer state128[4] "state of random number generator";
  Boolean TEout[nOut] "enabled output transitions";
  Integer remTAout[nOut](each start=0, each fixed=true) "remaining active output transitions";
  discrete Real cumEnablingProb[nOut](each start=0, each fixed=true) "cumulated, scaled enabling probabilities";
  Integer arcWeightSum "arc weight sum";
  Integer nremTAout "number of remaining active output transitions";
  Integer nTAout "number of active output transitions";
  Integer k "iteration index";
  Integer posTE "possible enabled transition";
  discrete Real randNum "uniform distributed random number";
  discrete Real sumEnablingProbTAout "sum of the enabling probabilities of the active output transitions";
  Boolean endWhile;
initial algorithm
  // Generate initial state from localSeed and globalSeed
  state128 := Modelica.Math.Random.Generators.Xorshift128plus.initialState(localSeed, globalSeed);
  (randNum, state128) := Modelica.Math.Random.Generators.Xorshift128plus.random(state128);
algorithm
  TEout := fill(false, nOut);
  arcWeightSum := 0;
  when timePassed then
      arcWeightSum := PNlib.Functions.OddsAndEnds.conditionalSumInt(arcWeight, TAout);  //arc weight sum of all active output transitions
      if t - arcWeightSum >= minTokens then  //Place has no actual conflict; all active output transitions are enabled
        TEout := TAout;
      else                          //Place has an actual conflict;
          remTAout := zeros(nOut);
          nremTAout := 0;
          arcWeightSum := 0;
          for i in 1:nOut loop
            if TAout[i] then
              nremTAout := nremTAout+1;  //number of active output transitions
              remTAout[nremTAout] := i;  //active output transitions
            end if;
          end for;
          nTAout := nremTAout;          //number of active output transitions
          if nTAout>0 then
            sumEnablingProbTAout := sum(enablingProb[remTAout[1:nremTAout]]);  //enabling probability sum of all active output transitions
            cumEnablingProb := zeros(nOut);      //cumulative, scaled enabling probabilities
            cumEnablingProb[1] := enablingProb[remTAout[1]]/sumEnablingProbTAout;
            for j in 2:nremTAout loop
              cumEnablingProb[j] := cumEnablingProb[j-1]+enablingProb[remTAout[j]]/sumEnablingProbTAout;
            end for;
            for i in 1:nTAout loop
              (randNum, state128) := Modelica.Math.Random.Generators.Xorshift128plus.random(pre(state128)) "uniform distributed random number";
              endWhile := false;
              k := 1;
              while k<=nremTAout and not endWhile loop
                if randNum <= cumEnablingProb[k] then
                  posTE := remTAout[k];
                  endWhile := true;
                else
                  k := k + 1;
                end if;
              end while;
              if t-(arcWeightSum + arcWeight[posTE]) >= minTokens then
                arcWeightSum := arcWeightSum + arcWeight[posTE];
                TEout[posTE] := true;
              end if;
              nremTAout := nremTAout - 1;
              if nremTAout > 0 then
                remTAout := PNlib.Functions.OddsAndEnds.deleteElementInt(remTAout, k);
                cumEnablingProb := zeros(nOut);
                sumEnablingProbTAout := sum(enablingProb[remTAout[1:nremTAout]]);
                if sumEnablingProbTAout>0 then
                  cumEnablingProb[1] := enablingProb[remTAout[1]]/sumEnablingProbTAout;
                  for j in 2:nremTAout loop
                    cumEnablingProb[j] := cumEnablingProb[j-1]+enablingProb[remTAout[j]]/sumEnablingProbTAout;
                  end for;
                else
                  cumEnablingProb[1:nremTAout] := fill(1/nremTAout, nremTAout);
                end if;
              end if;
            end for;
          end if;
        end if;
  end when;
  // hack for Dymola 2017
  // TEout_ := TEout and TAout;
  for i in 1:nOut loop
    TEout_[i] := TEout[i] and TAout[i];
  end for;
end enablingOutDisProb;
