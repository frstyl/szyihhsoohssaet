local hqoavqtszjens = fk.CreateSkill{
  name = "hqoavqtszjens",
}

Fk:loadTranslationTable{
  ["hqoavqtszjens"] = "鏖戰",
  [":hqoavqtszjens"] = "伱體力減少旹,伱可發動,令1脚色抽1｡伱失去牌後x次,伱選1已損脚色發動,其回1",

  ["#hqoavqtszjens"] = "鏖戰：緟鑄殺",
  ["@@hqoavqtszjens-inhand-turn"] = "鏖戰",

  ["$hqoavqtszjens1"] = "還有後招",

}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

hqoavqtszjens:addEffect(fk.HpChanged, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(hqoavqtszjens.name) and data.num<0
  end,
  trigger_times = function(self, event, target, player, data)
    return data.num<0 and -data.num or 0
  end,
  on_cost = function(self, event, target, player, data)
        local to = player.room:askToChoosePlayers(player, {
          targets = player.room.alive_players,
          min_num = 1,
          max_num = 1,
          prompt = "#hqoavqtszjens-draw",
          skill_name = hqoavqtszjens.name,
          cancelable = true,
        })
      if #to>0 then
        event:setCostData(self, {to=to})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    event:getCostData(self).to[1]:drawCards(1,hqoavqtszjens.name)
  end,
})

hqoavqtszjens:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(hqoavqtszjens.name) and event:getCostData(self) and event:getCostData(self).who==player.id 
   and table.find(player.room.alive_players,function(p) return p:isWounded() end )
  end,
  trigger_times = function(self, event, target, player, data)
    if not player:hasSkill(hqoavqtszjens.name) then return 0 end
        local n=event:getCostData(self) and event:getCostData(self).n
    if  n then 
      -- player:drawCards(n,hqoavqtszjens.name)
      return n
    end
         n=0
        for _, move in ipairs(data) do
          if move.from == player then
            for _, info in ipairs(move.moveInfo) do
              if  table.contains({Card.PlayerHand,Card.PlayerEquip}, info.fromArea) then
                n=n+1
              end
            end
          end
        end
    if n>0 then
      -- player:drawCards(5,hqoavqtszjens.name)
      event:setCostData(self, {n=n,who=player.id})
      return n
    else
      return 0
    end
  end,
  on_cost = function(self, event, target, player, data)
        local to = player.room:askToChoosePlayers(player, {
          targets = table.filter(player.room.alive_players, function(p)
          return  p:isWounded()
          end),
          min_num = 1,
          max_num = 1,
          prompt = "#hqoavqtszjens-recover",
          skill_name = hqoavqtszjens.name,
          cancelable = true,
        })
      if #to>0 then
        event:setCostData(self, {to=to})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    player.room:recover{
      who = event:getCostData(self).to[1],
      num = 1,
      recoverBy = player,
      skillName = hqoavqtszjens.name,
    }
  end,
})
return hqoavqtszjens
