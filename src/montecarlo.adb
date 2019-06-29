with Ada.Numerics.Discrete_Random, utils;
use utils;
with botIO; use botIO;

package body montecarlo is
   package Rand_Int is new Ada.Numerics.Discrete_Random(Positive);
   gen : Rand_Int.Generator;
   
   function initSample(sample : in out T_set; hand : in T_set; table : in T_set) return Integer is
      c : T_card;
      size : Integer :=0;
   begin
      size := 2 + 5 - get_size(table);
      emptySet(sample);
         for i in 1..size loop
            loop
               c := randomCard(52);
               exit when not cardInSet(c, sample+hand+table);
            end loop;
            addToSet(c, sample);
         end loop;
      return size;
   end initSample;
   
   function randomCard(max : in Integer) return T_card is
      nb : Integer;
      card : T_card;
   begin
      Rand_Int.Reset(gen);
      nb := Rand_Int.Random(gen) mod max;
      set_rank(card, nb mod 13);
      set_colour(card, T_colour'Val(1+(nb -  nb mod 13)/13));
      return card;
   end randomCard;
   
   
   
   
         
   function chancesOfWinning(hand : T_set; table : T_set) return float is
      sample_size : Integer :=0;
      complementary_set : T_Set; -- Composé de 2 + (5-x) cartes, avec x le nombre de cartes dans T_set.
      set_enemy  : T_set;
      set_jeremy : T_set;
      complementary_table_set : T_set;
      best_enemy   : T_combination;    -- La meilleure combinaison de la table, et de la main générée de l'ennemi.
      best_jeremy  : T_combination;    -- La meilleure combinaison de la table et notre main.
      wins : Float  := 0.0;    -- Compteur de victoires.
   begin
      for i in 1..30000 loop
         sample_size := initSample(complementary_set,hand,table);
         emptySet(complementary_table_set);
         emptySet(set_enemy);
         emptySet(set_jeremy);
         --if i<50 then Put_Line("SAMPLE SIZE :"&Integer'Image(sample_size)&", TABLE_SIZE:"&Integer'Image(get_size(table)));end if;
         if sample_size>0 then 
            for i in 1..(8-sample_size) loop 
            addToSet(get_card(complementary_set,i-1), complementary_table_set);
            end loop;
            end if;
         set_enemy := set_enemy + table; -- On rajoute la table au set de l'ennemi.
         set_enemy := set_enemy + complementary_set;   -- On rajoute les cartes générées aléatoirement au set de l'ennemi.
         set_jeremy := set_jeremy + table;
         set_jeremy := set_jeremy + hand;
         set_jeremy := set_jeremy + complementary_table_set;
         best_enemy:=getBestCombination(set_enemy);
         best_jeremy:=getBestCombination(set_jeremy);
         if(best_jeremy > best_enemy) then
            wins := wins +1.0;
         end if;
         if i<50 and FALSE then
            Put_Line("------------------------------");Put_Line("Taille Jeremy :"&Integer'Image(get_size(set_jeremy))&", taille ennemy :"&Integer'Image(get_size(set_enemy)));
         Put_Line("Combinaison Jeremy :");
         for i in 1..get_size(set_jeremy) loop
            printCard(get_card(set_jeremy,i-1));
         end loop;
         Put_Line("VS ....");
         Put_Line("Combinaison Enemy :");
         for i in 1..get_size(set_enemy) loop
            printCard(get_card(set_enemy,i-1));
            end loop;
         Put_Line("RESULT : "&T_combination_type'Image(getBestCombination(set_jeremy).comb_type)&"vs"&T_combination_type'Image(getBestCombination(set_enemy).comb_type)&Boolean'Image(getBestCombination(set_jeremy)>getBestCombination(set_enemy)));
         end if;
      end loop;
      return wins/50000.0;
   end chancesOfWinning;
end montecarlo;
