with montecarlo, ada.Text_IO, ada.Integer_Text_IO, opstrat, read_preflop;
use montecarlo, ada.Text_IO, ada.Integer_Text_IO, opstrat, read_preflop;

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
      settings_replaced : T_settings := get_settings(game);
   begin
      if To_String(command.pars(1)) = "hand_per_level" then
         set_hands_per_lvl(settings_replaced,Integer'Value(To_String(command.pars(2))));
      elsif To_String(command.pars(1)) = "timebank" then
         set_timebank_max(settings_replaced,Integer'Value(To_String(command.pars(2))));
      elsif To_String(command.pars(1)) = "time_per_move" then
         set_timebank_sup(settings_replaced,Integer'Value(To_String(command.pars(2))));
      end if;
      set_settings(game,settings_replaced);
   end readSettings;
   
   procedure readUpdateGame(command : T_command; game :  in out  T_game) is
   begin
      if(To_String(command.pars(1)) = "hand") then
         set_round(game,Integer'Value(To_String(command.pars(2))));

      elsif (To_String(command.pars(1)) = "stack") then
         if(command.pars(2) = "self") then
            set_my_money(game,Integer'Value(To_String(command.pars(3))));
         else
            set_op_money(game,Integer'Value(To_String(command.pars(3))));
         end if;

      elsif (To_String(command.pars(1)) = "button") then
         set_button_is_mine(game, command.pars(2) = "self");
         set_round(game, get_round(game)+ 1);

      elsif (To_String(command.pars(1)) = "small_blind") then
         set_small_blind(game,Integer'value(To_String(command.pars(2))));

      elsif (To_String(command.pars(1)) = "big_blind") then
         set_big_blind(game,Integer'value(To_String(command.pars(2))));
      end if;

   end readUpdateGame;
   
   procedure readUpdateHand(command : T_command; game :  in out T_game; sample : in out T_Sample; logic : in out T_logic) is
      hand_replaced    : T_set    := get_hand(game);
      op_hand_replaced : T_set    := get_op_hand(game);
      table_replaced   : T_set    := get_table(game);
   begin
      
      if(To_String(command.pars(1)) = "hand") then
         if(To_String(command.pars(2)) = "self") then
            emptySet(hand_replaced);
            addToSet(parseCard(To_String(command.pars(3))), hand_replaced);
            addToSet(parseCard(To_String(command.pars(4))), hand_replaced);
         else
            emptySet(op_hand_replaced);
            addToSet(parseCard(To_String(command.pars(3))), op_hand_replaced);
            addToSet(parseCard(To_String(command.pars(4))), op_hand_replaced);
            if (get_current_move(logic) = bet) then
               add_bluff(logic, opIsBluffing(op_hand_replaced));
               end if;
         end if;
         
      elsif(To_String(command.pars(1)) = "table") then
         emptySet(table_replaced);
         initSample(sample, table_replaced);
         for i in 2..(command.size-1) loop        
            addToSet(parseCard(To_String(command.pars(i))), table_replaced);
            addToSampleSets(sample, parseCard(To_String(command.pars(i))));
         end loop;

      elsif(To_String(command.pars(1)) = "pot") then
         set_pot(game,Integer'Value(To_String(command.pars(2))));
         

      elsif(To_String(command.pars(1)) = "amount_to_call") then
         set_amount_to_call(game,Integer'Value(To_String(command.pars(2))));

      elsif(To_String(command.pars(1)) = "min_bet") then
         set_min_bet(game,Integer'Value(To_String(command.pars(2))));

      elsif (To_String(command.pars(1)) = "move") then
        
         if(To_String(command.pars(2)) = "other" ) then
            if (To_String(command.pars(3)) = "bet") then
               set_op_money(game, get_op_money(game) - Integer'Value(To_String(command.pars(4))));
               set_current_move(logic, bet);
            else
               set_current_move(logic, none);
            end if;

         end if;
         
      elsif (To_String(command.pars(1)) = "win") then
         if(To_String(command.pars(2)) = "other") then
            set_op_money(game, get_op_money(game) + Integer'Value(To_String(command.pars(3))));
         else
            set_my_money(game, get_my_money(game) + Integer'Value(To_String(command.pars(3))));
         end if; 
         if (get_size(get_op_hand(game)) > 0) then
            null;
            end if;
         end if;
         
         emptySet(hand_replaced);
         emptySet(op_hand_replaced);
         emptySet(table_replaced);
         
   end readUpdateHand;
   
   procedure printCard(card : in T_card) is
   begin
      Put_Line(Standard_Error, "");
      Put(Standard_Error, get_rank(card)+2);
      Put(Standard_Error, "  of ");
      Put(Standard_Error, (T_colour'Image(get_colour(card))));
      Put_Line(Standard_Error, "");
   end printCard;
   
   function parseCard(str : in String) return T_card is
      card : T_card;
      values : String := "23456789TJQKA";
   begin
      for i in 1..values'Length loop
         if values(i) = str(str'First) then
            set_rank(card,i-1);
         end if;
      end loop;
      
      case str(str'First + 1) is
      when 'c' => set_colour(card, T_colour'Value("clovers"));
      when 's' => set_colour(card, T_colour'Value("spades"));
      when 'h' => set_colour(card, T_colour'Value("hearts"));
      when 'd' => set_colour(card, T_colour'Value("diamonds"));
      when others => set_colour(card, T_colour'Value("empty"));
      end case;
   
      return card;
   
   end parseCard;
   

end botIO;
