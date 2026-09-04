local U = require "packages/utility/utility"

local hzfektsshaek = fk.CreateSkill {
  name = "hzfektsshaek",
}

Fk:loadTranslationTable{
["hzfektsshaek"] = "劃策",
[":hzfektsshaek"] = "轉限1｡印牌:以伱1手牌轉化起動一卽旹計謀A",  --畫策牌无視距離?
["#hzfektsshaek"] = "劃策: 將1手牌轉化爲一卽旹計謀起動",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- local names=table.concat(table.filter(Fk:getAllCardNames("b"), function(name)
--       return S.isInstantTrick(name)
--     end),";")

hzfektsshaek:addEffect("viewas", {
  name = "hzfektsshaek",
  -- pattern = "^(szjemh,theem_prac_kaemh_tsoavs)|.|.|.|.|basic",
  pattern = ".|.|.|.|.|basic",
  prompt = "#hzfektsshaek",
  mute_card = true,  --牌特效
  interaction = function(self, player)
    local all_names =  table.filter(Fk:getAllCardNames("b"), function(name)
      return S.isInstantTrick(name)
    end)
    local names = player:getViewAsCardNames(hzfektsshaek.name, all_names)
    if #names == 0 then return end
    return UI.CardNameBox {choices = names, all_choices = all_names}
  end,
  handly_pile = true, 
  include_equip=false,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0
    and table.contains(player:getHandlyIds(), to_select)
    -- and not player:prohibitUse(to_select)
	end,
  view_as = function(self, player, cards)
    if #cards ~= 1 or not self.interaction.data then return end
    local card = Fk:cloneCard(self.interaction.data)
    card:addSubcard(cards[1])  --number?
    S.mixCard(card)
    card.skillName = hzfektsshaek.name
    return card
  end,
  enabled_at_play = function(self, player)
    return player:usedSkillTimes(hzfektsshaek.name) == 0  and #player:getHandlyIds() > 0
  end,
  enabled_at_response = function(self, player, response)
    return player:usedSkillTimes(hzfektsshaek.name) == 0 and #player:getHandlyIds() > 0  and    not response
  end,
  enabled_at_nullification = function(self, player, data)
    if not self:enabledAtResponse(player, false) then return end

    local all_names =  table.filter(Fk:getAllCardNames("b"), function(name)
      return S.isInstantTrick(name)
    end)
    local names = player:getViewAsCardNames(hzfektsshaek.name, all_names)  --攷慮封禁 旹機
    if #names == 0 then return end

    return true
  end,
})

-- hzfektsshaek:addEffect("targetmod", {
--   bypass_distances = function(self, player, skill, card)
--     return card and table.contains(card.skillNames, hzfektsshaek.name)
--   end,
-- })

return hzfektsshaek

