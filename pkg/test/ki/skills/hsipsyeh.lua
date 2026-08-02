local hsipsyeh = fk.CreateSkill {
  name = "hsipsyeh",
}

Fk:loadTranslationTable{
  ["hsipsyeh"] = "吸髓",
  [":hsipsyeh"] = "主旹,一脚色進入瀕死旹,選1其它有牌脚色發動｡伱觀看其全部牌,可起動其1｡",

  ["#hsipsyeh"] = "吸髓：觀看其它脚色手牌，且可以起動其1",
  ["#hsipsyeh-choose"] = "吸髓：伱可起動其1",
  ["#hsipsyeh-use"] = "吸髓：起動%arg",

  ["$hsipsyeh1"] = "将军今出洛阳，恐难再回。",
  ["$hsipsyeh2"] = "贼示弱于外，必包藏祸心。",
}

-- Fk:addPoxiMethod{
--   name = "hsipsyeh",
--   prompt = "#hsipsyeh-choose",
--   card_filter = function(to_select, selected, data, extra_data)
--     return #selected == 0 and table.contains(extra_data.hsipsyeh_cards, to_select)
--   end,
--   feasible = function(selected, data)
--     return #selected == 1
--   end,
-- }

hsipsyeh:addEffect("active", {
  anim_type = "control",
  prompt = "#hsipsyeh",
  target_num = 1,
  card_num = 0,
  can_use = function(self, player)
    return
    player:usedEffectTimes(hsipsyeh.name, Player.HistoryPhase) == 0
  end,
  card_filter = Util.FalseFunc,
  target_filter = function(self, player, to_select, selected)
    return #selected == 0 and to_select ~= player and not to_select:isNude()--to_select:isKongcheng()
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = effect.tos[1]
    -- local cards = table.filter(target:getCardIds("h"), function (id)
    --   return #Fk:getCardById(id):getDefaultTarget(player, {bypass_times = true}) > 0
    -- end)
    if target:isKongcheng() then return end
    
    local cards = room:askToChooseCards(player, {
        target = target,
        min = 0,
        max = 1,
        -- flag = "he",
        flag = { card_data = {{ "$Hand", target:getCardIds("h") },{"$Equip", target:getCardIds("e")}} },  --可見
        skill_name = hsipsyeh.name,
        prompt = "#hsipsyeh-choose",
      })
    if #cards==0 then return end
    room:askToUseRealCard(player, {
      pattern = cards,
      skill_name = hsipsyeh.name,
      prompt = "#hsipsyeh-use:::"..Fk:getCardById(cards[1]):toLogString(),
      extra_data = {
        bypass_times = false,
        bypass_distances=false,
        extraUse = false,
        expand_pile = cards,
      },
    })
  end,
})

hsipsyeh:addEffect(fk.EnterDying, {
  anim_type = "control",
  can_trigger = function (self, event, target, player, data)
    return  player:hasSkill(hsipsyeh.name)
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room
    local success, dat = room:askToUseActiveSkill(player, {
      skill_name = "hsipsyeh",
      prompt = "#hsipsyeh",
      cancelable = true,
      skip = true,
    })
    if success and dat then
      event:setCostData(self, {tos = dat.targets})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local tos = event:getCostData(self).tos
    local skill = Fk.skills["hsipsyeh"]
    skill:onUse(player.room, {  --useSkill
      from = player,
      tos = tos,
    })
  end,
})
return hsipsyeh
