local khaenqljins = fk.CreateSkill {
  name = "khaenqljins",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
["khaenqljins"] = "慳悋",
-- [":khaenqljins"] = "鎖定技｡➀狀態.伱的基礎額定手牌數等于體力上限｡➁當其它角色棄置獲取伱的牌歬旹必發,伱令此迻動牌數-1",
-- [":khaenqljins"] = "鎖定技｡➀狀態.伱的基礎額定手牌數等于體力上限｡➁當其它角色棄置獲取伱的牌歬旹,必發,防止之",
[":khaenqljins"] = "鎖定.屬于伱之牌被任意弃置或獲取前,必發.防止之.伱越過段或轉歬,必發.防止之.",
}
-- CardUseFinished
khaenqljins:addEffect(fk.BeforeCardsMove, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    if  not player:hasSkill(khaenqljins.name) then return false end
      local cards={}
      for _, move in ipairs(data) do
        if  move.from==player
          -- and  table.contains(player.room:getOtherPlayers(player,true,true), move.proposer)  --其他角色
          
          and (
            move.moveReason==fk.ReasonDiscard 
          or (move.moveReason==fk.ReasonPrey and move.to~=player)
          )  --弃 得
          and move.proposer~=nil
          --and move.proposer~=player
          
        then 
          for _, c in ipairs(move.moveInfo) do --同旹迻動多脾需檢查來源
            if  (c.fromArea == Card.PlayerHand or c.fromArea == Card.PlayerEquip) then
            table.insert(cards, c.cardId)
            end
          end
        end
      end

    if #cards~=0 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:cancelMove(data,event:getCostData(self).cards)
  end,
})

khaenqljins:addEffect(fk.BeforeTurnOver, {--不能跳過?
  anim_type = "defensive",
  can_trigger = function (self, event, target, player, data)
    return target == player and player:hasSkill(khaenqljins.name) and player.faceup
  end,
  on_use = function (self, event, target, player, data)
    data.prevented = true
  end,
})
khaenqljins:addEffect(fk.EventPhaseSkipping, {
  anim_type = "defensive",
  can_trigger = function (self, event, target, player, data)
    return target == player and player:hasSkill(khaenqljins.name)
  end,
  on_use = function (self, event, target, player, data)
    data.skipped = false
  end,
})

-- khaenqljins:addEffect("maxcards", {
--   fixed_func = function(self, player)
--       return player.maxHp
--   end
-- })

-- khaenqljins:addEffect("maxcards", {
--   correct_func = function(self, player)
--     if   player:hasSkill(khaenqljins.name)  then
--       return  2*player:getLostHp()
--     end
--   end,
-- })

return khaenqljins
