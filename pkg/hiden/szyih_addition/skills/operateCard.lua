local operate_card_skill = fk.CreateSkill{
  name = "operate_card_skill",
}


local S = require "packages/szyihhsoohssaet/szyih_guos"

operate_card_skill:addEffect(fk.BeforeCardsMove, {
  -- global = true,
  can_refresh = function(self, event, target, player, data)
    if player.seat==1 then
      return true

    end
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    local tos={}  --同旹多種多牌?
    for _, move in ipairs(data) do
      if  move.proposer then  --檢索?
        -- table.insert(tos,{move.proposer, move.moveReason})
        tos[move.proposer]=move.moveReason
      end

    end

    for _,p in ipairs(room:getAllPlayers()) do
      if  tos[p] then
        local data={
          who=p,
          type=tos[p],
          move=data,
        }
        room.logic:trigger(S.BeforeOperateCard, p,  data)
      end
    end

    local e= room.logic:getCurrentEvent()
    e:addCleaner(function()
        if not e.killed then
          for _,p in ipairs(room:getAllPlayers()) do  --當旹
            if  tos[p] then
              local data={
                who=p,
                type=tos[p],
                move=e.data,
              }
              room.logic:trigger(S.AfterOperateCard, p,  data)
            end
          end
        end
      end)
  
  end,
})



return operate_card_skill
