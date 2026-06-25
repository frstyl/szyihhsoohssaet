local tsoaktthiac = fk.CreateSkill {
  name = "tsoaktthiac",
}

Fk:loadTranslationTable{
  ["tsoaktthiac"] = "作倀",
  [":tsoaktthiac"] = "主旹,選擇1其他角色(須其手牌數或裝僃數爲全場至多)發動,伱与其各抽1,本轉內,伱下次致傷旹傷害值+1",

  ["#tsoaktthiac"] = "作倀 選擇",

  ["@@tsoaktthiac-turn"] = "作倀",
  -- ["$tsoaktthiac1"] = "汝當修整,換其出戰",
  -- ["$tsoaktthiac2"] = "兄長定知此曲何意",
}

tsoaktthiac:addEffect("active", {
  anim_type = "control",
  target_num = 1,
  prompt = "#tsoaktthiac",
  can_use = function(self, player)
    return player:usedSkillTimes(tsoaktthiac.name, Player.HistoryPhase) == 0
  end,
  card_filter = Util.FalseFunc,
  target_filter = function(self, player, to_select, selected, selected_cards)
    local players=Fk:currentRoom().alive_players
      return #selected == 0 and (      
        table.every(players, function (p)
          return p:getHandcardNum() <= to_select:getHandcardNum()
        end)
    or table.every(players, function (p)
          return #p:getCardIds("e") <= #to_select:getCardIds("e")
        end)
    )
  end,
  on_use = function(self, room, effect)
      effect.from:drawCards(1,tsoaktthiac.name)
      effect.tos[1]:drawCards(1,tsoaktthiac.name)
      room:setPlayerMark(effect.from,"@@tsoaktthiac-turn",1)
  end,
})

tsoaktthiac:addEffect(fk.DamageCaused, {
  is_delay_effect = true, --語音
  can_trigger = function(self, event, target, player, data)
    return target==player and player:getMark("@@tsoaktthiac-turn")>0 --選擇旹滿足項數
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:setPlayerMark(player,"@@tsoaktthiac-turn",0)
    data:changeDamage(1)
  end,
})
return tsoaktthiac
