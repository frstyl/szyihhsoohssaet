local touh_ttwenh_seec_jje = fk.CreateSkill {
  name = "touh_ttwenh_seec_jje",
}
Fk:loadTranslationTable{
  ["#touh_ttwenh_seec_jje"] = "斗轉星迻 以鬥法破高廉 交換判定牌",
}

touh_ttwenh_seec_jje:addEffect("cardskill", {
  prompt = "#touh_ttwenh_seec_jje",
  target_num = 1,
  can_use = Util.FalseFunc,  --不能主段用
  on_effect = function(self, room, effect)
    effect.from:drawCards(1,touh_ttwenh_seec_jje.name)
  end,
})

touh_ttwenh_seec_jje:addEffect(fk.AskForRetrial, {  --与技能同旹 算使用?
  -- global = true,
  can_trigger = function(self, event, target, player, data)
    return #table.filter(player:getCardIds("h"), 
      function(id)
        return Fk:getCardById(id).name == "tous_puap_phoas_koav_ljem"
      end)>0
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room

    local use = room:askToUseCard(player, {  --使用
      skill_name = touh_ttwenh_seec_jje.name,
      pattern = "tous_puap_phoas_koav_ljem",
      prompt = "#touh_ttwenh_seec_jje-ask::"..target.id,
      cancelable = true,
    })
    if use then
      room:useCard(use)
    end
    -- local cards = room:askToCards(player, {
    --   min_num = 1,
    --   max_num = 1,
    --   skill_name = touh_ttwenh_seec_jje.name,
    --   pattern = "tous_puap_phoas_koav_ljem",
    --   prompt = "#touh_ttwenh_seec_jje",
    --   cancelable = true,
    -- })
    -- if cards then
    -- player.room:changeJudge{
    --   card = Fk:getCardById(cards[1]),
    --   player = player,
    --   data = data,
    --   skillName = touh_ttwenh_seec_jje.name,
    --   response = false,
    --   exchange=true,
    -- }
    -- end

  end,
})

return touh_ttwenh_seec_jje

