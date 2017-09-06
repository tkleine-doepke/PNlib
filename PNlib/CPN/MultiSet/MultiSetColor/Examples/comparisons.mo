within PNlib.CPN.MultiSet.MultiSetColor.Examples;
  model comparisons
  extends Modelica.Icons.Example;
  import PNlib.CPN.MultiSet.MultiSetColor.Color.COLOR;

  Color A=Color({1,1,1,1,1,1,1,1,1});
  Color B=Color({1,1,1,1,1,1,1,1,1});
  Color C=Color({2,2,2,2,2,2,2,2,2});

 Boolean ut;
 Boolean uf;
 Boolean vt;
 Boolean vf;
 Boolean wt;
 Boolean wf;
 Boolean xt;
 Boolean xf;
 Boolean yt;
 Boolean yf;
 Boolean zt;
 Boolean zf;

 equation
 ut=A==B;
 uf=A==C;

 vt=A<>C;
 vf=A<>B;

 wt=A<=C;
 wf=C<=A;

 xt=C>=A;
 xf=A>=C;

 yt=A<C;
 yf=A<B;

 zt=C>A;
 zf=A>B;
  end comparisons;
