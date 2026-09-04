-- local U = require "packages/utility/utility"

local dzyetkeejs = fk.CreateSkill {
  name = "dzyetkeejs",
}

Fk:loadTranslationTable{
["dzyetkeejs"] = "絕計",
[":dzyetkeejs"] = "轉限1｡印牌:以伱全部手牌轉化起動一卽旹計謀A｡伱爲此牌增或減x目幖(x爲子牌數)",  --畫策牌无視距離?
["#dzyetkeejs"] = "絕計: 將1手牌轉化爲一卽旹計謀起動",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- local names=table.concat(table.filter(Fk:getAllCardNames("b"), function(name)
--       return S.isInstantTrick(name)
--     end),";")

dzyetkeejs:addEffect("viewas", {
  name = "dzyetkeejs",
  -- pattern = "^(szjemh,theem_prac_kaemh_tsoavs)|.|.|.|.|basic",
  pattern = ".|.|.|.|.|basic",
  prompt = "#dzyetkeejs",
  mute_card = true,  --牌特效
  interaction = function(self, player)
    local all_names =  table.filter(Fk:getAllCardNames("b"), function(name)
      return S.isInstantTrick(name)
    end)
    local names = player:getViewAsCardNames(dzyetkeejs.name, all_names)
    if #names == 0 then return end
    return UI.CardNameBox {choices = names, all_choices = all_names}
  end,
  handly_pile = false, 
  include_equip=false,
  filter_pattern = function (self, player, card_name)
    local cards = player:getCardIds("h")
    return {
      max_num = #cards,
      min_num = #cards,
      pattern = ".|.|.|hand",
      subcards = cards
    }
  end,
  card_filter = Util.FalseFunc,
  view_as = function(self, player, cards)
    local card = Fk:cloneCard(self.interaction.data)
    card:addSubcards(player:getCardIds("h"))
    S.mixCard(card)
    card.skillName = dzyetkeejs.name
    return card
  end,
  -- before_use = function(self, player, use)
  --   local n =#use.card.subcards

  --   if not data then player:drawCards(3) end
  --   local targets = data:getExtraTargets({bypass_distances = true})
  --   table.insertTable(targets, use.tos)
  --   local tos = room:askToChoosePlayers(player, {
  --     skill_name = dzyetkeejs.name,
  --     min_num = 0,
  --     max_num = n,
  --     targets = targets,
  --     prompt = "#dzyetkeejs-targets:::"..use.card:toLogString(),
  --     cancelable = true,
  --     extra_data = table.map(use.tos, Util.IdMapper),
  --     target_tip_name = "addandcanceltarget_tip",
  --   })
  --  for _, p in ipairs(tos) do
  --     if table.contains(data.tos, p) then
  --       data:removeTarget(p)
  --     else
  --       data:addTarget(p)
  --     end
  --   end
  -- end,
  enabled_at_play = function(self, player)
    return player:usedSkillTimes(dzyetkeejs.name) == 0  and   not player:isKongcheng()
  end,
  enabled_at_response = function(self, player, response)
    return player:usedSkillTimes(dzyetkeejs.name) == 0 and  not player:isKongcheng()  and    not response
  end,
  enabled_at_nullification = function(self, player, data)
    if not self:enabledAtResponse(player, false) then return end

    local all_names =  table.filter(Fk:getAllCardNames("b"), function(name)
      return S.isInstantTrick(name)
    end)
    local names = player:getViewAsCardNames(dzyetkeejs.name, all_names)  --攷慮封禁 旹機
    if #names == 0 then return end

    return true
  end,
})

dzyetkeejs:addEffect(fk.AfterCardTargetDeclared, {
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return data.card.skillName=="dzyetkeejs"
    and
    data.from==player
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    local n =#data.card.subcards

    local targets = data:getExtraTargets({bypass_distances = true, bypass_times=true})
    table.insertTable(targets, data.tos)
    local tos = room:askToChoosePlayers(player, {
      skill_name = dzyetkeejs.name,
      min_num = 1,
      max_num = n,
      targets = targets,
      prompt = "#dzyetkeejs-targets:::"..data.card:toLogString(),
      cancelable = true,
      extra_data = table.map(data.tos, Util.IdMapper),
      target_tip_name = "addandcanceltarget_tip",
    })
   for _, p in ipairs(tos) do
      if table.contains(data.tos, p) then
        data:removeTarget(p)
      else
        data:addTarget(p)
      end
    end
  
  end,
})
-- dzyetkeejs:addEffect("targetmod", {
--   bypass_distances = function(self, player, skill, card)
--     return card and table.contains(card.skillNames, dzyetkeejs.name)
--   end,
--   extra_target_func = function(self, player, skill, card)
--     return card and table.contains(card.skillNames, dzyetkeejs.name)
--   end,
-- })

return dzyetkeejs

