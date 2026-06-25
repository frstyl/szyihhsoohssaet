local hzoonqtsiuh = fk.CreateSkill {
  name = "hzoonqtsiuh",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["hzoonqtsiuh"] = "渾酒",
  [":hzoonqtsiuh"] = "當伱可使用{酒/肉/迷}旹,伱可將1酒肉迷轉化爲其使用發動,此牌執行效果後伱執行元牌效果.渾酒迷可選擇其它角色",

  ["#hzoonqtsiuh"] = "渾酒：酒肉迷轉化爲酒肉迷",
  -- ["#hzoonqtsiuh-choose"] = "渾酒：爲 %arg 選擇額外目幖",
  -- ["#hzoonqtsiuh-extraUse"] = "渾酒 是否令 %arg 不計入次數",

  ["$hzoonqtsiuh1"] = "客官,昰酒可渾",
}

hzoonqtsiuh:addEffect("viewas", {
  anim_type = "offensive",
  prompt = "#hzoonqtsiuh",
  mute_card = true,
  interaction = function(self, player)
    return UI.CardNameBox {
      choices = player:getViewAsCardNames(hzoonqtsiuh.name, {"nziuk","tsiuh","free__meej"}, player:getCardIds("h")),
      all_choices = {"nziuk","tsiuh","free__meej"},
      default_choice = "free__meej",
    }
  end,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains({"nziuk","tsiuh","meej"} ,Fk:getCardById(to_select).trueName )
  end,
  view_as = function(self, player, cards)  --待改 如轉化歬不能用 轉化後不能用
    if Fk.all_card_types[self.interaction.data] == nil or  #cards ~= 1 then return end
    local card = Fk:cloneCard(self.interaction.data)
    card:addSubcard(cards[1])
    card.skillName = hzoonqtsiuh.name
    return card
  end,
  before_use = function(self, player, use)
    use.extra_data =use.extra_data or {}
    use.extra_data.hzoonqtsiuh = player.id
  end,
  -- after_use = function(self, player, use)
  --   player:drawCards(1,hzoonqtsiuh)
  -- end,
  enabled_at_response = function(self, player, response) 
    return  not response 
  end,
})

hzoonqtsiuh:addEffect(fk.CardEffectFinished, {
  is_delay_effect=true,
  can_refresh = function(self, event, target, player, data)
    return 
     table.contains(data.card.skillNames, hzoonqtsiuh.name)
     and
     data.extra_data and data.extra_data.hzoonqtsiuh == player.id
  end,
  on_refresh= function(self, event, target, player, data)
    local card= Fk:getCardById(data.card.subcards[1])
    if not card then return end
    local effect_data = CardEffectData:new {
        card = card,
        to = player,
        from=player,
        tos = { player },
      }
      player.room:doCardEffect(effect_data)
  end,
})

-- hzoonqtsiuh:addEffect(fk.PreCardUse,{
--   can_trigger = function (self, event, target, player, data)
--     return target == player  and data.card
--       and data.card:getMark("@@ddwenqtsjens-inhand")>0
--   end,
--   on_cost = function(self, event, target, player, data)
--     return player.room:askToSkillInvoke(player,{
--       skill_name=hzoonqtsiuh.name, 
--       prompt="#hzoonqtsiuh-extraUse::"..data.card:toLogString(),
--     })
--   end,
--   on_use = function(self, event, target, player, data)
--     data.extraUse = true
--   end,
-- })



-- hzoonqtsiuh:addEffect(fk.CardUsing, {  --refresh?
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     return   player:hasSkill(hzoonqtsiuh.name) 
--     and target == player
--     and table.contains({"nziuk", "tsiuh", "meej"}, data.card.trueName)
--   end,
--   on_cost = function(self, event, target, player, data)
-- 		local tos = player.room:askToChoosePlayers(player,{
--       targets=data:getExtraTargets(),
--       min_num=1,
--       max_num=1,
--       cancelable=true,
--       prompt = "#hzoonqtsiuh-choose::"..data.card:toLogString(),
--     })
--     if #tos ~= 0 then
--       event:setCostData(self, {tos = tos})
--       return true
--     end
--   end,
--   on_use = function(self, event, target, player, data)
--     data:addTarget(event:getCostData(self).tos[1])
--   end,
-- })




return hzoonqtsiuh
