local ttiucqliu = fk.CreateSkill{
  name = "ttiucqliu",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["ttiucqliu"] = "中流",
  [":ttiucqliu"] = "牌進入一腳色手牌區後,若伱(詢問此技能旹)手牌數小于存活腳色手牌數均值,伱可發動,伱抽1｡",
}


ttiucqliu:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(ttiucqliu.name)  then return false end

    for _, move in ipairs(data) do
      if   move.toArea==Card.PlayerHand then -- move.to ~=player
          for _, info in ipairs(move.moveInfo) do
            if not (move.from==move.to and  move.toArea==Card.PlayerHand  ) then
                        -- goto caculate
                  local n = 0
                  local room=player.room
                  for _, p in ipairs(room.alive_players) do
                    n=n+p:getHandcardNum()
                  end
                  return player:getHandcardNum()< n /(#room.alive_players) 
            end
          end

      end
    end
    
    -- ::caculate::
    -- local n = 0
    -- local room=player.room
    -- for _, p in ipairs(room.alive_players) do
    --   n=n+p:getHandcardNum()
    -- end
    -- return player:getHandcardNum()< n /(#room.alive_players) 
  end,
  on_use = function(self, event, target, player, data)
      player:drawCards(1,ttiucqliu.name)
  end,
})

return ttiucqliu
