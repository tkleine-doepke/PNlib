within PNlib.PN.Blocks;
block event "Activation of a discrete transition"
  parameter input Integer nIn "number of input places";
  parameter input Integer nOut "number of output places";
  input Real event [:] "events of timed transition";
  input Boolean active "activation of transition";
  input Boolean enabledIn;
  input Boolean enabledOut;
  output Boolean fire;
  output Boolean eventPassed (start=false, fixed=true);
protected
  Real event_ [:] = PNlib.Functions.OddsAndEnds.addElement(event) "solves last-time problem";
  Real firingTime "next putative firing time";
  Boolean active_;
  Integer eventIndex(start=1, fixed=true);
algorithm
  when time>=event_[eventIndex] then
      eventIndex:=eventIndex+1;
  end when;
equation
  active_ = active and not pre(eventPassed);
  //save next putative firing time
  when active_ then
     firingTime = event_[eventIndex];
  end when;
  //event passed?
  eventPassed= active_ and time>= firingTime;
  //firing process
 // fire=if nOut==0 then enabledByInPlaces else enabledByOutPlaces;
   fire=if nOut==0 and nIn==0 then false elseif nOut==0 then enabledIn else enabledOut;
  //****MAIN END****//
end event;
