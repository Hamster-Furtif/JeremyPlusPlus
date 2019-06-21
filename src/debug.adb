with ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO, utils, ada.Strings.Unbounded, montecarlo, botIO, opstrat, Mastermind;
use ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO, utils, ada.Strings.Unbounded, montecarlo, botIO, opstrat, Mastermind;

procedure debug is
   t : Unbounded_String := Ada.Strings.Unbounded.To_Unbounded_String("7c");
   set : T_set;
   r : T_round;
   str : String := "HAHAHAHAAHAHAH";
begin
   r := create_round(call,-1);
   str := toString(r);
   Put_line(str);
end debug;
