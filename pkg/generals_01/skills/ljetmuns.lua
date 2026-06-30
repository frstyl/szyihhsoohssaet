Fk:loadTranslationTable{
  ["ljetmuns"] = "裂璺",
  [":ljetmuns"] = "鎖定.伱死亾旹必發.選1至2角色,伱令其流失x體力.(x爲其裝僃區牌數至少爲1)",

  ["#ljetmuns-choose"] = "裂璺 1至2角色發動,伱弃其裝僃區全部牌",

  ["$ljetmuns1"] = "哈哈哈哈哈哈哈哈！",
  ["$ljetmuns2"] = "伯符，且看我这一手！",
}

local ljetmuns = fk.CreateSkill{
  name = "ljetmuns",
  tags = { Skill.Compulsory,Skill.Permanent },
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

ljetmuns:addEffect(fk.Death, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(ljetmuns.name,false,true)
  end,
  -- on_cost= function(self, event, target, player, data)
  --   local tos = player.room:askToChoosePlayers(player, {
  --     min_num = 1,
  --     max_num = 2,
  --     targets = player.room.alive_players,  --
  --     skill_name = ljetmuns.name,
  --     prompt = "#ljetmuns-choose",
  --     cancelable = true,
  --   })
  --   if #tos > 0 then
  --     event:setCostData(self, {tos = tos})
  --     return true
  --   end
  -- end,
  on_use = function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = player.room.alive_players,  --
      skill_name = ljetmuns.name,
      prompt = "#ljetmuns-choose",
      cancelable = true,
    })
    player.room:loseHp(tos[1], math.max(1,#tos[1]:getCardIds("e")),player)
  end,
})


return ljetmuns
