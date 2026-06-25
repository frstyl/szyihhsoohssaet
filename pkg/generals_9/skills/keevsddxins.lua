local keevsddxins = fk.CreateSkill {
  name = "keevsddxins",
}

Fk:loadTranslationTable{
  ["keevsddxins"] = "叫陣",
  [":keevsddxins"] = "始段,伱可發動.伱判定,若爲紅桃,伱抽2,否則伱本轉擁有效果➀額定抽牌數-1➁所致傷視爲雷傷➂可將黑色牌轉化爲鬥將使用➃使用鬥將无視距離➄轉終,抽x(x爲伱本轉致傷次數)",

  ["@@keevsddxins-turn"] = "叫陣",

  ["$keevsddxins1"] = "吾乃兀顏統軍帳下先鋒",
  ["$keevsddxins2"] = "戰書已下開戰",

}

keevsddxins:addEffect(fk.EventPhaseStart, {
  can_trigger = function(self, event, target, player, data)
    return target==player and  player:hasSkill(keevsddxins.name) and player.phase==Player.Start
    end,
  on_use = function(self, event, target, player, data)  --鎖
  local room=player.room
  local judge = {
    who = player,
    reason = keevsddxins.name,
    pattern = ".|.|^heart",
    }
      room:judge(judge)
      if  judge:matchPattern()  then
        room:setPlayerMark(player,"@@keevsddxins-turn",1)
        player.room:handleAddLoseSkills(player, "keevsddxins_active&",nil,false,true)
        
      player.room.logic:getCurrentEvent():findParent(GameEvent.Turn, true):addCleaner(function()
      player.room:handleAddLoseSkills(player, "-keevsddxins_active&",nil,false,true)
         end
      )
      else
        player:drawCards(2,keevsddxins.name)
      end
  end,
})

-- keevsddxins:addEffect(fk.TurnEnd, {
--   is_delay_effect=ture,
--   priority=0,
--   -- can_trigger= function(self, event, target, player, data)
--   --   return target==player and player:hasSkill("keevsddxins_active&")
--   -- end,
--   can_refresh = function(self, event, target, player, data)
--     return target==player and player:hasSkill("keevsddxins_active&")
--   end,
--   on_refresh = function(self, event, target, player, data)
--     player.room:handleAddLoseSkills(player, "-keevsddxins_active&",nil,false,true)
--   end,
-- })

return keevsddxins
