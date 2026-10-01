local zzjasdzzjek = fk.CreateSkill{
  name = "zzjasdzzjek",
}

Fk:loadTranslationTable{
["zzjasdzzjek"] = "射石",  --沒鉃
[":zzjasdzzjek"] = "伱預段始旹伱可發動,伱占卜2次,記彔占卜牌花色,轉終淸除記錄｡轉內伱可印牌:將伱1牌花色含于記彔者轉化｣起動｢殺｣;伱所起動殺依記錄所含花色具有對應效果:<font color='red'>♥</font>，无視距離；"..
  "<font color='red'>♦</font>，不可響應；♣，无視甲冑与武將技能；♠，无視次數。若一花色記錄褈復記錄,｢殺｣傷害基數+1 ", --♠♥♣♦

["#zzjasdzzjek-active"] = "射石 將記錄花色轉化爲殺",
["@zzjasdzzjek-turn"] = "射石",

["$zzjasdzzjek1"] = "伱可知我飛石手段",
["$zzjasdzzjek2"] = "飛蝗如雨,看伱等翻成畫餅",
}





zzjasdzzjek:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(zzjasdzzjek.name) and player.phase == Player.Start
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local suits=player:getTableMark("@@ignore_Armor-trun")
    local damage=false
    for i=1,2,1 do
      local judge = {
        who = player,
        reason = zzjasdzzjek.name,
        pattern = ".|.|spade,club,heart,diamond",
      }
      room:judge(judge)
      local suit=judge.card:getSuitString(true)
      if table.contains(player:getTableMark("@zzjasdzzjek-turn"), suit ) then
        damage=true
      end
      table.insert(suits,suit)
    end
      
      if damage then
        room:setPlayerMark(player,"_zzjasdzzjek-damage-turn",1)
      end

      for _, suit in ipairs(suits) do
        if suit=="log_spade" then 
          room:addPlayerMark(player,"ssaet_bypass_times-trun",1) 
        elseif  suit=="log_heart" then 
          room:addPlayerMark(player,"ssaet_bypass_distances-trun",1) 
        elseif   suit=="log_club" then 
          room:addPlayerMark(player,"@@ignore_Armor-trun",1) 
        end
      end
      room:setPlayerMark(player,"@zzjasdzzjek-turn",suit)


    

      player.room:handleAddLoseSkills(player, "zzjasdzzjek_view&",nil,false,true)
        
      player.room.logic:getCurrentEvent():findParent(GameEvent.Turn, true):addCleaner(function()
      player.room:handleAddLoseSkills(player, "-zzjasdzzjek_view&",nil,false,true)
         end
      )
  end,
})

-- zzjasdzzjek:addEffect("targetmod", {
--   bypass_distances = function(self, player, skill, card)
--     return card and  card.trueName =="ssaet" and table.contains(player:getTableMark("@zzjasdzzjek-turn"), "log_heart")
--   end,
--   bypass_times = function(self, player, skill, scope, card)
--     return card and card.trueName =="ssaet" and table.contains(player:getTableMark("@zzjasdzzjek-turn"), "log_spade")
--   end,
-- })



zzjasdzzjek:addEffect(fk.PreCardUse, {
  can_refresh = function (self, event, target, player, data)
    return target == player  and data.card
      and data.card.trueName=="ssaet" 
      --and (table.contains(player:getTableMark("@zzjasdzzjek-turn"), "log_spade") or table.contains(player:getTableMark("@zzjasdzzjek-turn"), "log_diamond"))
  end,
  on_refresh = function (self, event, target, player, data)
    if table.contains(player:getTableMark("@zzjasdzzjek-turn"), "log_spade") then
      data.extraUse = true
    end
    if  table.contains(player:getTableMark("@zzjasdzzjek-turn"), "log_diamond") then
      data.disresponsiveList = table.simpleClone(player.room.players)
    end

    if  table.contains(player:getTableMark("@zzjasdzzjek-turn"), "log_club") then
      data.extra_data=data.extra_data or {}
      data.extra_data.ignore_Armor_to=table.simpleClone(player.room.players)
      data.extra_data.ignore_player_skills_to=table.simpleClone(player.room.players)
    end

    if player:getMark("_zzjasdzzjek-damage-turn")>0 then
      data.additionalDamage= (data.additionalDamage or 0) +1
    end
  end
})

-- zzjasdzzjek:addLoseEffect(function (self, player)
--   player.room:setPlayerMark(player, "@zzjasdzzjek-turn", 0)
-- end)

return zzjasdzzjek
