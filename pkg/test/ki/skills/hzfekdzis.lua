local hzfekdzis = fk.CreateSkill {
  name = "hzfekdzis",
}

Fk:loadTranslationTable{
  ["hzfekdzis"] = "畫字",
  [":hzfekdzis"] = "印牌:以1牌轉化起動基本牌,須二者名字數相等",

  ["#hzfekdzis"] = "畫字 以1牌轉化起動基本牌,需二者名字數相等",

  ["$hzfekdzis1"] = "暑气可借酒气消，此间艳阳最佐酒！",
  ["$hzfekdzis2"] = "诸君饮泥而醉，举世唯我独醒！",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hzfekdzis:addEffect("viewas", {
  prompt = "#hzfekdzis",
  interaction = function(self, player)
    local all_names = table.filter(Fk:getAllCardNames("bd"), function(name) return S.isCoreCard(name) end)
    local names = player:getViewAsCardNames(hzfekdzis.name, all_names)
    if #names > 0 then
      return UI.CardNameBox {choices = names, all_choices = all_names}
    end
  end,
  filter_pattern = {
    min_num = 1,
    max_num = 1,
    pattern = ".",
  },
  card_filter = function(self, player, to_select, selected)
    if #selected > 0 or not self.interaction.data then return false end
    local card = Fk:cloneCard(self.interaction.data)
    return card:getNameLength() == Fk:getCardById(to_select):getNameLength()
  end,
  view_as = function(self, player, cards)
    if #cards == 0 or not self.interaction.data then return end
    local card = Fk:cloneCard(self.interaction.data)
    card:addSubcards(cards)
	S.mixCard(card)
    card.skillName = hzfekdzis.name
    return card
  end,
  before_use = function(self, player, use)
    use.extraUse = true
  end,
  enabled_at_play = function(self, player)
    -- return player:usedSkillTimes(hzfekdzis.name, Player.HistoryPhase) == 0
    return true
  end,
  enabled_at_response = function(self, player,response)
    return not response
  end,
})

hzfekdzis:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card)
    return card and table.contains(card.skillNames, hzfekdzis.name)
  end,
  bypass_distances = function(self, player, skill, card)
    return card and table.contains(card.skillNames, hzfekdzis.name)
  end,
})

return hzfekdzis
