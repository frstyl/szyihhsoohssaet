local tszjechbxis = fk.CreateSkill {
  name = "tszjechbxis",
}

Fk:loadTranslationTable{
  ["tszjechbxis"] = "整僃",
  [":tszjechbxis"] = "任一末段終旹,若伱當轉{受/未受}曾傷,伱可將1牌轉化爲{糧艸先行/肉}起動",

  ["#tszjechbxis-use-recover"] = "整僃：將1牌轉化爲 肉 起動",
  ["#tszjechbxis-use-draw"] = "整僃：將1牌轉化爲 糧艸先行 起動",

  ["$tszjechbxis1"] = "承白雀之瑞，显周公之德。",
  ["$tszjechbxis2"] = "挽汉室于危亡，继光武之中兴。",
}

tszjechbxis:addEffect(fk.EventPhaseEnd, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(tszjechbxis.name) and target.phase == Player.Finish 
    and not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local use={}
    if  #player.room.logic:getActualDamageEvents(1, function(e)
        return e.data.to == player
      end) > 0 
    then
           use = player.room:askToUseVirtualCard(player, {
      name = "peach",
      skill_name = tszjechbxis.name,
      prompt = "#tszjechbxis-use-recover",
      cancelable = true,

      card_filter = {
        n = 1,
        pattern=".|.|.",
        -- cards = cards,
      },
      skip = true,
    })
    else
           use = player.room:askToUseVirtualCard(player, {
      name = "ex_nihilo",
      skill_name = tszjechbxis.name,
      prompt = "#tszjechbxis-use-draw",
      cancelable = true,

      card_filter = {
        n = 1,
        pattern=".|.|.",
        -- cards = cards,
      },
      skip = true,
    })
    end

    if use then
      event:setCostData(self, {use = use})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:useCard(event:getCostData(self).use)
  end,
})

return tszjechbxis
