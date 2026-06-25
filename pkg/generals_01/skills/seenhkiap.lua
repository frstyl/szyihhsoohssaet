Fk:loadTranslationTable{
  ["seenhkiap"] = "洗劫",
  [":seenhkiap"] = "伱死亾旹必可選1至2角色發動,伱弃其裝僃區全部牌",

  ["#seenhkiap-choose"] = "洗劫 1至2角色發動,伱弃其裝僃區全部牌",

  ["$seenhkiap1"] = "哈哈哈哈哈哈哈哈！",
  ["$seenhkiap2"] = "伯符，且看我这一手！",
}

local seenhkiap = fk.CreateSkill{
  name = "seenhkiap",
  -- tags = { Skill.Compulsory,Skill.Permanent },
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

seenhkiap:addEffect(fk.Death, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(seenhkiap.name,false,true)
  end,
  on_cost= function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 2,
      targets = player.room.alive_players,  --
      skill_name = seenhkiap.name,
      prompt = "#seenhkiap-choose",
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
   for _,p in ipairs(event:getCostData(self).tos) do
    if not p.dead then
      room:throwCard(p:getCardIds("e"),seenhkiap.name, p, player)
    end
   end
  end,
})


return seenhkiap
