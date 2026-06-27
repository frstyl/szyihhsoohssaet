local likgxim = fk.CreateSkill{
  name = "likgxim",
}
Fk:loadTranslationTable{
  ["likgxim"] = "力擒",
  [":likgxim"] = "主旹,伱可預選擇1牌交予其它角色發動｡視爲伱對該角色使用鬥將(不可抵消),其隨機弃2牌且若其體力值小于伱,此技能失效",

  ["#likgxim-choose"] = "力擒 爲1角色敺㪔咒術",

  ["$likgxim1"] = "能保則吉更當修爲",
  ["$likgxim2"] = "切摸妄作萬福來宜",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

likgxim:addEffect("active", {  --非轉化
  anim_type = "offensive",
  prompt = "#likgxim",
  -- max_phase_use_time = 1,
  card_num = 1,
  target_num = 1,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(likgxim.name, Player.HistoryPhase) == 0
  -- end,
  -- interaction = function(self, player)
  --     return UI.ComboBox {
  --     choices = {"buff","debuff"}
  --   }
  -- end,
  card_filter = Util.TrueFunc,
  target_filter = function(self, player, to_select, selected)
    return #selected == 0 and to_select~=player
  end,
  on_use = function(self, room, effect)
    local target=effect.tos[1]
    local player=effect.from
    room:moveCardTo(effect.cards, Player.Hand, target, fk.ReasonGive, likgxim.name, nil, false, player.id)
    if player.dead or target.dead then return end

    local card = Fk:cloneCard("duel")
    card.skillName = likgxim.name
    if not  player:canUseTo(card, target, {bypass_distances = true, bypass_times = true}) then player:drawCards(5) return end

    room:useCard{  --bypase times
      from = player,
      tos = {target},
      card = card,
      unoffsetableList = table.simpleClone(room.players),
    }
    if not target.dead then 
      local cards = table.filter(target:getCardIds("h"), function (id)
        return not target:prohibitDiscard(id)
      end)
      if #cards > 0 then
        room:throwCard(table.random(cards,2), likgxim.name, target, target)
      end
    end
  end,
})


return likgxim
