local hqaeptshoac = fk.CreateSkill {
  name = "hqaeptshoac",
  derived_piles = "hqaeptshoac_dzzjek",
}

Fk:loadTranslationTable{
  ["hqaeptshoac"] = "厭倉",
  [":hqaeptshoac"] = "輪始旹,伱致傷後,伱可將1牌置于牌上,稱爲石｡恆續,伱存牌數+伱石數",

  ["hqaeptshoac_dzzjek"] = "石",
  ["#hqaeptshoac-ask"] = "厭倉：將一张牌置为 石",

  ["$hqaeptshoac1"] = "操权弄略，舍小利，而谋大计！",
  ["$hqaeptshoac2"] = "大丈夫行事，岂较一兵一将之得失？",
}

local spec = {
  on_use = function(self, event, target, player, data)
    local card = player.room:askToCards(player, {
      skill_name = hqaeptshoac.name,
      include_equip = true,
      min_num = 1,
      max_num = 1,
      prompt = "#hqaeptshoac-ask",
      cancelable = false,
    })
    if #card>0 then
      event:setCostData(self,{cards=card})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if player.dead then return end
    player:addToPile("hqaeptshoac_dzzjek", event:getCostData(self).cards, true, hqaeptshoac.name)
  end,
}

hqaeptshoac:addEffect(fk.RoundStart, {
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(hqaeptshoac.name) 
  end,
  on_cost = spec.on_cost,
  on_use = spec.on_use,
})

hqaeptshoac:addEffect(fk.Damaged, {
  anim_type = "masochism",
  trigger_times = function(self, event, target, player, data)
    return data.damage
  end,
  can_trigger = function (self, event, target, player, data)
    return target == player and player:hasSkill(hqaeptshoac.name)
  end,
  on_cost = spec.on_cost,
  on_use = spec.on_use,

})

hqaeptshoac:addEffect("maxcards", {
  correct_func = function(self, player)
    if player:hasSkill(hqaeptshoac.name) then
      return #player:getPile("hqaeptshoac_dzzjek")
    end
  end,
})

return hqaeptshoac
