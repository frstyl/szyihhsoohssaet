local hsicqtsoak = fk.CreateSkill {
  name = "hsicqtsoak",
}

Fk:loadTranslationTable{
  ["hsicqtsoak"] = "興作",
  [":hsicqtsoak"] = "主旹.預弃1牌選擇1項發動.若所弃爲裝僃牌,伱抽1,可選額外項.伱所起動下1殺有對應效果併迻除所選項直至本段終.選項➀无視距離➁无視防具➂无視次數➃不可響應.額外選項➄額定目幖+1➅傷害基數+1➆額外結算1次",

  ["#hsicqtsoak"] = "弃1發 選擇效果彊化下1殺",

  ["$hsicqtsoak1"] = "伱要學 我點撥伱耑正",

}

hsicqtsoak:addEffect("active", {
  anim_type = "control",
  card_num = 1,
  target_num = 0,
  prompt = "#hsicqtsoak",
  interaction = function(self, player)
    local choices={"@@hsicqtsoak_ignoreDistances-phase",

    }
    return UI.ComboBox {
      choices = table.filter(choices, function(str)
        return not table.contains(player:getMark("_hsicqtsoak-phase"),str)
      end),
    }
  end,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(hsicqtsoak.name, Player.HistoryPhase) == 0
  -- end,
  card_filter = function(self, player, to_select, selected)
    if #selected ~= 0  or not player:prohibitDiscard(to_select)  then return false end
    local extraChoices={"@@hsicqtsoak_extraTarget-phase",
    "@@hsicqtsoak_additionalDamage-phase",
    "@@hsicqtsoak_additionalEffect-phase",
    }
    if table.contains(player:getMark("_hsicqtsoak-phase"),self.interaction.data) then 
      return Fk:getCardById(to_select).type==Card.TypeEquip
    end

  end,
  on_use = function(self, room, effect)
      room:throwCard(effect.cards, hsicqtsoak.name, effect,from, effect,from)
      room:addTableMark(effect.from,"_hsicqtsoak-phase",self.interaction.data)
      room:setPlayerMark(effect.from,self.interaction.data, 1)
  end,
})

return hsicqtsoak