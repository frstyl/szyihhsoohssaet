local sjiqkius = fk.CreateSkill {
  name = "sjiqkius",
}

Fk:loadTranslationTable{
  ["sjiqkius"] = "私救",
  [":sjiqkius"] = "主旹,預打出1肉選擇1其它角色發動,其回2抽1,獲得報幖記(伱可發動1次私救)。",

  ["#sjiqkius"] = "弃1肉 令1角色回2抽1",

  ["@@poavs"] = "報",

  ["$sjiqkius1"] = "此地雖好也也不是安身之處",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

sjiqkius:addEffect("active", {
  anim_type = "support",
  card_num = 1,
  target_num = 1,
  prompt = "#sjiqkius",
  can_use = function(self, player)
    return player:usedSkillTimes(sjiqkius.name, Player.HistoryPhase) == 0
  end,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getCardIds("h"), to_select)
    and Fk:getCardById(to_select).name=="nziuk"
    and  not player:prohibitResponse(to_select)
  end,
  target_filter = function(self, player, to_select, selected, selected_cards)
      return (#selected == 0 and to_select~=player) and to_select:isWounded()
  end,
  on_use = function(self, room, effect)
    local from = effect.from
    local to = effect.tos[1]  --
    S.playCard(effect.from,effect.cards,sjiqkius.name)
    room:recover{
      who = to,
      num = 2,
      recoverBy = from,
      skillName = sjiqkius.name,
    }
    to:drawCards(1,sjiqkius.name)
    -- Fk:currentRoom():getPlayerById(
    -- room:setPlayerMark(to,"@@poavs", from.id)
    room:handleAddLoseSkills(to, "sjiqkius&", nil, false, true)
  end,
})



return sjiqkius
