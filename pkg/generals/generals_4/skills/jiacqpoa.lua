local jiacqpoa = fk.CreateSkill{
  name = "jiacqpoa",
  tags = { Skill.Switch },  --多情緟轉換技
}

Fk:loadTranslationTable{
  ["jiacqpoa"] = "揚波",
  [":jiacqpoa"] = "伱因伱起動或打出或弃置失去牌後,(輪流發動)伱可{➀發動,抽1➁褈鑄2牌發動➂發動,印得3空牌➃以1牌轉化起動｢水攻｣發動}",
  -- [":jiacqpoa"] = "伱因伱起動或打出或弃置失去牌後,令記錄a +1,若a mod {1/2/3} = 0,令a=:0 且伱可預選{1/2/3}牌發動,緟鑄之,若爲3,伱視爲起動水攻(由伱選擇)",
--打出 弃置之別 打出允許虛牌 牌數必爲1?

  -- ["@jiacqpoa_number"] = "jiacqpoa",

  ["@jiacqpoa_switch"] = "揚波",

  ["#jiacqpoa-recast"] = "揚波 緟鑄%arg",
  -- ["#jiacqpoa-choose"] = "揚波 選擇1脚色 予其1傷",
  ["#jiacqpoa-use"] = "揚波 轉化 水攻",
  ["#jiacqpoa-draw"] = "揚波 抽1",
  ["#jiacqpoa-print"] = "揚波  印得3空",

  ["$jiacqpoa1"] = "風來波起",  --1 --2 --3
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

jiacqpoa:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(jiacqpoa.name)  then return end

      for _, move in ipairs(data) do  --起動打出未寫proposer
        if move.from ==player 
        and (move.to~=player or not table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)) 
        and (move.proposer==player or move.proposer==nil) --應該檢測user
        and table.contains({fk.ReasonUse, fk.ReasonResponse, fk.ReasonDiscard}, move.moveReason) 
        then
          for _, info in ipairs(move.moveInfo) do
            if   table.contains({Card.PlayerEquip,Card.PlayerHand },info.fromArea) then
                return  true
            end
          end
        end
      end

  end,
  on_cost = function(self, event, target, player, data)
    local n = player:getMark("@jiacqpoa_switch")

    if n==4 then
      local use = player.room:askToUseVirtualCard(player, {
        name = "szyih_kouc",
        skill_name = jiacqpoa.name,
        prompt = "#jiacqpoa-use",
        cancelable = true,
        extra_data = {
          koarbiuk_rule=true,
        },
        card_filter = {
          n = 1,
          pattern=".|.|.",
          -- cards = cards,
        },
        skip = true,
      })
      if use then
        event:setCostData(self, { extra_data = use,tos=use.tos, switch=n})
        return true
      end
    end

    if n~=2 then
      if player.room:askToSkillInvoke(player,{
        name=jiacqpoa.name,
      prompt= n==1 and "#jiacqpoa-draw" or "#jiacqpoa-print",
    }) 
      then
        event:setCostData(self,{switch=n})
        return true
      end
      return
    end
    local room=player.room
      local cards = room:askToCards(player, {
        min_num = n,
        max_num = n,
        include_equip = true,
        prompt = "#jiacqpoa-recast:::"..n,
        skill_name = jiacqpoa.name,
        cancelable = true,
      })
      if #cards > 0 then
        event:setCostData(self,{cards=cards,switch=n})
        return true
     end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    -- room:setPlayerMark(player,"@jiacqpoa_number",0)
    local n =event:getCostData(self).switch
    room:setPlayerMark(player,"@jiacqpoa_switch",n~=4 and n+1 or 1)
    if n==1 then
      player:drawCards(1,jiacqpoa.mame)
      return
    elseif n==2 then
      room:recastCard(event:getCostData(self).cards, player, jiacqpoa.name)
      return
    elseif n==3 then
          room:moveCards({
      ids = S.getKhouc( 3),
      to = player,
      toArea = Card.PlayerHand,
      moveReason = fk.ReasonJustMove,
      proposer = player,
      skill_name = jiacqpoa.name,
      moveVisible = true,
    })
    else
          room:useCard(event:getCostData(self).extra_data)

    end

    end,
})

jiacqpoa:addLoseEffect (function (self, player)
    -- player.room:setPlayerMark(player,"@jiacqpoa_number",0)
    player.room:setPlayerMark(player,"@jiacqpoa_switch",nil)
end)

jiacqpoa:addAcquireEffect (function (self, player)
    player.room:setPlayerMark(player,"@jiacqpoa_switch",1)
end)


-- jiacqpoa:addEffect(fk.AfterCardsMove, {
--   anim_type = "drawcard",
--   can_trigger = function(self, event, target, player, data)
--     if not player:hasSkill(jiacqpoa.name,true)  then return end
--     local n=player:getMark("@jiacqpoa_number")
--     -- local switch=player:getMark("@jiacqpoa_switch")+1  --player:usedEffectTimes(jiacqpoa.name, Player.HistoryGame)

--       for _, move in ipairs(data) do  --起動打出未寫proposer
--         if move.from ==player and (move.to~=player or not table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)) and (move.proposer==player or move.proposer==nil) and table.contains({fk.ReasonUse, fk.ReasonResponse, fk.ReasonDiscard}, move.moveReason) then
--           for _, info in ipairs(move.moveInfo) do
--             if   (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)  then
--               -- n=n+1
--               -- n =n % (player:getMark("@jiacqpoa_switch")+1)
--               -- player.room:setPlayerMark(player,"@jiacqpoa_number",n)
--               -- if n==0 then
--                 return  player:hasSkill(jiacqpoa.name) 
--               -- end
--             end
--           end
--         end
--       end
--     -- n= n%3
--     -- player.room:setPlayerMark(player,"@jiacqpoa_number",n)
--     -- if n==0 then
--     --   return true
--     -- end
--   end,
--   on_cost = function(self, event, target, player, data)
--     local n = player:getMark("@jiacqpoa_switch")
--     local room=player.room
--       local cards = room:askToCards(player, {
--         min_num = n,
--         max_num = n,
--         include_equip = true,
--         prompt = "#jiacqpoa-recast:::"..n,
--         skill_name = jiacqpoa.name,
--         cancelable = true,
--       })
--       if #cards > 0 then
--         event:setCostData(self,{cards=cards,switch=player:getMark("@jiacqpoa_switch")})

--         return true
--      end
--   end,
--   on_use = function(self, event, target, player, data)
--     local room=player.room
--     -- room:setPlayerMark(player,"@jiacqpoa_number",0)
--     local n =event:getCostData(self).switch
--     room:setPlayerMark(player,"@jiacqpoa_switch",n~=3 and n+1 or 1)
--     local cards =  event:getCostData(self).cards
--     player.room:recastCard(cards, player, jiacqpoa.name)
--     if  n~=3  or player.dead then return end

--   local tos = room:askToChoosePlayers(player,{
--       targets=room:getOtherPlayers(player),
--       min_num=1,
--       max_num=1,
--       cancelable=true,
--       prompt = "#jiacqpoa-choose",
--     })
--     if #tos~=1 then return end

--     local card = Fk:cloneCard("szyih_kouc")

--     card.skill = Fk.skills["hqeenqmjet__szyih_kouc_skill"]
--     local use = { ---@type UseCardDataSpec
--     from = player,
--     tos = tos,
--     card = card,
--     }
--     if not player:canUseTo(card, tos[1], {bypass_distances = true, bypass_times = true}) then return end
--     room:useCard(use)
    

--       end,
-- })

-- -- jiacqpoa:addEffect(fk.PreCardEffect, {
-- --   can_refresh = function(self, event, target, player, data)
-- --     return player==target and data.card table.contains(data.card.skillNames,"jiacqpoa")
-- --   end,
-- --   on_refresh = function(self, event, target, player, data)
-- --     local card = data.card:clone()
-- --     local c = table.simpleClone(data.card)
-- --     for k, v in pairs(c) do
-- --       card[k] = v
-- --     end
-- --     card.skill = Fk.skills["hqeenqmjet__szyih_kouc_skill"]
-- --     data.card = card
-- --   end,
-- -- })

return jiacqpoa
