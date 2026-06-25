local tsjecqmuoh = fk.CreateSkill {
  name = "tsjecqmuoh",
}

Fk:loadTranslationTable{
  ["tsjecqmuoh"] = "精武",
  [":tsjecqmuoh"] = "主旹任意次.預打出1牌選擇1項發動.若所打出爲裝僃牌,伱抽1,可選額外項.伱所用下1殺有對應效果併迻除所選項直至本段終.選項➀无視距離➁无視次數➂无視防具➃不可抵消.額外選項➄目幖上限+1➅傷害基數+1➆生效次數1次",

  ["#tsjecqmuoh"] = "打出1發 選擇效果彊化下1殺",
  ["@[:]tsjecqmuoh-phase"] = "精武",
  -- ["@[tsjecqmuoh]-phase"] = "精武",


  ["@@tsjecqmuoh_ignoreDistances-phase"]= "无視距離",
  ["@@tsjecqmuoh_ignoreTimes-phase"]= "无視次數",
  ["@@tsjecqmuoh_ignoreArmor-phase"]= "无視防具",
  ["@@tsjecqmuoh_disrespons-phase"]= "不可響應",
  ["@@tsjecqmuoh_extraTarget-phase"]= "目幖上限+1",
  ["@@tsjecqmuoh_additionalDamage-phase"]= "傷害基數+1",
  ["@@tsjecqmuoh_additionalEffect-phase"]= "生效次數+1",

  [":@@tsjecqmuoh_ignoreDistances-phase"]= "",
  [":@@tsjecqmuoh_ignoreTimes-phase"]= "",
  -- [":@@tsjecqmuoh_prohibitResponse-phase"]= "",
  [":@@tsjecqmuoh_disrespons-phase"]= "",
  [":@@tsjecqmuoh_extraTarget-phase"]= "",
  [":@@tsjecqmuoh_additionalDamage-phase"]= "",
  [":@@tsjecqmuoh_additionalEffect-phase"]= "",
   
  ["$tsjecqmuoh1"] = "伱要學 我點撥伱耑正",

}
-- Fk:addQmlMark{
--   name = "tsjecqmuoh",
--   qml_path = "packages/utility/qml/DetailBox",
--   how_to_show = function() return " " end,
-- }

tsjecqmuoh:addEffect("active", {
  anim_type = "control",
  card_num = 1,
  target_num = 0,
  prompt = "#tsjecqmuoh",
  interaction = function(self, player)
    local choices={
      "@@tsjecqmuoh_ignoreDistances-phase",
      "@@tsjecqmuoh_ignoreTimes-phase",
      "@@tsjecqmuoh_ignoreArmor-phase",
      -- "@@tsjecqmuoh_prohibitResponse-phase",
      "@@tsjecqmuoh_disrespons-phase",
      "@@tsjecqmuoh_extraTarget-phase",
      "@@tsjecqmuoh_additionalDamage-phase",
      "@@tsjecqmuoh_additionalEffect-phase",
    }
    return UI.ComboBox {
      choices = table.filter(choices, function(str)
        return not table.contains(player:getTableMark("@[:]tsjecqmuoh-phase"),str)
      end),
    }
  end,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(tsjecqmuoh.name, Player.HistoryPhase) == 0
  -- end,
  card_filter = function(self, player, to_select, selected)
    if self.interaction.data ==nil or #selected ~= 0  or  player:prohibitResponse(to_select)  then return false end
    local extraChoices={"@@tsjecqmuoh_extraTarget-phase",
    "@@tsjecqmuoh_additionalDamage-phase",
    "@@tsjecqmuoh_additionalEffect-phase",
    }
    if table.contains(extraChoices,self.interaction.data) then 
      return Fk:getCardById(to_select).type==Card.TypeEquip and not player:prohibitResponse(to_select)
    end
    return not player:prohibitResponse(to_select)  
  end,
  on_use = function(self, room, effect)
    room:responseCard({
				card=Fk:getCardById(effect.cards[1]),
				from=effect.from,
				attachedSkillAndUser={muteCard=true},
			})
    room:addTableMark(effect.from,"@[:]tsjecqmuoh-phase",self.interaction.data)
    if self.interaction.data== "@@tsjecqmuoh_ignoreArmor-phase" then
      room:addTableMark(effect.from,"ssaetIgnoreArmor-phase",1)
    end
  end,
})

-- tsjecqmuoh:addEffect(fk.CardUseFinished, {
--   is_delay_effect =true,
--   can_refresh= function(self, event, target, player, data)
--     return target == player and player:hasSkill(tsjecqmuoh.name) and data.card.trueName == "ssaet"
--   end,
--   on_refresh= function(self, event, target, player, data)
--     local room = player.room
--     -- local choices=player:getTableMark("@[:]tsjecqmuoh-phase")
--     -- for _, str in ipairs(choices) do
--     --   room:setPlayerMark(player,str,0)
--     -- end
--     room:setPlayerMark(player,"@[:]tsjecqmuoh-phase",0)
--   end,
-- })


tsjecqmuoh:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card)
    return table.contains(player:getTableMark("@[:]tsjecqmuoh-phase"),"@@tsjecqmuoh_ignoreTimes-phase")
  end,
  bypass_distances = function(self, player, skill, card)
    return table.contains(player:getTableMark("@[:]tsjecqmuoh-phase"),"@@tsjecqmuoh_ignoreDistances-phase")
  end,
  extra_target_func = function(self, player, skill, card)
    if table.contains(player:getTableMark("@[:]tsjecqmuoh-phase"),"@@tsjecqmuoh_extraTarget-phase") then
      return 1
    end
  end,
})


tsjecqmuoh:addEffect(fk.PreCardUse, {
  can_refresh = function (self, event, target, player, data)
    return target == player and player:hasSkill(tsjecqmuoh.name) and data.card.trueName == "ssaet"
    and #player:getTableMark("@[:]tsjecqmuoh-phase")>0
  end,
  on_refresh = function (self, event, target, player, data)
    local t=player:getTableMark("@[:]tsjecqmuoh-phase")
    if table.contains(t,"@@tsjecqmuoh_ignoreTimes-phase")  then
      data.extraUse = true
      -- table.removeOne(t,"@@tsjecqmuoh_ignoreTimes-phase")
    end
    if table.contains(t,"@@tsjecqmuoh_disrespons-phase") then
      data.unoffsetableList = table.simpleClone(player.room.players)  --不可抵消 能水攻
      -- table.removeOne(t,"@@tsjecqmuoh_disrespons-phase")
    end
    if table.contains(t,"@@tsjecqmuoh_additionalDamage-phase") then
        data.additionalDamage = (data.additionalDamage or 0) + 1
      -- table.removeOne(t,"@@tsjecqmuoh_additionalDamage-phase")
    end
    if table.contains(t,"@@tsjecqmuoh_additionalEffect-phase") then
      data.additionalEffect = (data.additionalEffect or 0) + 1
      -- table.removeOne(t,"@@tsjecqmuoh_additionalEffect-phase")
    end

    if table.contains(t,"@@tsjecqmuoh_ignoreArmor-phase") then
      data.extra_data=data.extra_data or {}
      data.extra_data.ignoreArmorTo=table.simpleClone(player.room.players)
      -- table.removeOne(t,"@@tsjecqmuoh_ignoreArmor-phase")
      player.room:removeTableMark(player,"ssaetIgnoreArmor-phase",1)
    end

    player.room:setPlayerMark(player,"@[:]tsjecqmuoh-phase",0)

  end,
})


return tsjecqmuoh
