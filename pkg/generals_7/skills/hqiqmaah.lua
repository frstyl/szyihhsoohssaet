local hqiqmaah = fk.CreateSkill {
  name = "hqiqmaah",
}

Fk:loadTranslationTable{
  ["hqiqmaah"] = "醫馬",
  [":hqiqmaah"] = "當其他角色A區域坐騎牌進入弃牌堆後，若其未迻動,你可發動,伱獲得此牌,肰後伱可令A回1",

  ["#hqiqmaah-choose"] = "醫馬 選擇1坐騎牌獲得",
  ["#hqiqmaah-recover"] = "醫馬 是否令%src回1",
  ["@BelongTo"] = "",

  ["$hqiqmaah1"] = "醫得一馬救得一人",
  -- ["$hqiqmaah2"] = "著我玄天混元飛劍",
}

-- local U = require "packages/utility/utility"

hqiqmaah:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
      local ids = {}
      local froms = {}
      -- local pids = {}

      if event:getCostData(self) ==nil then   --trigger_times 于每次技能結算後緟算 --應該止1次 元旹機生成旹計算

        for _, move in ipairs(data) do  --data move info
          if move.from and move.from ~= player 
            and  move.toArea == Card.DiscardPile  --元 Area不爲 DiscardPile
          then  
            for _, info in ipairs(move.moveInfo) do
              if  Fk:getCardById(info.cardId).sub_type == Card.SubtypeDefensiveRide or  --getSubtypeString
              Fk:getCardById(info.cardId).sub_type == Card.SubtypeOffensiveRide then
              -- and  (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip) 
                table.insertIfNeed(ids, info.cardId)
                -- table.insertIfNeed(allids, info.cardId)
                froms[info.cardId]=move.from.id
                -- player.room:setCardMark(Fk:getCardById(info.cardId), "@BelongTo",tostring(move.from.seat) )
              end
            end
          end
        end
      -- else
      --   ids=event:getCostData(self).ids
      end


    if #ids ==0  then 
      event:setCostData(self, {ids = nil})
    else
      event:setCostData(self, {ids = ids,froms=froms})
    end

    return   player:hasSkill(hqiqmaah.name)  and  event:getCostData(self).ids
  end,
  trigger_times = function(self, event, target, player, data)
    return 999
  end,

  on_cost = function(self, event, target, player, data)
    local room = player.room
    local ids= event:getCostData(self).ids
    ids = table.filter(ids, function (id)
      return table.contains(player.room.discard_pile, id)
    end)
    ids = player.room.logic:moveCardsHoldingAreaCheck(ids)

    if #ids==0 then return end
    
    local froms=event:getCostData(self).froms
    for _, id in ipairs(ids) do
      room:setCardMark(Fk:getCardById(id), "@zzyinsszyih", "seat#"..tostring(room:getPlayerById(froms[id]).seat))
    end
    
    local cards, choice = player.room:askToChooseCardsAndChoice(player, {
      cards = event:getCostData(self).ids,
      min_num = 1,
      max_num = 1,
      skill_name = hqiqmaah.name,
      prompt = "#hqiqmaah-choose",
      cancel_choices = {"Cancel"}
    })
    
    for _, id in ipairs(ids) do
      room:setCardMark(Fk:getCardById(id), "@zzyinsszyih", nil)
    end
    if #cards>0 then
        event:setCostData(self, {ids=ids,cards=cards,tos={room:getPlayerById(froms[cards[1]])}})
        return true
    -- else
    --   for _, id in ipairs(event:getCostData(self).allids) do 
    --      player.room:setCardMark(Fk:getCardById(id), "@BelongTo",nil)
    --   end
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local cards=event:getCostData(self).cards
    room:moveCards({
      ids = cards,
      to = player,
      toArea = Card.PlayerHand,
      moveReason = fk.ReasonJustMove,
      proposer = player,
      skillName = hqiqmaah.name,
    })
    if player.dead then return end
    local p=event:getCostData(self).tos[1]
    if not p.dead and room:askToSkillInvoke(player,{
      skill_name=hqiqmaah.name,
      prompt ="#hqiqmaah-recover:"..p.id
    })   then
      room:recover({
        who = p,
        num = 1,
        recoverBy = player,
        skillName = hqiqmaah.name,
      })
    end

end,
})

return hqiqmaah
