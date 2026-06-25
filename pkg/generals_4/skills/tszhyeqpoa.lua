local tszhyeqpoa = fk.CreateSkill{
  name = "tszhyeqpoa",
  -- tags = { Skill.Switch },  --三緟轉換技
}

Fk:loadTranslationTable{
  ["tszhyeqpoa"] = "吹波",
  [":tszhyeqpoa"] = "伱因伱使用打出弃置失去牌後,令記錄a +1,若a mod {1/2/3} = 0,令a=:0 且伱可預選{1/2/3}牌發動,緟鑄之,若爲3,伱視爲使用水攻(由伱選擇)",
--打出 弃置之別 打出允許虛牌 牌數必爲1?

  ["@tszhyeqpoa_number"] = "吹波",

  ["@tszhyeqpoa_switch"] = "吹波",

  ["#tszhyeqpoa-recast"] = "吹波 緟鑄%arg",
  ["#tszhyeqpoa-choose"] = "吹波 選擇1角色 予其1傷",

  ["$tszhyeqpoa1"] = "風來波起",  --1 --2 --3
}

tszhyeqpoa:addLoseEffect (function (self, player)
    player.room:setPlayerMark(player,"@tszhyeqpoa_number",0)
    player.room:setPlayerMark(player,"@tszhyeqpoa_switch",0)
end)

tszhyeqpoa:addAcquireEffect (function (self, player)
    player.room:setPlayerMark(player,"@tszhyeqpoa_switch",1)
end)


tszhyeqpoa:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(tszhyeqpoa.name,true)  then return end
    local n=player:getMark("@tszhyeqpoa_number")
    -- local switch=player:getMark("@tszhyeqpoa_switch")+1  --player:usedEffectTimes(tszhyeqpoa.name, Player.HistoryGame)

      for _, move in ipairs(data) do  --使用打出未寫proposer
        if move.from ==player and (move.to~=player or not table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)) and (move.proposer==player or move.proposer==nil) and table.contains({fk.ReasonUse, fk.ReasonResponse, fk.ReasonDiscard}, move.moveReason) then
          for _, info in ipairs(move.moveInfo) do
            if   (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)  then
              -- n=n+1
              -- n =n % (player:getMark("@tszhyeqpoa_switch")+1)
              -- player.room:setPlayerMark(player,"@tszhyeqpoa_number",n)
              -- if n==0 then
                return  player:hasSkill(tszhyeqpoa.name) 
              -- end
            end
          end
        end
      end
    -- n= n%3
    -- player.room:setPlayerMark(player,"@tszhyeqpoa_number",n)
    -- if n==0 then
    --   return true
    -- end
  end,
  on_cost = function(self, event, target, player, data)
    local n = player:getMark("@tszhyeqpoa_switch")
    local room=player.room
      local cards = room:askToCards(player, {
        min_num = n,
        max_num = n,
        include_equip = true,
        prompt = "#tszhyeqpoa-recast:::"..n,
        skill_name = tszhyeqpoa.name,
        cancelable = true,
      })
      if #cards > 0 then
        event:setCostData(self,{cards=cards,switch=player:getMark("@tszhyeqpoa_switch")})

        return true
     end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    -- room:setPlayerMark(player,"@tszhyeqpoa_number",0)
    local n =event:getCostData(self).switch
    room:setPlayerMark(player,"@tszhyeqpoa_switch",n~=3 and n+1 or 1)
    local cards =  event:getCostData(self).cards
    player.room:recastCard(cards, player, tszhyeqpoa.name)
    if  n~=3  or player.dead then return end

  local tos = room:askToChoosePlayers(player,{
      targets=room:getOtherPlayers(player),
      min_num=1,
      max_num=1,
      cancelable=true,
      prompt = "#tszhyeqpoa-choose",
    })
    if #tos~=1 then return end

    local card = Fk:cloneCard("szyih_kouc")

    card.skill = Fk.skills["hqeenqmjet__szyih_kouc_skill"]
    local use = { ---@type UseCardDataSpec
    from = player,
    tos = tos,
    card = card,
    }
    if not player:canUseTo(card, tos[1], {bypass_distances = true, bypass_times = true}) then return end
    room:useCard(use)
    

      end,
})

-- tszhyeqpoa:addEffect(fk.PreCardEffect, {
--   can_refresh = function(self, event, target, player, data)
--     return player==target and data.card table.contains(data.card.skillNames,"tszhyeqpoa")
--   end,
--   on_refresh = function(self, event, target, player, data)
--     local card = data.card:clone()
--     local c = table.simpleClone(data.card)
--     for k, v in pairs(c) do
--       card[k] = v
--     end
--     card.skill = Fk.skills["hqeenqmjet__szyih_kouc_skill"]
--     data.card = card
--   end,
-- })

return tszhyeqpoa
