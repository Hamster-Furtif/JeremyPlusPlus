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
   
   function cardInSet(card : in T_card; set : in T_set) return Boolean is
   begin
      for i in 0..get_size(set)-1 loop
         if get_card(set, i) = card then return True; end if;
      end loop;
      return false;
   end cardInSet;
   
   procedure addToSampleSets(sample : in out T_Sample; card : T_card) is
   begin
      for set of sample loop
         addToSet(card,set);
      end loop;
   end addToSampleSets;
         
   function chancesOfWinning(hand : T_set; table : T_set) return float is
      table_size : Integer :=0;
      complementary_set : T_Set; -- Composé de 2 + (5-x) cartes, avec x le nombre de cartes dans T_set.
      set_enemy  : T_set;
      set_jeremy : T_set;
      complementary_table_set : T_set;
      best_enemy   : T_combination;    -- La meilleure combinaison de la table, et de la main générée de l'ennemi.
      best_jeremy  : T_combination;    -- La meilleure combinaison de la table et notre main.
      wins : Float  := 0.0;    -- Compteur de victoires.
   begin
      for i in 1..50000 loop
         table_size := initSample(complementary_set,hand,table);
         emptySet(complementary_table_set);
         emptySet(set_enemy);
         emptySet(set_jeremy);
         if table_size/=5 then
            for i in 1..(5-table_size) loop 
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
         if (best_jeremy = best_enemy) then
            wins := wins + 0.5;
            end if;
      end loop;
      return wins/50000.0;
   end chancesOfWinning;
end montecarlo;
