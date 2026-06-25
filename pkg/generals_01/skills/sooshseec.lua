local sooshseec = fk.CreateSkill {
  name = "sooshseec",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["sooshseec"] = "𦃃馨",
  [":sooshseec"] = "伱主段終旹,伱可預弃1牌選擇1角色發動.伱爲所選角色附加免敔,且至伱下次發動此技能,其致傷後,伱抽1",

  ["#sooshseec-choose"] = "𦃃馨 選擇目幖",

  ["$sooshseec1"] = "曲有误，不可不顾。",
  ["$sooshseec2"] = "兀音曳绕梁，愿君去芜存菁。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

sooshseec:addEffect(fk.EventPhaseEnd, {
  anim_type = "support",
  can_trigger = function (self, event, target, player, data)
    return target==player and  player:hasSkill(sooshseec.name)  and data.phase==Player.Play
  end,
  on_cost= function(self, event, target, player, data)
    local tos, cards = player.room:askToChooseCardsAndPlayers(player, {
      min_card_num = 1,
      max_card_num = 1,
      include_equip=true,
      will_throw=true,
      min_num = 1,
      max_num = 1,
      targets = player.room.alive_players,
      skill_name = sooshseec.name,
      prompt = "#sooshseec-choose",
      cancelable = true,
    })
    if #tos > 0 and #cards > 0 then
      event:setCostData(self, {tos = tos, cards = cards})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local to =event:getCostData(self).tos[1]
    player.room:throwCard(event:getCostData(self).cards, sooshseec.name, player,player)
    player.room:setPlayerMark(player, "sooshseec", to.id)
    S.addTsziukzzyitBuff(to,  "mxenhcioh",player)
  end,
})

sooshseec:addEffect(fk.Damage, {
  anim_type = "support",
  is_delay=true,
  can_trigger = function (self, event, target, player, data)
    return player:getMark("sooshseec") ==target.id
  end,
  on_trigger = function (self, event, target, player, data)
    player:drawCards(1,sooshseec.name)
  end,
})
return sooshseec
