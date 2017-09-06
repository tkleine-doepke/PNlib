within PNlib.CPN.MultiSet.MultiSetColor.Examples;
  model supportset
  extends Modelica.Icons.Example;
  import PNlib.CPN.MultiSet.MultiSetColor.Color.COLOR;

  Color A=Color({COLOR.BLAU,COLOR.ROT},{5,1});
  Color B=Color({COLOR.ROT,COLOR.BLAU},{1,5});
  Color C;
  Boolean x;
 equation
   x=A==B;
   C=Color({COLOR.BLAU,COLOR.ROT},{4,1})+Color({COLOR.ROT,COLOR.SCHWARZ},{1,3});

  end supportset;
