with montecarlo, ada.Text_IO, ada.Integer_Text_IO;
use montecarlo, ada.Text_IO, ada.Integer_Text_IO;

package body botIO is

   function splitLine(line : String; line_length : Integer) return T_command is
      word_begin : Integer := 1;
      word_count : Integer := 0;
      command :T_command;
   begin

      for i in 1..line_length loop
         if line(i) = ' '  or line(i) = ',' then
            if(word_count = 0) then
               command.pars(0) := To_Unbounded_String(line(line'First..i-1));
               command.prefix := T_prefix'Value(line(line'First..i-1));
            else
               command.pars(word_count) := To_Unbounded_String( line(word_begin..i-1) );
            end if;
            word_begin := i+1;
            word_count := word_count +1;
         end if;
      end loop;
      
      command.pars(word_count) :=
        To_Unbounded_String(line(word_begin..line_length));
      command.size := word_count;
      return command;
   end splitLine;
   
   
   procedure readSettings(command : T_command; game : in out T_game) is
   begin
      if To_String(command.pars(1)) = "hand_per_level" then
         game.settings.hands_per_lvl := Integer'Value(To_String(command.pars(2)));
      elsif To_String(command.pars(1)) = "timebank" then
         game.settings.timebank_max := Integer'Value(To_String(command.pars(2)));
      elsif To_String(command.pars(1)) = "time_per_move" then
         game.settings.timebank_sup := Integer'Value(To_String(command.pars(2)));
      end if;
   end readSettings;
   
   procedure readUpdateGame(command : T_command; game :  in out  T_game) is
   begin
      if(To_String(command.pars(1)) = "hand") then
         game.round := Integer'Value(To_String(command.pars(2)));

      elsif (To_String(command.pars(1)) = "stack") then
         if(command.pars(2) = "self") then
            game.my_money := Integer'Value(To_String(command.pars(3)));
         else
            game.op_money := Integer'Value(To_String(command.pars(3)));
         end if;

      elsif (To_String(command.pars(1)) = "button") then
         game.button_is_mine := command.pars(2) = "self";

      elsif (To_String(command.pars(1)) = "small_blind") then
         game.small_blind := Integer'value(To_String(command.pars(2)));

      elsif (To_String(command.pars(1)) = "big_blind") then
         game.big_blind := Integer'value(To_String(command.pars(2)));
      end if;

   end readUpdateGame;
   
   procedure readUpdateHand(command : T_command; game :  in out T_game; sample : in out T_Sample) is
   begin
      
      if(To_String(command.pars(1)) = "hand") then
         emptySet(game.hand);
         addToSet(parseCard(To_String(command.pars(3))), game.hand);
         addToSet(parseCard(To_String(command.pars(4))), game.hand);
         initSample(sample, game.hand);
         
      elsif(To_String(command.pars(1)) = "table") then
         emptySet(game.table);
         initSample(sample, game.hand);
         for i in 2..(command.size-1) loop        
            addToSet(parseCard(To_String(command.pars(i))), game.table);
            addToSampleSets(sample, parseCard(To_String(command.pars(i))));
         end loop;

      elsif(To_String(command.pars(1)) = "pot") then
         game.pot := Integer'Value(To_String(command.pars(2)));

      elsif(To_String(command.pars(1)) = "amount_to_call") then
         game.amount_to_call := Integer'Value(To_String(command.pars(2)));

      elsif(To_String(command.pars(1)) = "min_bet") then
         game.min_bet := Integer'Value(To_String(command.pars(2)));

      elsif (To_String(command.pars(1)) = "move") then
         game.last_op_move := T_move'Value(To_String(command.pars(3)));
         if(To_String(command.pars(2)) = "other" and To_String(command.pars(3)) = "bet") then
            game.op_money := game.op_money - Integer'Value(To_String(command.pars(4)));
         end if;
         
      elsif (To_String(command.pars(1)) = "win") then
         emptySet(game.hand);
         emptySet(game.table);
         if(To_String(command.pars(2)) = "other") then
            game.op_money := game.op_money + Integer'Value(To_String(command.pars(3)));
         else
            game.op_money := game.op_money + Integer'Value(To_String(command.pars(3)));
         end if;
      end if;
   end readUpdateHand;
   
   procedure printCard(card : in T_card) is
   begin
      Put_Line(Standard_Error, "");
      Put(Standard_Error, card.rank+2);
      Put(Standard_Error, "  of ");
      Put(Standard_Error, (T_colour'Image(card.colour)));
      Put_Line(Standard_Error, "");
   end printCard;
   
    function parseCard(str : in String) return T_card is
      card : T_card;
      values : String := "23456789TJQKA";
   begin
      for i in 1..values'Length loop
         if values(i) = str(str'First) then
            card.rank := i-1;
         end if;
      end loop;
      
      case str(str'First + 1) is
      when 'c' => card.colour := T_colour'Value("clovers");
      when 's' => card.colour := T_colour'Value("spades");
      when 'h' => card.colour := T_colour'Value("hearts");
      when 'd' => card.colour := T_colour'Value("diamonds");
      when others => card.colour := T_colour'Value("empty");
      end case;
   
      return card;
   
   end parseCard;
   
end botIO;
