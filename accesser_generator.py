s = "timebank_max  : Integer;timebank_sup  : Integer;hands_per_lvl : Integer;"

split = s.split(";")
pars = []
tpe = []
for i in range(len(split)-1):
    k = split[i].split(":")
    pars.append(k[0][0:-1])
    tpe.append(k[1])

body = not not True
if not body :
    for i in range(len(pars)):
        print("function get_" + pars[i] + "(settings : in T_settings) return" + tpe[i] + ";")
        print("procedure set_" + pars[i] + "(settings : in out T_settings; val : in" + tpe[i]+");")
   
else: 
    for i in range(len(pars)):
        print("function get_" + pars[i] + "(settings : in T_settings) return" + tpe[i] + " is")
        print("begin")
        print("return game." + pars[i]+";")
        print("end get_" + pars[i]+";")
        print("")
        
        print("procedure set_" + pars[i] + "(settings : in out T_settings; val : in" + tpe[i]+") is")
        print("begin")
        print("game." + pars[i] + " := val;")
        print("end set_" + pars[i]+";")
        print("")

