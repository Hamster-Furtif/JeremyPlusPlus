with ada.Strings.Unbounded, utils, montecarlo, ada.Integer_Text_IO;
use ada.Strings.Unbounded, utils, montecarlo, ada.Integer_Text_IO;

package botIO is

   type T_prefix is (settings, update_game, update_hand, action);
   type T_params is Array(0..7) of Unbounded_String;
   type T_command is 
      record
         prefix : T_prefix;
         pars : T_params;
         size : Integer;
      end record;
   
   --Decoupe une chaine envoyee par le launcher au niveau des espaces et des guillements, et renvoie une commande
   function splitLine(line : String; line_length : Integer) return T_command;
   
   --Permet d'interpreter des commandes de type settings, update_game et update_hand
   procedure readSettings(command : T_command; game :  in out T_game);
   procedure readUpdateGame(command : T_command; game :  in out T_game);
   procedure readUpdateHand(command : T_command; game : in out T_game;  sample : in out T_Sample);   
   
   --Affiche la valeur et la couleur d'une carte dans la console (sert a debugger)
   procedure printCard(card : in T_card);

   --Permet de lire une carte selon le formalisme du launcher
   function parseCard(str : in String) return T_card;
   
end botIO;
