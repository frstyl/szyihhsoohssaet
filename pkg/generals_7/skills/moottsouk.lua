local moottsouk = fk.CreateSkill{
  name = "moottsouk",
}

Fk:loadTranslationTable{
["moottsouk"] = "沒鉃",
[":moottsouk"] = "➀預段發動,伱判定2次,記彔判定牌花色.➁轉終,清除記錄➂伱可將伱1牌花色含于記彔者轉化爲殺使用➃伱所使用殺依記錄所含花色具有對應效果:<font color='red'>♥</font>，无視距離；"..
  "<font color='red'>♦</font>，不可響應；♣，无視防具；♠，无視次數。若一花色記錄次數大于1,伱使用殺旹其傷害基數+1 ", --♠♥♣♦

["#moottsouk-active"] = "沒鉃 將記錄花色轉化爲殺",
["@moottsouk-turn"] = "沒鉃",

["$moottsouk1"] = "伱可知我飛石手段",
["$moottsouk2"] = "飛蝗如雨,看伱等翻成畫餅",
}


moottsouk:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(moottsouk.name) and player.phase == Player.Start
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    for i=1,2,1 do
      local judge = {
        who = player,
        reason = moottsouk.name,
        pattern = ".|.|spade,club,heart,diamond",
      }
      room:judge(judge)
      local suit = judge.card:getSuitString(true)
      if table.contains(player:getTableMark("@moottsouk-turn"), suit ) then
        room:setPlayerMark(player,"_moottsouk-damage-turn",1)
      end
      room:addTableMark(player,"@moottsouk-turn",suit)


    end
  end,
})

moottsouk:addEffect("viewas", {
  anim_type = "offensive",
  -- pattern = "ssaet",
  prompt = "#moottsouk-active",
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getTableMark("@moottsouk-turn"), Fk:getCardById(to_select):getSuitString(true) )
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("ssaet")
    c.skillName = moottsouk.name
    c:addSubcard(cards[1])
    return c
  end,
  enabled_at_response = function(self, player, response) --響應
    return  not response  --此response为打出 不能用于打出 
  end,
})

moottsouk:addEffect("targetmod", {
  bypass_distances = function(self, player, skill, card)
    return card and  card.trueName =="ssaet" and table.contains(player:getTableMark("@moottsouk-turn"), "log_heart")
  end,
  bypass_times = function(self, player, skill, scope, card)
    return card and card.trueName =="ssaet" and table.contains(player:getTableMark("@moottsouk-turn"), "log_spade")
  end,
})


-- moottsouk:addEffect(fk.TargetSpecified, {  --无視防具 不可響應
--   can_refresh = function(self, event, target, player, data)
--     return target == player  and data.card
--       and data.card.trueName=="ssaet" 
--       and (table.contains(player:getTableMark("@moottsouk-turn"), "log_club") --or  table.contains(player:getTableMark("@moottsouk-turn"), "log_diamond")
--       )
--       and not data.to.dead 
--   end,
--   on_refresh = function(self, event, target, player, data) --音效
--     -- if table.contains(player:getTableMark("@moottsouk-turn"), "log_club") then
--       data.to:addQinggangTag(data)
--     -- end
--     -- if  table.contains(player:getTableMark("@moottsouk-turn"), "log_diamond")  then
--     --   data.disresponsive = true
--     -- end
--   end,
-- })

moottsouk:addEffect(fk.PreCardUse, {
  can_refresh = function (self, event, target, player, data)
    return target == player  and data.card
      and data.card.trueName=="ssaet" 
      --and (table.contains(player:getTableMark("@moottsouk-turn"), "log_spade") or table.contains(player:getTableMark("@moottsouk-turn"), "log_diamond"))
  end,
  on_refresh = function (self, event, target, player, data)
    if table.contains(player:getTableMark("@moottsouk-turn"), "log_spade") then
      data.extraUse = true
    end
    if  table.contains(player:getTableMark("@moottsouk-turn"), "log_diamond") then
      data.disresponsiveList = table.simpleClone(player.room.players)
    end

    if  table.contains(player:getTableMark("@moottsouk-turn"), "log_club") then
      data.extra_data=data.extra_data or {}
      data.extra_data.ignoreArmorTo=table.simpleClone(player.room.players)
    end

    if player:getMark("_moottsouk-damage-turn")>0 then
      data.additionalDamage= (data.additionalDamage or 0) +1
    end
  end
})

moottsouk:addLoseEffect(function (self, player)
  player.room:setPlayerMark(player, "@moottsouk-turn", 0)
end)

return moottsouk
