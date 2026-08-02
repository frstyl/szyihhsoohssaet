local attack_range = fk.CreateSkill{
  name = "attack_range",
}


Fk:loadTranslationTable{

  ["@minus_attack_range"] = "攻程-",
  ["@add_attack_range"] = "攻程",

}


attack_range:addEffect("atkrange", {
  correct_func = function(self, player)
    local n = 0
    local t = {"","-round" , "-turn" , "-phase" , "-noclear"}

    for _, suffix in ipairs(t) do
      n=n+player:getMark("@add_attack_range"..suffix) 
      n=n-player:getMark("@minus_attack_range"..suffix) 
    end
    return n
  end
})


return attack_range
