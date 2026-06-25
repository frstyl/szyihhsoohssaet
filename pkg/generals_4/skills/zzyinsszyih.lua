local zzyinsszyih = fk.CreateSkill {
  name = "zzyinsszyih",
}

Fk:loadTranslationTable{
  ["zzyinsszyih"] = "順水",
  [":zzyinsszyih"] = "每1牌離開其它角色A伏區後,伱可預打出1同色牌發動,伱予A 1傷",

  ["#zzyinsszyih-choose"] = "順水 選擇發動目幖牌与所弃牌",

  ["@zzyinsszyih"] = "",

  ["$zzyinsszyih1"] = "也就作个順水推船",
  ["$zzyinsszyih2"] = "兄使版刀我作魚",
}

-- local U = require "packages/utility/utility"
local S = require "packages/szyihhsoohssaet/szyih_guos"

zzyinsszyih:addEffect(fk.AfterCardsMove, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if  event:getCostData(self)==nil then --1号
    

      local ids = {}
      local froms = {}
      for _, move in ipairs(data) do  --data move info
        if   move.from 
        then  
          for _, info in ipairs(move.moveInfo) do
            if  info.fromArea==Card.PlayerJudge then
              table.insertIfNeed(ids, info.cardId)  --記錄牌來源
              froms[info.cardId]=move.from.id  --string?
            end
          end
        end
      end

      if #ids>0 then
        event:setCostData(self, {ids = ids,froms=froms})
      else
        event:setCostData(self, {ids = nil})
      end
    end

    if  not (event:getCostData(self) and event:getCostData(self).ids) then return end
    local dat= event:getCostData(self)
    if dat.choosed and #dat.choosed==#dat.ids then
      event:setCostData(self, {ids=dat.ids, froms=dat.froms})
      return 
    end

    return player:hasSkill(zzyinsszyih.name) 
    and not player:isKongcheng()

  end,
  trigger_times = function(self, event, target, player, data)
    return 999
  end,
  on_cost = function(self, event, target, player, data)

    local room = player.room
    local ids=event:getCostData(self).ids
    local choosed=event:getCostData(self).choosed or {}
    local froms=event:getCostData(self).froms
    local tobe = {} 
    for _, id in ipairs(ids) do
      if not table.contains(choosed,id) then
        table.insert(tobe,id)
      end
    end
    if #tobe==0 then
      event:setCostData(self, {ids=ids, froms=froms})
      return
    end

    for _, id in ipairs(tobe) do
      room:setCardMark(Fk:getCardById(id), "@zzyinsszyih", "seat#"..tostring(room:getPlayerById(froms[id]).seat))
    end
    local yes, dat = room:askToUseActiveSkill(player, {  --askToChooseCardsAndPlayers 等實調用此 askToUseActiveSkill
      skill_name = "zzyinsszyih_active",
      prompt = "#zzyinsszyih-choose",
      cancelable = true,
      skip = true,  --不執行
      extra_data = {
        expand_pile = tobe
      },
      --  = {ids=ids},
    })
    for _, id in ipairs(tobe) do
      room:setCardMark(Fk:getCardById(id), "@zzyinsszyih",nil)
    end
    if yes and dat then
      table.insert(choosed, dat.cards[1])
      local to = room:getPlayerById(froms[dat.cards[1]])
      event:setCostData(self, {ids=ids,  froms=froms, choosed=choosed, cards = {dat.cards[2] or dat.cards[1]} , tos ={to}})  --koans
      return true
    else
      event:setCostData(self, {ids=ids, froms=froms})
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    S.playCard(player,event:getCostData(self).cards,zzyinsszyih.name)
    room:damage{
      from = player,
      to = event:getCostData(self).tos[1],
      damage = 1,
      damageType = 1,
      skillName = zzyinsszyih.name,
    }
end,
})

return zzyinsszyih
