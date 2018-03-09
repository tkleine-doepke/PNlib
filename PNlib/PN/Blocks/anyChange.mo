within PNlib.PN.Blocks;
block anyChange "Does any entry of a Boolean vector change its value?"
  input Boolean vec[:](each start=false, each fixed=true);
  output Boolean anychange;
algorithm
  anychange:=false;
  for i in 1:size(vec, 1) loop
    anychange:=anychange or change(vec[i]);
  end for;
end anyChange;
