local khaavhtous_active = fk.CreateSkill {
  name = "khaavhtous_active",
}

Fk:loadTranslationTable{
  ["khaavhtous_active"] = "巧鬥",
  [":khaavhtous_active"] = "主旹,預打出1手牌選擇場上1牢幖記發動,迻動幖記。",

  ["#khaavhtous_active"] = "迻動牢",

  ["$khaavhtous_active1"] = "汝當修整,換其出戰",
  ["$khaavhtous_active2"] = "兄長定知此曲何意",
}

khaavhtous_active:addEffect("active", {
  anim_type = "control",
  card_num = 0,  --
  target_num = 2,
  prompt = "#khaavhtous_active",
  can_use = function(self, player)
    return player:usedSkillTimes(khaavhtous_active.name, Player.HistoryPhase) == 0
  end,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected == 0 and table.contains(player:getCardIds("h"), to_select)
  --   and  not player:prohibitResponse(to_select)
  -- end,
  target_filter = function(self, player, to_select, selected, selected_cards)
      return (#selected == 0 and to_select:getMark("@loav")>0 )
      or #selected ==1
  end,
  on_use = function(self, room, effect)
      -- room:responseCard({
			-- 	card=Fk:getCardById(effect.cards[1]),
			-- 	from=effect.from,
			-- 	attachedSkillAndUser={muteCard=true},
			-- })
      -- room:throwCard(effect.cards, khaavhtous_active.name, effect.from, effect.from)
      room:removePlayerMark(effect.tos[1],"@loav",1)  --已死也執行
      room:addPlayerMark(effect.tos[2],"@loav",1)
  end,
})

return khaavhtous_active
