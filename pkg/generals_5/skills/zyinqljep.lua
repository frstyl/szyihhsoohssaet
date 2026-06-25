Fk:loadTranslationTable{
  ["zyinqljep"] = "巡獵",  --巡狩被巡守占
  [":zyinqljep"] = "補段終旹,伱可選1項發動.➀預打出1♦️牌獲取1其他角色2手牌➁獲取至多x其他角色各1手牌.(x爲伱裝僃區牌數且至少爲1)",--抽牌數+x
--加彊?

  ["#zyinqljep-choose"] = "巡獵  可打出1方片獲取1角色2手牌 或獲取至多 %arg角色各1手牌",

  ["$zyinqljep1"] = "山林珍饈任我取捨",
  ["$zyinqljep2"] = "昰大蟲伱給我吐出來",
  ["$zyinqljep3"] = "吾卽刻去討伐大蟲",
  -- ["$zyinqljep4"] = "金蛇弓響虎狼難逃",
}

local zyinqljep = fk.CreateSkill{
  name = "zyinqljep",
}

zyinqljep:addEffect(fk.EventPhaseEnd, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(zyinqljep.name) and player.phase==Player.Draw
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    local n= #player:getCardIds("e")
    if n<=0 then n=1 end
    local tos,cards = room:askToChooseCardsAndPlayers(player, {
      min_card_num = 0,
      max_card_num = 1,
			pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
        local c=  Fk:getCardById(id)
				return c.suit == Card.diamond and not player:prohibitResponse(c)
			end
			) }),
      -- include_equip=true,
      min_num = 1,
      max_num = n,
      targets = room:getOtherPlayers(player, false),
      skill_name = zyinqljep.name,
      prompt = "#zyinqljep-choose:::"..n,
      cancelable = true,
    })
    if #tos==0 then return end
    event:setCostData(self,{tos=tos,cards=cards})
    return true
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local cards=event:getCostData(self).cards
    local tos=event:getCostData(self).tos
    if #cards==0 then
      for _, to in ipairs(tos) do
        -- local to = room:getPlayerById(id)
        if not (to.dead or to:isKongcheng()) then
          local cids = room:askToChooseCard(player, {
            target = to,
            flag = "h",
            skill_name = zyinqljep.name,
          })
          room:obtainCard(player, cids, false, fk.ReasonPrey,player,zyinqljep.name)
          if player.dead then break end
        end
      end
    else
      room:responseCard({
				card=Fk:getCardById(event:getCostData(self).cards[1]),
				from=player,
				attachedSkillAndUser={muteCard=true},
			})
      if player.dead then return end
        local cids = room:askToChooseCards(player, {
          min = 2,
          max = 2,
          target = tos[1],
          flag = "h",
          skill_name = zyinqljep.name,
        })
      room:obtainCard(player, cids, false, fk.ReasonPrey,player,zyinqljep.name)
    end
  end,
})
-- zyinqljep:addEffect(fk.DrawNCards, {
--   anim_type = "control",
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(zyinqljep.name) 
--   end,
--   on_use = function(self, event, target, player, data)
--     data.n = data.n + #player:getCardIds("e")

--     local room = player.room
--     local targets = table.filter(room:getOtherPlayers(player, false), function(p) return not p:isKongcheng() end)
--     if #targets==0 then return end
--     local tos,cards = room:askToChooseCardsAndPlayers(player, {
--       min_card_num = 0,
--       max_card_num = 1,
--       pattern=".|.|diamond",
--       min_num = 1,
--       max_num = data.n,
--       targets = targets,
--       skill_name = zyinqljep.name,
--       prompt = "#zyinqljep-choose:"..data.n,
--       cancelable = true,
--     })
--     if #tos==0 then return end

--     if #tos==1 and #cards==1 then
--       room:throwCard(cards,zyinqljep.name,player,player)
--       if player.dead then return end
--         local cids = room:askToChooseCards(player, {
--           min = 2,
--           max = 2,
--           target = tos[1],
--           flag = "h",
--           skill_name = zyinqljep.name,
--         })
--       room:obtainCard(player, cids, false, fk.ReasonPrey,player,zyinqljep.name)
--       data.n = data.n -1
--       return
--     end
--     if #tos>0 then
--       room:sortByAction(tos)
--       for _, id in ipairs(tos) do
--         local to = id
--         if not (to.dead or to:isKongcheng()) then
--           local c = room:askToChooseCard(player, {
--             target = to,
--             flag = "h",
--             skill_name = zyinqljep.name,
--           })
--           room:obtainCard(player, cids, false, fk.ReasonPrey,player,zyinqljep.name)
--           if player.dead then break end
--         end
--       end
--       data.n = data.n - #tos
--     end
--   end,
-- })

return zyinqljep
