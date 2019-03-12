s = "settings : T_settings;round : Integer;pot : Integer;table : T_set;hand :  T_set;op_hand : T_set;my_money : Integer;op_money : Integer;button_is_mine : Boolean;small_blind : Integer;big_blind : Integer;amount_to_call : Integer;min_bet : Integer;"

split = s.split(";")
pars = []
tpe = []
for i in range(len(split)-1):
    k = split[i].split(":")
    pars.append(k[0][0:-1])
    tpe.append(k[1])

body = True
if not body :
    for i in range(len(pars)):
        print("function get_" + pars[i] + "(game : in T_game) return" + tpe[i] + ";")
        print("procedure set_" + pars[i] + "(game : in out T_game; val : in" + tpe[i]+");")
   
else: 
    for i in range(len(pars)):
        print("function get_" + pars[i] + "(game : in T_game) return" + tpe[i] + " is")
        print("begin")
        print("return game." + pars[i]+";")
        print("end get_" + pars[i]+";")
        print("")
        
        print("procedure set_" + pars[i] + "(game : in out T_game; val : in" + tpe[i]+") is")
        print("begin")
        print("game." + pars[i] + " := val;")
        print("end set_" + pars[i]+";")
        print("")

