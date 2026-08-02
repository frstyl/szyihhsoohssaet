Fk:loadTranslationTable{
  ["tshoavqzzyen"] = "操船",
  [":tshoavqzzyen"] = "補段始旹,伱可選擇1其它脚色發動,伱將手牌抽弃至其手牌數",

  ["#tshoavqzzyen-invoke"] = "操船 選擇脚色 伱將手牌抽弃至其手牌數",
  -- ["$tshoavqzzyen1"] = "梦蝶幻月，如沫虚妄。",
  -- ["$tshoavqzzyen2"] = "水映月明，芙蓉照倩影。",
}

local tshoavqzzyen = fk.CreateSkill{
  name = "tshoavqzzyen",
}

tshoavqzzyen:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(tshoavqzzyen.name) and player.phase == Player.Draw
  end,
  on_cost = function(self, event, target, player, data)
        local tos = player.room:askToChoosePlayers(player, {
          targets = player.room:getOtherPlayers(player),
          min_num = 1,
          max_num = 1,
          prompt = "#tshoavqzzyen-invoke",
          skill_name = tshoavqzzyen.name,
          cancelable = true,
        })
        if #tos==1 then
          event:setCostData(self,{tos=tos})
          return true 
        end
  end,
  on_use = function(self, event, target, player, data)
    local n = #event:getCostData(self).tos[1]:getCardIds("h") - #player:getCardIds("h")
    if n>0 then
      player:drawCards(n,tshoavqzzyen.name)
    elseif n<0 then
      player.room:askToDiscard(player, {
        min_num = -n,
        max_num = -n,
        include_equip = false,
        skill_name = tshoavqzzyen.name,
        cancelable = false,
      })
    end
  end,
})


return tshoavqzzyen
