with ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO, utils, ada.Strings.Unbounded, montecarlo, botIO;
use ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO, utils, ada.Strings.Unbounded, montecarlo, botIO;

procedure bot is

   game : T_game;

   MAX_LINE_LENGTH : constant integer := 100;
   line : string(1..MAX_LINE_LENGTH);
   line_length : integer;

   last_command : T_command;

   best_combinaison : T_combination;

   sample : T_Sample;

   winning_chances : Float;

   bet : Integer;

begin

   emptySet(game.hand);
   emptySet(game.table);

   while not End_Of_File loop

      get_line(line, line_length);

      last_command := splitLine(line, line_length);

      case  last_command.prefix is
         --Settings
      when settings => readSettings(last_command, game);

         --update_game
      when update_game => readUpdateGame(last_command, game);

         --update_hand
      when update_hand => readUpdateHand(last_command, game, sample);

      when action =>
         best_combinaison := getBestCombination(game.hand+game.table);
         winning_chances := chancesOfWinning(sample, best_combinaison);
         if (winning_chances >= 0.8) then
            bet := Integer'Max(Integer'Min(100 + Integer(winning_chances*Float(100)), game.op_money), game.min_bet);
            put_line("bet" & Integer'Image(bet));
         elsif(winning_chances >= 0.5 or ( winning_chances >= 0.0 and game.table.size = 0)) then
            put_Line("call");
         else
            Put_Line("check");
         end if;

      when others => put_line("fold");
      end case;
   end loop;

end;
