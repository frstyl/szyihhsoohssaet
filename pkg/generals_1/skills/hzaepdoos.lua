local hzaepdoos = fk.CreateSkill{
  name = "hzaepdoos",
}

Fk:loadTranslationTable{
  ["hzaepdoos"] = "狹度",
  [":hzaepdoos"] = "伱致傷後,伱可預打出1裝僃牌選擇其它角色距離1以內且非本次受傷者發動,伱与其1傷",

  ["#hzaepdoos-invoke"] = "狹度 弃1裝僃對除%src外距離1角色1傷",
  ["$hzaepdoos1"] = "小可王倫且喜光臨草寨",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

hzaepdoos:addEffect(fk.Damage, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hzaepdoos.name) 
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
        local to, card =  room:askToChooseCardsAndPlayers(player, {
            min_card_num = 1,
            max_card_num = 1,
            min_num = 1,
            max_num = 1,
            targets = table.filter(room.alive_players, function(p)
            return p~=data.to and player:compareDistance(p,1,"<=")  --compareDistance
            end),
            pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("he"),function(cid)
            return Fk:getCardById(cid).type==Card.TypeEquip and not player:prohibitResponse(p)
            end) }) ,
            prompt = "#hzaepdoos-invoke:"..data.to.id,
            skill_name = hzaepdoos.name,
            will_throw = true,
            cancelable = true,
          })
          if #to > 0 and #card>0 then
        event:setCostData(self, {tos = to, cards = card })
        return true
          end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    S.playCard(player,carevent:getCostData(self).cards,hzaepdoos.name)
    room:damage{
      from = player,
      to = event:getCostData(self).tos[1],
      damage = 1,
      damageType = 1,
      skillName = hzaepdoos.name,
    }
  end,
})

return hzaepdoos
