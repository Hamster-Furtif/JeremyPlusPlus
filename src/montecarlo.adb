with Ada.Numerics.Discrete_Random, utils;
use utils;

package body montecarlo is
   package Rand_Int is new Ada.Numerics.Discrete_Random(Positive);
   gen : Rand_Int.Generator;
   
   procedure initSample(sample : in out T_Sample; cards : in T_set) is
   c : T_card;
   begin
      for set of sample loop
         emptySet(set);
         for i in 1..2 loop
            loop
               c := randomCard(52);
               exit when not cardInSet(c, cards+set);
            end loop;
            addToSet(c, set);
         end loop;
      end loop;
      
   end initSample;
   
   function randomCard(max : in Integer) return T_card is
      nb : Integer;
      card : T_card;
   begin
      nb := Rand_Int.Random(gen) mod max;
      card.rank := nb mod 13;
      card.colour := T_colour'Val(1+(nb -  nb mod 13)/13);
      return card;
   end randomCard;
   
   function cardInSet(card : in T_card; set : in T_set) return Boolean is
   begin
      for i in 0..set.size-1 loop
         if set.set(i) = card then return True; end if;
      end loop;
      return false;
   end cardInSet;
   
   procedure addToSampleSets(sample : in out T_Sample; card : T_card) is
   begin
      for set of sample loop
         addToSet(card,set);
      end loop;
   end addToSampleSets;
         
   function chancesOfWinning(sample : in T_Sample; best : in T_combination) return float is
      best_in_sample : T_combination;
      weaker_hands : Integer := 0;
   begin
      for set of sample loop
         best_in_sample :=  getBestCombination(set);
         if(best > best_in_sample) then
            weaker_hands := weaker_hands +1;
         end if;
      end loop;

      
      return Float(weaker_hands)/Float(SAMPLE_SIZE);
   end chancesOfWinning;
   
end montecarlo;
