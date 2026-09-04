local tsjecqmuoh = fk.CreateSkill {
  name = "tsjecqmuoh",
}

Fk:loadTranslationTable{
  ["tsjecqmuoh"] = "精武",
  [":tsjecqmuoh"] = "主旹无限次.預打出1牌選擇1項發動.伱所起動下1｢殺｣有對應效果.選項➀无視距離限制➁无視次數限制➂无視防具➃不可抵消(下列須打出裝僃牌可選)➄目幖上限+1➅傷害基數+1➆生效次數1次",
--反失效? 封技能
  ["#tsjecqmuoh"] = "打出1發 選擇效果彊化下1殺",
  ["@[:]tsjecqmuoh"] = "精武",
  -- ["@[tsjecqmuoh]"] = "精武",


  ["@@tsjecqmuoh_ignoreDistances"]= "无視距離",
  ["@@tsjecqmuoh_ignoreTimes"]= "无視次數",
  ["@@tsjecqmuoh_ignoreArmor"]= "无視防具",
  ["@@tsjecqmuoh_disrespons"]= "不可響應",
  ["@@tsjecqmuoh_extraTarget"]= "目幖上限+1",
  ["@@tsjecqmuoh_additionalDamage"]= "傷害基數+1",
  ["@@tsjecqmuoh_additionalEffect"]= "生效次數+1",

  [":@@tsjecqmuoh_ignoreDistances"]= "",
  [":@@tsjecqmuoh_ignoreTimes"]= "",
  -- [":@@tsjecqmuoh_prohibitResponse"]= "",
  [":@@tsjecqmuoh_disrespons"]= "",
  [":@@tsjecqmuoh_extraTarget"]= "",
  [":@@tsjecqmuoh_additionalDamage"]= "",
  [":@@tsjecqmuoh_additionalEffect"]= "",
   
  ["$tsjecqmuoh1"] = "伱要學 我點撥伱耑正",  --每效果至少1句

}
-- Fk:addQmlMark{
--   name = "tsjecqmuoh",
--   qml_path = "packages/utility/qml/DetailBox",
--   how_to_show = function() return " " end,
-- }

local S = require "packages/szyihhsoohssaet/szyih_guos"


tsjecqmuoh:addEffect("active", {
  anim_type = "control",
  card_num = 1,
  target_num = 0,
  prompt = "#tsjecqmuoh",
  interaction = function(self, player)
    local choices={
      "@@tsjecqmuoh_ignoreDistances",
      "@@tsjecqmuoh_ignoreTimes",
      "@@tsjecqmuoh_ignoreArmor",
      -- "@@tsjecqmuoh_prohibitResponse",
      "@@tsjecqmuoh_disrespons",
      "@@tsjecqmuoh_extraTarget",
      "@@tsjecqmuoh_additionalDamage",
      "@@tsjecqmuoh_additionalEffect",
    }
    return UI.ComboBox {
      choices = table.filter(choices, function(str)
        return not table.contains(player:getTableMark("@[:]tsjecqmuoh"),str)
      end),
    }
  end,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(tsjecqmuoh.name, Player.HistoryPhase) == 0
  -- end,
  card_filter = function(self, player, to_select, selected)
    if self.interaction.data ==nil or #selected ~= 0  or  player:prohibitResponse(Fk:getCardById(to_select)) then return false end
    local extraChoices={"@@tsjecqmuoh_extraTarget",
    "@@tsjecqmuoh_additionalDamage",
    "@@tsjecqmuoh_additionalEffect",
    }
    if table.contains(extraChoices,self.interaction.data) then 
      return Fk:getCardById(to_select).type==Card.TypeEquip and not player:prohibitResponse(to_select)
    end
    return not player:prohibitResponse(Fk:getCardById(to_select)) 
  end,
  on_use = function(self, room, effect)

    S.playCard(effect.cards,tsjecqmuoh.name,effect.from)
    room:addTableMark(effect.from,"@[:]tsjecqmuoh",self.interaction.data)

    if self.interaction.data== "@@tsjecqmuoh_ignoreArmor" then
      room:addTableMark(effect.from,"ssaet_ignore_Armor",1)
    end
    if self.interaction.data== "@@tsjecqmuoh_ignoreDistances" then
      room:addTableMark(effect.from,"ssaet_bypass_distances",1)
    end
    if self.interaction.data== "@@tsjecqmuoh_ignoreTimes" then
      room:addTableMark(effect.from,"ssaet_bypass_times",1)
    end
    if self.interaction.data== "@@tsjecqmuoh_extraTarget" then
      room:addTableMark(effect.from,"ssaet_target_number",1)
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
--     -- local choices=player:getTableMark("@[:]tsjecqmuoh")
--     -- for _, str in ipairs(choices) do
--     --   room:setPlayerMark(player,str,0)
--     -- end
--     room:setPlayerMark(player,"@[:]tsjecqmuoh",0)
--   end,
-- })


-- tsjecqmuoh:addEffect("targetmod", {
--   bypass_times = function(self, player, skill, scope, card)
--     return table.contains(player:getTableMark("@[:]tsjecqmuoh"),"@@tsjecqmuoh_ignoreTimes")
--   end,
--   bypass_distances = function(self, player, skill, card)
--     return table.contains(player:getTableMark("@[:]tsjecqmuoh"),"@@tsjecqmuoh_ignoreDistances")
--   end,
--   extra_target_func = function(self, player, skill, card)
--     if table.contains(player:getTableMark("@[:]tsjecqmuoh"),"@@tsjecqmuoh_extraTarget") then
--       return 1
--     end
--   end,
-- })


tsjecqmuoh:addEffect(fk.PreCardUse, {
  can_refresh = function (self, event, target, player, data)
    return data.from == player and data.card.trueName == "ssaet"  --data.from:getMark
    and #player:getTableMark("@[:]tsjecqmuoh")>0
  end,
  on_refresh = function (self, event, target, player, data)
    local t=player:getTableMark("@[:]tsjecqmuoh")

    if table.contains(t,"@@tsjecqmuoh_disrespons") then
      data.unoffsetableList = table.simpleClone(player.room.players)  --不可抵消 能水攻
      -- table.removeOne(t,"@@tsjecqmuoh_disrespons")
    end
    if table.contains(t,"@@tsjecqmuoh_additionalDamage") then
        data.additionalDamage = (data.additionalDamage or 0) + 1
      -- table.removeOne(t,"@@tsjecqmuoh_additionalDamage")
    end
    if table.contains(t,"@@tsjecqmuoh_additionalEffect") then
      data.additionalEffect = (data.additionalEffect or 0) + 1
      -- table.removeOne(t,"@@tsjecqmuoh_additionalEffect")
    end


    if table.contains(t,"@@tsjecqmuoh_ignoreArmor") then
      data.extra_data=data.extra_data or {}
      data.extra_data.ignore_Armor_to=table.simpleClone(player.room.players)
      room:removeTableMark(player,"ssaet_ignore_Armor",1)
    end
    if table.contains(t,"@@tsjecqmuoh_ignoreDistances") then
      room:removeTableMark(player,"ssaet_bypass_distances",1)
    end
    if table.contains(t,"@@tsjecqmuoh_ignoreTimes") then
      data.extraUse = true
      room:removeTableMark(player,"ssaet_bypass_times",1)
    end
    if table.contains(t,"@@tsjecqmuoh_extraTarget") then
      room:removeTableMark(player,"ssaet_target_number",1)
    end

    player.room:setPlayerMark(player,"@[:]tsjecqmuoh",0)

  end,
})


return tsjecqmuoh
