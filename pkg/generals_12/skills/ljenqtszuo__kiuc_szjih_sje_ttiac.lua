local skill = fk.CreateSkill {
  name = "ljenqtszuo__kiuc_szjih_sje_ttiac_skill",
}
Fk:loadTranslationTable{
  ["ljenqtszuo__kiuc_szjih_sje_ttiac_skill"] = "連珠__弓矢斯張",
  -- [":tsiocsmoa"] = "應動｡伱使用｢殺｣指定目幖旹,伱可發動｡伱抽2,迻除此目幖,虛擬使用｢猛虎下山｣,此牌效果:目幖可打出屬性｢殺｣若打出伱抽1,否則伱予目幖1傷,目幖隨機自弃1牌",
}
skill:addEffect("cardskill", {
  prompt = "#ljenqtszuo__kiuc_szjih_sje_ttiac_skill",
  can_use = Util.AoeCanUse,
  on_use = function (self, room, cardUseEvent)
    for _,p in ipairs(room.players) do
      room:addPlayerMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase",1)
    end

    room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true):addCleaner(function()
      for _, p in ipairs(room.players) do  --
        room:removePlayerMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase", 1)
      end
    end)
    
    return Util.AoeCardOnUse(self, cardUseEvent.from, cardUseEvent, false)
  end,
  mod_target_filter = function(self, player, to_select, selected, card, distance_limited)
    return to_select ~= player
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if effect.to.dead then return end
    local loopTimes = 1 + effect:getResponseTimes()
    local respond
    for i = 1, loopTimes do
      local params = { ---@type AskToUseCardParams
        skill_name = 'szjemh',
        pattern = 'szjemh',
        cancelable = true,
        event_data = effect
      }
      respond = room:askToResponse(effect.to, params)
      if respond then
        room:responseCard(respond)
        if effect.to.dead then return end
      else
        room:damage({
          from = effect.from,
          to = effect.to,
          card = effect.card,
          damage = 1,
          damageType = fk.FireDamage,
          skillName = skill.name,
          event_data= effect,
        })
        return
      end

    end
  end,
})



return skill
