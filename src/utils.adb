with ada.Characters.Handling, utils, ada.Text_IO, ada.Integer_Text_IO, Ada.Calendar, botIO;
use ada.Characters.Handling, utils, ada.Text_IO, ada.Integer_Text_IO, Ada.Calendar, botIO;
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
      
      cards : T_set := set;
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
               return T_combination'Value("quinte_f_r");
            else
               return T_combination'Value("quinte_f");
            end if;
            
         else
            suite_trouvee := true;
         end if;
         
         --Carre ?
         for i in 0..(cards.size-3) loop
            if cards.set(i).rank = cards.set(i+3).rank then
               return T_combination'Value("carre");
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
               return T_combination'Value("full");
            end if;            
         end if;
         
         --Couleur (flush)
         for i in 0..(cards.size-2) loop
            if cards.set(i).colour /= cards.set(i+1).colour then
               suite_trouvee := false;
            end if;
         end loop;
      
         if(suite_trouvee) then
            return T_combination'Value("couleur");
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
            return T_combination'Value("suite");
         else
            suite_trouvee := true;
         end if;
      end if; --Fin de "au moins 4 cartes"
      
      --Brelan
      for i in 0..(cards.size-3) loop
         if cards.set(i).rank = cards.set(i+2).rank then
            return T_combination'Value("brelan");
         end if;
      end loop;
      
      --Paire(s)
      for i in 0..(cards.size-2) loop
         if cards.set(i).rank = cards.set(i+1).rank then
            n_paires := n_paires + 1;
         end if;
      end loop;
      if(n_paires = 1) then
         return T_combination'Value("paire");
      elsif(n_paires >= 2) then
         return T_combination'Value("paire_2");
      end if;
      
      return T_combination'Value("none");
      
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
      if( L = R) then return false; end if;
      for e in T_combination loop
         if(e = R) then return true; end if;
         if(e = L) then return false; end if;
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
      
   
end utils;
