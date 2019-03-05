with utils, read_preflop, ada.Text_IO, ada.Integer_Text_IO;
use utils, read_preflop, ada.Text_IO, ada.Integer_Text_IO;
with botIO; use botIO;

procedure test_preflop is
   card1, card2 : t_card;
   str : string(1..2);
   lg : integer := 999999999;

begin
   put_line("donnez votre premiere carte : ");
   get_line(str,lg);
   skip_line;
   card1 := parseCard(str);
   
   put_line("donnez votre deuxieme carte : ");
   get_line(str,lg);
   card2 := parseCard(str);
   
   put_line("Avec cette main, votre probabilite de gagner est : " & float'image(Get_Winning_Chance(card1,card2)) &
              " ; de perdre : " & float'image(Get_Losing_Chance(card1,card2)) &
              " ; de faire egalite : " & float'image(Get_Tie_Chance(card1,card2)));
--     for i in 0..168 loop
--        if(Win_Array(i) < lg) then
--           lg := Win_Array(i);
--           Put_Line(Integer'Image(i));
--        end if;
--     end loop;
--     Put_Line(Integer'Image(lg));

   
end test_preflop;
