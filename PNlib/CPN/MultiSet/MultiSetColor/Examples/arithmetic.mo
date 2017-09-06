within PNlib.CPN.MultiSet.MultiSetColor.Examples;
  model arithmetic
  extends Modelica.Icons.Example;
  import PNlib.CPN.MultiSet.MultiSetColor.Color.COLOR;

   Color A=Color({1,1,1,1,1,1,1,1,1});
   Color B=Color({1,5,1,6,1,1,1,2,1});
   Color C;
   Color D;
   Color E;

  Integer x;
  equation
  C=B+A;
  D=B-A;
  E=Color({1,1,1,1,1,1,1,1,1});

  x=Color.cardinality(A);
  end arithmetic;
