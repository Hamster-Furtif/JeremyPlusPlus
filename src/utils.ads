with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

package utils is

   
   
   type T_colour is (empty, spades, hearts, diamonds, clovers);
   type T_move is (check, fold, call, bet, none);
   type T_set is private;
   type T_combination_type is (none, paire, paire_2, paire_3, brelan, suite, couleur, full, carre, quinte_f, quinte_f_r);
   type T_combination is record
      comb_type : T_combination_type;
      lenght : Integer;
      cards: T_set;
      end record;
   
   type T_card is private;
   
   type T_game is private;
   type T_settings is private;
   
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
   
   --E/ card : T_card
   --E/ set : T_set
   --Necessite : None
   --S/ : Boolean
   --Entraine   :Verifie qu'un ensemble contient une carte en particulier
   function cardInSet(card : in T_card; set : in T_set) return Boolean;
   
   --Accesseurs generes en python
   function get_settings (game : in T_game) return T_settings;
   procedure set_settings(game : in out T_game; val : in T_settings);
   function get_round(game : in T_game) return Integer;
   procedure set_round(game : in out T_game; val : in Integer);
   function get_pot(game : in T_game) return Integer;
   procedure set_pot(game : in out T_game; val : in Integer);
   function get_table(game : in T_game) return T_set;
   procedure set_table(game : in out T_game; val : in T_set);
   function get_hand(game : in T_game) return  T_set;
   procedure set_hand(game : in out T_game; val : in  T_set);
   function get_op_hand(game : in T_game) return T_set;
   procedure set_op_hand(game : in out T_game; val : in T_set);
   function get_my_money(game : in T_game) return Integer;
   procedure set_my_money(game : in out T_game; val : in Integer);
   function get_op_money(game : in T_game) return Integer;
   procedure set_op_money(game : in out T_game; val : in Integer);
   function get_button_is_mine(game : in T_game) return Boolean;
   procedure set_button_is_mine(game : in out T_game; val : in Boolean);
   function get_small_blind(game : in T_game) return Integer;
   procedure set_small_blind(game : in out T_game; val : in Integer);
   function get_big_blind(game : in T_game) return Integer;
   procedure set_big_blind(game : in out T_game; val : in Integer);
   function get_amount_to_call(game : in T_game) return Integer;
   procedure set_amount_to_call(game : in out T_game; val : in Integer);
   function get_min_bet(game : in T_game) return Integer;
   procedure set_min_bet(game : in out T_game; val : in Integer);
   
   function get_size (set : in T_set) return Natural;
   function get_card(set : in T_set; i : in Natural) return T_card;
   procedure set_card(set : in out T_set; i : in Natural; card : in T_card);

   
   function get_rank(card : in T_card) return Integer;
   procedure set_rank(card : in out T_card; val : in Integer);
   function get_colour(card : in T_card) return T_colour;
   procedure set_colour(card : in out T_card; val : in T_colour);
   
   function get_timebank_max (settings : in T_settings) return Integer;
   procedure set_timebank_max (settings : in out T_settings; val : in Integer);
   function get_timebank_sup (settings : in T_settings) return Integer;
   procedure set_timebank_sup (settings : in out T_settings; val : in Integer);
   function get_hands_per_lvl(settings : in T_settings) return Integer;
   procedure set_hands_per_lvl(settings : in out T_settings; val : in Integer);

private
   
   type T_card   is
      record
         rank : Integer; --0 => 2, 13 => Ace
         colour : T_colour;
      end record;
 
   type T_card_list is Array(0..52) of T_card;
 
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
         round : Integer;
         
         pot : Integer;
         
         table : T_set;
         hand :  T_set;
         op_hand : T_set;
         
         my_money : Integer;  --Mon argent
         op_money : Integer;  --L'argent de mon opposant
         
         button_is_mine : Boolean;
         
         small_blind : Integer;
         big_blind : Integer;
         
         amount_to_call : Integer;
         min_bet : Integer;
                  
      end record;

end utils;
