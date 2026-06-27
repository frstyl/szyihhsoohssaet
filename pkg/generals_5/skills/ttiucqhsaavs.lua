local ttiucqhsaavs = fk.CreateSkill{
  name = "ttiucqhsaavs",
  -- tags={Skill.Limited},
}

Fk:loadTranslationTable{
  ["ttiucqhsaavs"] = "忠孝",
  [":ttiucqhsaavs"] = "伱回復體力後,伱可選1其它角色發動.其回1.伱不因此技能獲得牌後,伱可選x手牌与1其它角色發動.將牌交予其,伱抽x.(x至多爲伱所得牌數,至少爲1)",  --

  ["#ttiucqhsaavs-recover"] = "忠孝：選擇目幖,令其回1",
  ["#ttiucqhsaavs-card"] = "忠孝：選擇至多 %arg 牌交予其它角色",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 

ttiucqhsaavs:addEffect(fk.HpRecover, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(ttiucqhsaavs.name) 
  end,
  trigger_times = function(self, event, target, player, data)
    return data.num
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local tos = room:askToChoosePlayers(player, {
      targets = player.room.alive_players,
      min_num = 1,
      max_num = 1,
      prompt = "#ttiucqhsaavs-recover",
      skill_name = ttiucqhsaavs.name,
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:recover{
      who = event:getCostData(self).tos[1],
      num = 1,
      recoverBy = player,
      skillName = ttiucqhsaavs.name,
    }
  end,
})

ttiucqhsaavs:addEffect(fk.AfterCardsMove, {
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(ttiucqhsaavs.name) then return end

      local n = 0
      for _, move in ipairs(data) do
        if move.to == player and table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea) and move.skillName ~= ttiucqhsaavs.name  then

          for _, info in ipairs(move.moveInfo) do
            if not (move.from==player and table.contains({Card.PlayerEquip,Card.PlayerHand }, info.fromArea) ) then
              n=n+1
            end
          end
        end
      end
        
      if n>0 then
        event:setCostData(self,{n=n})
        return true 
      end
  end,
  on_cost = function(self, event, target, player, data)
    local n =event:getCostData(self).n
    local tos, cards = player.room:askToChooseCardsAndPlayers(player, {
      min_card_num = 1,
      max_card_num = event:getCostData(self).n,
      min_num = 1,
      max_num = 1,
      targets = player.room:getOtherPlayers(player),
      -- pattern = ".|.|.|hand",
      include_equip=false,
      skill_name = ttiucqhsaavs.name,
      prompt = "#ttiucqhsaavs-card:::"..n,
      cancelable = true,
      will_throw = false,
    })
    if #tos > 0 and #cards >0 then
      event:setCostData(self, {tos = tos, cards = cards,n = n})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:moveCardTo(event:getCostData(self).cards, Player.Hand, event:getCostData(self).tos[1], fk.ReasonGive, ttiucqhsaavs.name, nil, false, player)
    if player.dead then return end
    player:drawCards(event:getCostData(self).n, ttiucqhsaavs.name)
  end,
})
return ttiucqhsaavs
