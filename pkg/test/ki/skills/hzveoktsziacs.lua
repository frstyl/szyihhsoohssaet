local ciqprac = fk.CreateSkill{
  name = "ciqprac",
}

Fk:loadTranslationTable{
  ["ciqprac"] = "疑兵", --惑障
  [":ciqprac"] = "腳色A成爲起動目幖後,若其在伱攻程內或伱爲來源,伱可發動｡A獲得1空",

  ["#ciqprac-invoke"] = "疑兵 對 %dest 發動  其獲得1空",


  ["$ciqprac"] = "打甚鳥緊,看洒家之",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


ciqprac:addEffect(fk.TargetConfirmed, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(ciqprac.name) 
      and (data.to==player or data.from==player or player:inMyAttackRange( data.to))
  end,
  on_cost = function(self, event, target, player, data)

      if player.room:askToSkillInvoke(player, { skill_name = ciqprac.name,prompt="#ciqprac-invoke::"..data.to.id }) then
        event:setCostData(self,{tos={data.to}})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    S.printKhoucTo(player,1,ciqprac.name)
  end,
})



return ciqprac
