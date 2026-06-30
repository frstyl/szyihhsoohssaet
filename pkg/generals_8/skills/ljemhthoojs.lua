local ljemhthoojs = fk.CreateSkill {
  name = "ljemhthoojs",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["ljemhthoojs"] = "斂退",
  [":ljemhthoojs"] = "伱受傷旹,伱可與弃1手牌區或裝僃區全部牌(至少1)發動.當轉內,伱傷害旹防止之",

  ["#ljemhthoojs-invoke"] = "斂退 選擇所弃牌發動",
  ["handCards"] = "手牌",
  ["equips"] = "裝僃",

  ["@@ljemhthoojs-turn"] = "斂退",

  ["$ljemhthoojs1"] = "下官吿退",
  -- ["$ljemhthoojs2"] = "",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

ljemhthoojs:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ljemhthoojs.name) and not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local choices={"Cancel"}
    if #player:getCardIds("h")>0 then table.insert(choices,"handCards") end
    if #player:getCardIds("e")>0 then table.insert(choices,"equips") end
    local choice= player.room:askToChoice(player, {
          choices = choices,
          skill_name = ljemhthoojs.name,
          prompt = "#ljemhthoojs-invoke",
          -- all_choices = all_names,
          cancelable=true,
        })
       
    if choice~="Cancel" then 
      event:setCostData(self,{choice=choice}) 
      return    true
    end
  end,
  on_use = function(self, event, target, player, data)
    local cards= event:getCostData(self).choice=="handCards" and player:getCardIds("h") or player:getCardIds("e")
    player.room:throwCard(cards , ljemhthoojs.name, player, player)
    player.room:setPlayerMark(player, "@@ljemhthoojs-turn", 1)
  end,
})

ljemhthoojs:addEffect(fk.DamageInflicted, {
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:getMark("@@ljemhthoojs-turn") > 0
  end,
  on_use = function(self, event, target, player, data)
    player.room:sendLog{ type = "#PreventDamageBySkill", from = player.id, arg = ljemhthoojs.name }
    S.preventDamage({damageData=data,skillName=ljemhthoojs.name})
  end,
})
return ljemhthoojs