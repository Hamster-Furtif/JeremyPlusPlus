with ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO, utils, ada.Strings.Unbounded, montecarlo, botIO, opstrat, Mastermind, Ada.Characters.Handling;
use ada.text_io, ada.Float_Text_IO, ada.Integer_Text_IO, utils, ada.Strings.Unbounded, montecarlo, botIO, opstrat, Mastermind, Ada.Characters.Handling;

procedure bot is

   game : T_game;
   logic : T_logic;
   message : T_round;

   MAX_LINE_LENGTH : constant integer := 100;
   line : string(1..MAX_LINE_LENGTH);
   line_length : integer;

   last_command : T_command;

   best_combinaison : T_combination;

   sample : T_Sample;

   winning_chances : Float;

   NbBluffInit : Constant integer :=3;
   CompteurBluffInit : Integer :=0;

begin

   initGame(game);

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
         best_combinaison := getBestCombination(get_hand(game)+get_table(game));
         winning_chances := chancesOfWinning(sample, best_combinaison);
         set_winning_chances(logic, winning_chances);

         if CompteurBluffInit<NbBluffInit then --On veut initialiser notre strategie en bluffant au moins 3 fois (initialisation des booleens nous informant sur le bluff)
            if (winning_chances >= LOW) then
               message := strat(logic, game);
            else
               if get_my_money(game) > get_op_money(game) then
                  message := create_round(bet,Integer(IDIOT_OP*get_op_money(game)));
               else
                  message:= create_round(bet, Integer(IDIOT_OWN*get_my_money(game)));
               end if;
               CompteurBluffInit := CompteurBluffInit +1;
            end if;
         else
            message := strat(logic, game);

         end if;

         put_line(To_Lower(ToString(message)));
      end case;
   end loop;

end;
