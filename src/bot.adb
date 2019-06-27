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
      when update_hand => readUpdateHand(last_command, game, logic);

      when action =>

         winning_chances := get_winning_chances(logic);

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
         Put_Line(Standard_Error,To_Lower(ToString(message)));
         printCard(get_card(get_hand(game),0));
         printCard(get_card(get_hand(game),1));
         Put_Line(Standard_Error, winning_chances'Img);
         Put_line(To_Lower(ToString(message)));

      end case;
   end loop;
   Put_Line(Standard_Error, can_bluff(logic)'Img&can_get_bluffed(logic)'Img&can_semi_bluff(logic)'Img);
end;
