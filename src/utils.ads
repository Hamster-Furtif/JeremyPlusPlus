with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

package utils is

   type T_colour is (empty, spades, hearts, diamonds, clovers);
   type T_move is (check, fold, call, bet);
   type T_combination is (none, paire, paire_2, brelan, suite, couleur, full, carre, quinte_f, quinte_f_r);
   type T_card   is
      record
         rank : Integer; --0 => 2, 13 => Ace
         colour : T_colour;
      end record;
   type T_card_list is Array(0..51) of T_card;
   type T_set is
      record
         set : T_card_list;
         size : Integer := 0;
      end record;
   type T_settings is
      record
         timebank_max  : Integer;
         timebank_sup  : Integer;  --temps gagné par coup
         hands_per_lvl : Integer;
      end record;
   type T_game is 
      record
         settings : T_settings;
         history : T_set;
         round : Integer;
         
         pot : Integer;
         
         table : T_set ;
         hand :  T_set;
         
         my_money : Integer;  --Mon argent
         op_money : Integer;  --L'argent de mon opposant
         
         button_is_mine : Boolean;
         
         small_blind : Integer;
         big_blind : Integer;
         
         amount_to_call : Integer;
         min_bet : Integer;
         
         last_op_move : T_move;
         
      end record;
   
   --Permet de comparer des combinaisons par superiorite selon les regles du poker 
   function ">"(L : T_combination ; R : T_combination) return boolean;
   
   --Permet de sommer deux T_Set
   function "+"(L : T_set; R : T_set) return T_set;

   
   --Permet d'ajouter une carte a un enssemble
   procedure addToSet(card : in T_card ; set : in out T_set);
   
   --Permet de vider ou d'initialiser un enssemble
   procedure emptySet(set : in out T_set);
   
   --Trie un enssemble par valeurs de cartes decroissantes
   procedure sortSet(set : in out T_set);
   
   --Trouve la meilleur combinaison possible avec les cartes de deux enssembles
   function getBestCombination(set : in T_set) return T_combination;
   
   --Initialise un t_game
   procedure initGame(game : in out T_game);

end utils;
