local seenqtszjis = fk.CreateSkill {
  name = "seenqtszjis",
}

Fk:loadTranslationTable{
  ["seenqtszjis"] = "先至",
  [":seenqtszjis"] = "伱成爲牌目幖後,伱可發動:伱抽1,可起動1元實牌",


  ["#seenqtszjis-use"] = "先至 起動牌",

  ["$seenqtszjis1"] = "善战者后动，一击而毙敌。",
  ["$seenqtszjis2"] = "我所善者，后发制人尔。",
}

seenqtszjis:addEffect(fk.TargetConfirmed, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(seenqtszjis.name)
  end,
  -- on_cost = function(self, event, target, player, data)
  --   return player.room:askToSkillInvoke(player, {
  --     skill_name = seenqtszjis.name,
  --     prompt = "#seenqtszjis-invoke",
  --   })
  -- end,
  on_use = function(self, event, target, player, data)
    player:drawCards(1, seenqtszjis.name)
    player.room:askToUseRealCard(player, {
      pattern = player:getCardIds("h"),
      skill_name = seenqtszjis.name,
      prompt = "#seenqtszjis-use",
      extra_data = {
        bypass_times = false,
        extraUse = false,
        bypass_distances=false,
      },
      cancelable=true,
      skip=false,
    })

  end,
})

-- seenqtszjis:addEffect("targetmod", {
--   bypass_distances = function(self, player, skill, card,to)
--     return player:hasSkill(seenqtszjis.name) and card 
--     -- and
--     -- Fk.current and Fk.current.phase ~= Player.NotActive  
--     -- and to ==Fk.current
--     -- to==Fk:getCurrent()
--   end,
-- })

return seenqtszjis
