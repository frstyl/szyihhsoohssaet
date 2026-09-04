local dzyenqhzvoat = fk.CreateSkill {
  name = "dzyenqhzvoat",
}

Fk:loadTranslationTable{
  ["dzyenqhzvoat"] = "全𣴠",
  [":dzyenqhzvoat"] = "應動｡一腳色A旹,若致命,伱可發動,伱防止傷害,A弃置其全部牌",

  ["#dzyenqhzvoat-invoke"] = "整列：伱可對 %dest 發動",
  ["#dzyenqhzvoat-discard"] = "%dest 對伱發動 整列, 伱需弃 %arg 牌",


  -- ["$dzyenqhzvoat1"] = "典将军，比比看谁杀敌更多！",
  -- ["$dzyenqhzvoat2"] = "父亲快走，有我殿后！"
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 
  
dzyenqhzvoat:addEffect(fk.DamageInflicted, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(dzyenqhzvoat.name) 
    and data.damage>=data.to.hp
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room
    if room:askToSkillInvoke(player, {
      skill_name = dzyenqhzvoat.name,
      prompt = "#dzyenqhzvoat-invoke::"..data.to.id,
    }) then
      event:setCostData(self, {tos = {data.to}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    S.preventDamage({damageData=data,skillName=dzyenqhzvoat.name})
    data.to:throwAllCards("dzyenqhzvoat",dzyenqhzvoat.name)
  end,
})

return dzyenqhzvoat
