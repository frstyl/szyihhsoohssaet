local skill = fk.CreateSkill {
  name = "pik_dzziach_liac_ssaen_skill",
}


Fk:loadTranslationTable{
  ["#pik_dzziach_liac_ssaen_ask"] = "逼上梁山 弃2",
}

skill:addEffect("cardskill", {
  prompt = "#pik_dzziach_liac_ssaen_skill",
  can_use = Util.CanUse,
  target_num = 1,
  mod_target_filter = function(self, player, to_select, selected, card)
    if to_select ~= player then  --and  to_select:getHandcardNum()>to_select.hp --to_select.Hp~=player.Hp
      local n = to_select:getHandcardNum() - to_select.hp
      local m = player:getHandcardNum() - player.hp
      if n * m <= 0 and n~=m then return true end
    end
  end,
  target_filter = Util.CardTargetFilter,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    to = effect.to
    if effect.to.dead then return end
    room:loseHp(effect.to, 1, skill.name)
    if effect.to.dead then return end
    room:askToDiscard(to,{  --不必判斷手牌數
		  min_num = 2,
		  max_num = 2,
		  include_equip = true,
		  skill_name = skill.name,
		  cancelable = false,
		  pattern = pattern,  --色
		  prompt = "#pik_dzziach_liac_ssaen_ask",
		  skip = false,
		})
    if to.dead then return end
    to:drawCards(2, skill.name)
  end,
})

return skill

