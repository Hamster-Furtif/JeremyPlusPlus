with ada.Characters.Handling, utils, ada.Text_IO, ada.Integer_Text_IO, Ada.Calendar, botIO, montecarlo;
use ada.Characters.Handling, utils, ada.Text_IO, ada.Integer_Text_IO, Ada.Calendar, botIO, montecarlo;
package body utils is

   procedure addToSet(card : in T_card ; set : in out T_set) is
   begin
      set.set(set.size) := card;
      set.size := set.size + 1;
   end addToSet;

   procedure emptySet(set :in out T_set)is
   begin
      set.size := 0;
   end emptySet;
   
   function getBestCombination(set : in T_set) return T_combination is
      --Pour le full
      brelan_trouve : Boolean := false;
      index_brelan : Natural;
      --Pour les paires
      n_paires : Natural := 0;
      --Pour la suite et la couleur
      suite_trouvee : Boolean:= true;
      combination : T_combination;
      cards : T_set := set;
      hauteur : Integer := 0;
      quit : Boolean := false;
   begin 
      
      sortSet(cards);  --Trie du plus grand au plus petit
      if cards.size >= 4 then
         
         --Quinte flush (royale)
         for i in 0..(cards.size-2) loop
            if cards.set(i).colour /= cards.set(i+1).colour or cards.set(i).rank /= cards.set(i+1).rank + 1 then
               suite_trouvee := false;
            end if;
         end loop;
      
         if(suite_trouvee) then
            if cards.set(0).rank = 12 then
               combination.comb_type:=T_combination_type'Value("quinte_f_r");
               combination.cards := cards;
               return combination;
            else
               combination.comb_type:=T_combination_type'Value("quinte_f");
               return combination;
            end if;
            
         else
            suite_trouvee := true;
         end if;
         
         --Carre ?
         for i in 0..(cards.size-3) loop
            if cards.set(i).rank = cards.set(i+3).rank then
               combination.comb_type:=T_combination_type'Value("carre");
               for k in i..i+3 loop
                  addToSet(cards.set(k),combination.cards);
               end loop;
               for i in 1..cards.size loop
                  if not cardInSet(cards.set(i),combination.cards) then
                     addToSet(cards.set(i), combination.cards);
               end if;
            end loop;
               return combination;
            end if;
         end loop;
         
         --Full ?
         for i in 0..cards.size loop
            if cards.set(i).rank = cards.set(i+2).rank then
               brelan_trouve := true;
               index_brelan := i;
            end if;
         end loop;
         if brelan_trouve then
            if (index_brelan = 0 and cards.set(3).rank = cards.set(4).rank)
              or (index_brelan = 2 and cards.set(0).rank = cards.set(1).rank)
            then
               combination.comb_type:= T_combination_type'Value("full");
               return combination;
            end if;            
         end if;
         
         --Couleur (flush)
         for i in 0..(cards.size-2) loop
            if cards.set(i).colour /= cards.set(i+1).colour then
               suite_trouvee := false;
            end if;
         end loop; 
      
         if(suite_trouvee) then
            combination.comb_type:= T_combination_type'Value("couleur");
            return combination;
         else
            suite_trouvee := true;
         end if;
      
         
         --Suite
         for i in 0..(cards.size-2) loop
            if cards.set(i).rank /= cards.set(i+1).rank + 1 then
               suite_trouvee := false;
            end if;
         end loop;
      
         if(suite_trouvee) then
            combination.comb_type:= T_combination_type'Value("suite");
            return combination;
         else
            suite_trouvee := true;
         end if;
      end if; --Fin de "au moins 4 cartes"
      
      --Brelan
      for i in 0..(cards.size-3) loop
         if cards.set(i).rank = cards.set(i+2).rank then
            combination.comb_type:= T_combination_type'Value("brelan");
            addToSet(cards.set(i),combination.cards);
            addToSet(cards.set(i+1),combination.cards);
            addToSet(cards.set(i+2),combination.cards);
            for i in 1..cards.size loop
            if not cardInSet(cards.set(i),combination.cards) then
               addToSet(cards.set(i), combination.cards);
               end if;
            end loop;
            return combination;
         end if;
      end loop;
      
      --Paire(s)
      for i in 0..(cards.size-2) loop
         if cards.set(i).rank = cards.set(i+1).rank then
            n_paires := n_paires + 1;
            addToSet(cards.set(i),combination.cards);
            addToSet(cards.set(i+1),combination.cards);
         end if;
      end loop;
      if(n_paires = 1) then
         combination.comb_type:= T_combination_type'Value("paire");
         for i in 1..cards.size loop
            if not cardInSet(cards.set(i),combination.cards) then
               addToSet(cards.set(i), combination.cards);
               end if;
            end loop;
         return combination;
      elsif(n_paires >= 2) then
         combination.comb_type:= T_combination_type'Value("paire_2");
         for i in 1..cards.size loop
            if not cardInSet(cards.set(i),combination.cards) then
               addToSet(cards.set(i), combination.cards);
               end if;
            end loop;
         return combination;
      end if;
  
      combination.comb_type:= T_combination_type'Value("none");
      combination.cards := cards;
      return combination;
   end getBestCombination;
   
   
   procedure sortSet(set : in out T_set) is
      step : Boolean  := True;
      temp : T_card;
      index : Integer  := set.size;
   BEGIN
      LOOP
         step  := True;
         FOR I IN 0..index-2 LOOP
            IF set.set(I).rank  <set.set(I+1).rank  THEN
               temp := set.set(I);
               set.set(I) := set.set(I+1);
               set.set(I+1):=temp;
               step  := False;
            END IF;
         END  LOOP;
         exit  when  step;
      End  LOOP;
      
   end sortSet;
   
   function ">"(L : T_combination ; R : T_combination) return boolean is
   begin
      if(L.comb_type = R.comb_type) then 
         case L.comb_type is
            when none =>
               for i in 1..L.cards.size loop
                  if get_rank(L.cards.set(i))>get_rank(R.cards.set(i)) then return True;
                  elsif get_rank(L.cards.set(i))<get_rank(R.cards.set(i)) then return False;
                  end if;
               end loop;
            when paire =>
               if L.cards.set(0).rank>R.cards.set(0).rank then return True;
               elsif L.cards.set(0).rank<R.cards.set(0).rank then return False;
               else 
                  for i in 1..L.cards.size loop
                     if get_rank(L.cards.set(i))>get_rank(R.cards.set(i)) then return True;
                     elsif get_rank(L.cards.set(i))<get_rank(R.cards.set(i)) then return False;
                     end if;
                  end loop;
                  end if;
                  when others => return False;
                    
                  
          --none, paire, paire_2, brelan, suite, couleur, full, carre, quinte_f, quinte_f_r  
         end case;
      end if;
      for k in T_combination_type loop
         if L.comb_type = k then return False; end if;
         if R.comb_type = k then return True; end if;
         end loop;
      return false;
   end ">";
   
   
   function "+"(L : T_set; R : T_set) return T_set is
      total : T_set;
   begin
      emptySet(total);
      for i in 0..L.size-1 loop
         addToSet(L.set(i), total);
      end loop;
      for i in 0..R.size-1 loop
         addToSet(R.set(i), total);
      end loop;
      return total;
   end "+";
      
   procedure initGame(game : in out T_game) is
   begin
      --emptySet(game.history);
      game.round := 0;
      emptySet(game.table);
      emptySet(game.hand);
   end initGame;
   
   function cardInSet(card : in T_card; set : in T_set) return Boolean is
   begin
      for i in 0..get_size(set)-1 loop
         if get_card(set, i) = card then return True; end if;
      end loop;
      return false;
   end cardInSet;
   
   
   function get_settings (game : in T_game) return T_settings is
   begin
      return game.settings;
   end get_settings;
   
   function get_round(game : in T_game) return Integer is
   begin
      return game.round;
   end get_round;

   function get_pot(game : in T_game) return Integer is
   begin
      return game.pot;
   end get_pot;

   function get_table(game : in T_game) return T_set is
   begin
      return game.table;
   end get_table;

   function get_hand(game : in T_game) return  T_set is
   begin
      return game.hand;
   end get_hand;

   function get_op_hand(game : in T_game) return T_set is
   begin
      return game.op_hand;
   end get_op_hand;

   function get_my_money(game : in T_game) return Integer is
   begin
      return game.my_money;
   end get_my_money;

   function get_op_money(game : in T_game) return Integer is
   begin
      return game.op_money;
   end get_op_money;

   function get_button_is_mine(game : in T_game) return Boolean is
   begin
      return game.button_is_mine;
   end get_button_is_mine;

   function get_small_blind(game : in T_game) return Integer is
   begin
      return game.small_blind;
   end get_small_blind;

   function get_big_blind(game : in T_game) return Integer is
   begin
      return game.big_blind;
   end get_big_blind;

   function get_amount_to_call(game : in T_game) return Integer is
   begin
      return game.amount_to_call;
   end get_amount_to_call;

   function get_min_bet(game : in T_game) return Integer is
   begin
      return game.min_bet;
   end get_min_bet;


   procedure set_settings(game : in out T_game; val : in T_settings) is
   begin
      game.settings := val;
   end set_settings;


   procedure set_round(game : in out T_game; val : in Integer) is
   begin
      game.round := val;
   end set_round;


   procedure set_pot(game : in out T_game; val : in Integer) is
   begin
      game.pot := val;
   end set_pot;

   procedure set_table(game : in out T_game; val : in T_set) is
   begin
      game.table := val;
   end set_table;

   procedure set_hand(game : in out T_game; val : in  T_set) is
   begin
      game.hand := val;
   end set_hand;


   procedure set_op_hand(game : in out T_game; val : in T_set) is
   begin
      game.op_hand := val;
   end set_op_hand;


   procedure set_my_money(game : in out T_game; val : in Integer) is
   begin
      game.my_money := val;
   end set_my_money;


   procedure set_op_money(game : in out T_game; val : in Integer) is
   begin
      game.op_money := val;
   end set_op_money;


   procedure set_button_is_mine(game : in out T_game; val : in Boolean) is
   begin
      game.button_is_mine := val;
   end set_button_is_mine;


   procedure set_small_blind(game : in out T_game; val : in Integer) is
   begin
      game.small_blind := val;
   end set_small_blind;


   procedure set_big_blind(game : in out T_game; val : in Integer) is
   begin
      game.big_blind := val;
   end set_big_blind;


   procedure set_amount_to_call(game : in out T_game; val : in Integer) is
   begin
      game.amount_to_call := val;
   end set_amount_to_call;


   procedure set_min_bet(game : in out T_game; val : in Integer) is
   begin
      game.min_bet := val;
   end set_min_bet;
   
   function get_size (set : in T_set) return Natural is
   begin
      return set.size;
   end get_size;
   
   function get_card(set : in T_set; i : in Natural) return T_card is
   begin
      return set.set(i);
   end get_card;
   
   procedure set_card(set : in out T_set; i : in Natural; card : in T_card) is
   begin
      set.set(i) := card;
   end set_card;

   function get_rank(card : in T_card) return Integer is
   begin
      return card.rank;
   end get_rank;

   procedure set_rank(card : in out T_card; val : in Integer) is
   begin
      card.rank := val;
   end set_rank;

   function get_colour(card : in T_card) return T_colour is
   begin
      return card.colour;
   end get_colour;

   procedure set_colour(card : in out T_card; val : in T_colour) is
   begin
      card.colour := val;
   end set_colour;
   
   
   function get_timebank_max (settings : in T_settings) return Integer is
   begin
      return settings.timebank_max ;
   end get_timebank_max ;

   procedure set_timebank_max (settings : in out T_settings; val : in Integer) is
   begin
      settings.timebank_max  := val;
   end set_timebank_max ;

   function get_timebank_sup (settings : in T_settings) return Integer is
   begin
      return settings.timebank_sup ;
   end get_timebank_sup ;

   procedure set_timebank_sup (settings : in out T_settings; val : in Integer) is
   begin
      settings.timebank_sup  := val;
   end set_timebank_sup ;

   function get_hands_per_lvl(settings : in T_settings) return Integer is
   begin
      return settings.hands_per_lvl;
   end get_hands_per_lvl;

   procedure set_hands_per_lvl(settings : in out T_settings; val : in Integer) is
   begin
      settings.hands_per_lvl := val;
   end set_hands_per_lvl;
   
end utils;
