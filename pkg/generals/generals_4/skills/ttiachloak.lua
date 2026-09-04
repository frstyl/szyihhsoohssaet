local ttiachloak = fk.CreateSkill{
  name = "ttiachloak",
}


Fk:loadTranslationTable{
["ttiachloak"] = "漲落",
[":ttiachloak"] = "輪限1｡游戲始旹/輪終旹/一腳色轉始旹,伱可發動:全體脚色各選擇其x牌迻出,伱獲得技能｢濤洮｣,下1觸發旹機,每腳色獲得其上家｢漲落｣牌,伱失去｢濤洮｣｡x由伱指定,不超過伱體力數｡",

["#ttiachloak-choose"] = "漲落 選擇牌迻出",
["$ttiachloak_ddxev"] = "漲落",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


local spec={
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    if player==Fk:currentRoom().current and player.room:getBanner("ttiachloak-round")==1 then
      local room = player.room
      room:setBanner("ttiachloak-round",0)
      for _, p in ipairs(room.alive_players) do
        local c=S.getNextOne(p,-1):getPile("$ttiachloak_ddxev")
        if  c then
          room:obtainCard(p, c, false, fk.ReasonJustMove, nil, ttiachloak.name)  --
        end
      end
      for _, p in ipairs(room.players) do
        if p:getMark("ttiachloak-noclear")~=0 then
          room:handleAddLoseSkills(player, "-doavqthoav", nil, true, false)
        end
      end
    end

    return player:hasSkill(ttiachloak.name) 
    and   player:usedSkillTimes(ttiachloak.name, Player.HistoryRound)==0
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:setBanner("ttiachloak-round",1)
    local n=room:askToNumber(player, {
      min=1,
      max=player.hp,
      cancelable=false,
    })
    local param={
     players =room.alive_players,
     min_num =n, 
     max_num =n,
     include_equip=true,
     skill_name=ttiachloak.name,
     cancelable=false,
    --  pattern=".",
     prompt="#ttiachloak-choose",
    }
    local req=room:askToJointCards(player,param)
    for _, p in ipairs(room.alive_players) do
      if req[p] and  req[p][1] then
        p:addToPile("$ttiachloak_ddxev", req[p], false, ttiachloak.name)
      end
    end
    room:handleAddLoseSkills(player, "doavqthoav", nil, true, false)
    player.room:setPlayerMark(player,"ttiachloak-noclear", 1)
  end,
}
ttiachloak:addEffect(fk.GameStart, spec)
ttiachloak:addEffect(fk.RoundEnd, spec)
ttiachloak:addEffect(fk.TurnStart, spec)

-- local clear={
--   is_delay_effect=true,
--   anim_type = "drawcard",
--   can_trigger = function(self, event, target, player, data)  --不應該refresh 
--     return player.room:getBanner("ttiachloak-round")==1
--   end,
--   on_trigger = function(self, event, target, player, data)
--     local room = player.room
--     room:setBanner("ttiachloak-round",0)
--     for _, p in ipairs(room.alive_players) do
--       local c=S.getNextOne(p,-1):getPile("$ttiachloak_ddxev")[1]
--       if  c then
--         room:obtainCard(p, c, true, fk.ReasonJustMove, nil, ttiachloak.name)
--       end
--     end
--     for _, p in ipairs(room.players) do
--       if p:getMark("ttiachloak-noclear")~=0 then
--         room:handleAddLoseSkills(player, "-doavqthoav", nil, true, false)
--       end
--     end
--   end,
-- }

return ttiachloak
