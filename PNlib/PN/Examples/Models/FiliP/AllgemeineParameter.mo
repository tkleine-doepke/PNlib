within PNlib.PN.Examples.Models.FiliP;
model AllgemeineParameter
  Real Stunde(displayUnit = "Stunde") = time/24;
  Real Tag(displayUnit = "Tag") = time ;
  parameter Real BeginFruehschicht = 6;
  parameter Real BeginSpaetschicht = 12.3;
  parameter Real BeginNachtschicht = 20.25;
  parameter Real DauerFruehschicht = 8.2;
  parameter Real DauerSpaetschicht = 8.2;
  parameter Real DauerNachtschicht = 10;
  Real WK = if time <= 744 then 0.0117 else if time <= 1464 then 0.008 else if time <= 2208 then 0.0196 else if time <= 2928 then 0.0325 else if time <= 3672 then 0.0276 else if time <= 4416 then 0.031 else if time <= 5088 then 0.0344 else if time <= 5832 then 0.0458 else if time <= 6552 then 0.0084 else if time <= 7296 then 0.0118 else if time <= 8016 then 0.0315 else 0.0188;
equation
end AllgemeineParameter;
