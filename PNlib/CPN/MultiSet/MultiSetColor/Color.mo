within PNlib.CPN.MultiSet.MultiSetColor;
operator record Color
 type COLOR = enumeration(
      ROT,
      BLAU,
      GRUEN,
      PINK,
      GELB,
      VIOLET,
      ORANGE,
      WEISS,
      SCHWARZ);

Integer H[COLOR];

 encapsulated operator 'constructor'
   import PNlib.CPN.MultiSet.MultiSetColor.Color;

    function const
      input Integer H[Color.COLOR];
      output Color  set;
    algorithm
      set.H:=H;
    end const;

     function UserInput
       input Color.COLOR C[:];
       input Integer H[:];
       //output Color  set=Color({0,0,0,0,0,0,0,0,0}); Die gr��e soll ja Variable werden daher geht Color({0,0,0,0,0,0,0,0,0}) nicht mehr
       //output Color  set=Color(zeros(Color.COLOR,1)); hier kenn er nicht die enumaration Color.COLOR ??? was ich nicht verstehe
       output Color  set;
     algorithm

       for i in Color.COLOR loop // So funktiniert die Variable Gr��e, finde ich aber sehr unsch�n
          set.H[i]:=0;
       end for;

       for i in 1:size(H,1) loop
           set.H[C[i]]:=set.H[C[i]]+H[i];// Es soll auch m�glich sein {Rot,Rot],{2,3} einzulesen und dan {Rot},{5} zu erhalten
       end for;
     end UserInput;

 end 'constructor';

encapsulated function cardinality
  // habe jetzt cardinality als Name genommen
   import PNlib.CPN.MultiSet.MultiSetColor.Color;
   input Color c;
   output Integer card=0;
algorithm
        for i in Color.COLOR loop // das finde ich toll, man kann ja einfach die Enumaration nenen und dan lauft der Index alle elemente durch
          card:=card + c.H[i];
        end for;
end cardinality;

 encapsulated operator function '+'
  import PNlib.CPN.MultiSet.MultiSetColor.Color;
      input Color c1;
      input Color c2;
      output Color result;
 algorithm
      result:=Color(H=c1.H+c2.H);
 end '+';

 encapsulated operator function '-'
 import PNlib.CPN.MultiSet.MultiSetColor.Color;
      input Color c1;
      input Color c2;
      output Color result;
  protected
    Integer[Color.COLOR] help; // Als Name f�r die Hilfsvariable ist mir hier nur "help" eingefallen, gibt es in Modelica so eine art Standart Name f�r hilfsvariablen?
 algorithm
     for i in Color.COLOR loop
        help[i]:=max(0,c1.H[i]-c2.H[i]);
      end for;
      result:=Color(H=help);
 end '-';

 encapsulated operator function '=='
 import PNlib.CPN.MultiSet.MultiSetColor.Color;
      input Color c1;
      input Color c2;
      output Boolean result=true;
 algorithm
      for i in Color.COLOR loop
        if c1.H[i]<>c2.H[i] then
          result:=false;
          break;
        end if;
      end for;
 end '==';

 encapsulated operator function '<>'
  import PNlib.CPN.MultiSet.MultiSetColor.Color;
      input Color c1;
      input Color c2;
      output Boolean result=false;
 algorithm
      for i in Color.COLOR loop
        if c1.H[i]<>c2.H[i] then
          result:=true;
          break;
        end if;
      end for;
 end '<>';

 encapsulated operator function '<='
  import PNlib.CPN.MultiSet.MultiSetColor.Color;
      input Color c1;
      input Color c2;
      output Boolean result=true;
 algorithm
      for i in Color.COLOR loop
        if c1.H[i]>c2.H[i] then
          result:=false;
          break;
        end if;
      end for;
 end '<=';

encapsulated operator function '>='
  import PNlib.CPN.MultiSet.MultiSetColor.Color;
      input Color c1;
      input Color c2;
      output Boolean result=true;
algorithm
      for i in Color.COLOR loop
        if c1.H[i]<c2.H[i] then
          result:=false;
          break;
        end if;
      end for;
end '>=';

encapsulated operator function '>'
  import PNlib.CPN.MultiSet.MultiSetColor.Color;
      input Color c1;
      input Color c2;
      output Boolean result=true;
algorithm
      for i in Color.COLOR loop
        if c1.H[i]<=c2.H[i] then
          result:=false;
          break;
        end if;
      end for;
end '>';

encapsulated operator function '<'
  import PNlib.CPN.MultiSet.MultiSetColor.Color;
      input Color c1;
      input Color c2;
      output Boolean result=true;
algorithm
      for i in Color.COLOR loop
        if c1.H[i]>=c2.H[i] then
          result:=false;
          break;
        end if;
      end for;
end '<';

end Color;
