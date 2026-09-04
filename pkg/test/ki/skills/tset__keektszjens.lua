local test__keektszjens = fk.CreateSkill {
  name = "test__keektszjens",
}


Fk:loadTranslationTable{
  ["test__keektszjens"] = "擊戰",
  [":test__keektszjens"] = "伱起動殺或鬥將旹可發動.此牌擁有擊戰效果至結算終.伱与目幖同旹選擇抽1或弃1,若所選相同,此{殺/鬥將}不可被{閃/防患未肰}抵消.效果:此牌致傷旹傷害值加1,此牌被抵消旹,伱弃2手牌或流失1",
  ["#test__keektszjens"] = "擊戰 失去體力加傷",

  ["#changeDamageBySkill"] = "由于 %arg 的效果，對 %from 傷害 + %arg2",

  ["$test__keektszjens1"] = "賊子伱往若里去",
  ["$test__keektszjens2"] = "",
}

test__keektszjens:addEffect(fk.CardUsing, {  --
  anim_type = "offensive",
  prompt = "#test__keektszjens",
	can_trigger = function(self, event, target, player, data)
		return target==player and player:hasSkill(test__keektszjens.name)
    and (data.card.trueName=="ssaet" or data.card.trueName=="tous_tsiacs")
	end,
	on_use = function(self, event, target, player, data)
    local room=player.room

    local tos=table.simpleClone(data.tos)
    table.insertIfNeed(tos,player)

    local params = {
      players = tos,
      choices = {"draw","discard"},
      prompt = "test__keektszjens-choose",
      skillName = test__keektszjens.name,
      send_log = true,
    }
   
    local req = player.room:askToJointChoice(player,params)
    local n=req[player]
    data.extra_data=data.extra_data or{}
    data.extra_data.test__keektszjens={}
    for _,p in ipairs(data.tos) do
      if n==req[p] then
        data.extra_data.test__keektszjens[p.id]=true
      end
    end

    player.room:addTableMark(data.card,"test__keektszjens-phase",player.id)

    local use = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true)
    -- if 
    use:addCleaner(function()
        -- room:setCardMark(data.card,"@@test__keektszjens-prohibit-phase",nil)
        room:setCardMark(data.card,"test__keektszjens-phase",nil)  --  --插入中起動此牌會增傷

        for _,p in ipairs(tos) do
          if req[p]=="discard" then
            room:askToDiscard(p, {
              min_num = 1,
              max_num = 1,
              include_equip = false,
              skill_name = test__keektszjens.name,
              cancelable = false,
              prompt = "#test__keektszjens-discard",
              skip = false,
            })
          else
            p:drawCards(1, test__keektszjens.name)
          end
        end

      end)

  end,
})

test__keektszjens:addEffect(fk.DamageInflicted, {
  can_refresh = function(self, event, target, player, data)
    return data.card  and table.contains(data.card:getTableMark("test__keektszjens-phase"),player.id)  --多次?
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:sendLog{ type = "#changeDamageBySkill", from = data.to.id, arg = test__keektszjens.name ,arg2=1}
    data:changeDamage(1)
  end,
})

test__keektszjens:addEffect(fk.PreCardEffect, {
  can_trigger = function(self, event, target, player, data)
    return data.to==player and data.extra_data and data.extra_data.test__keektszjens and data.extra_data.test__keektszjens[data.to.id]
  end,
  on_trigger = function(self, event, target, player, data)

    data.prohibitedCardNames=data.prohibitedCardNames or {}
    table.insertIfNeed(data.prohibitedCardNames, "szjemh")
    table.insertIfNeed(data.prohibitedCardNames, "nullification")

  end,
})

-- test__keektszjens:addEffect(fk.HandleAskForPlayCard, {  --眞止問ask AskForCardData extraData eventData
--   can_refresh = function(self, event, target, player, data)  --雙向?
--     if  data.eventData and  data.eventData.card
--         and table.contains(data.eventData.card:getTableMark("@@test__keektszjens-prohibit-phase"), player.id)
--         then
--       --                 for _, p in ipairs(Fk:currentRoom().players) do  --7.22入庫 8.23發現整段被註 而此未註
--       -- p:drawCards(1, toojskveet.name)
--       -- -- ssaacqsih(p)
--       --       end
--         return  true
--         end
--   end,
--   on_refresh = function(self, event, target, player, data)
--     local room = player.room
--     if not data.afterRequest then
--       room:setPlayerMark(player,"@@test__keektszjens-prohibit-phase", 1)
--     else
--       room:setPlayerMark(player,"@@test__keektszjens-prohibit-phase", 0)
--     end
--   end,
-- })

-- test__keektszjens:addEffect("prohibit", {
--   prohibit_use = function(self, player, card)
--    return player:getMark("@@test__keektszjens-prohibit-phase")>0 and card and (card.trueName=="szjemh" or  card.trueName=="nullification")
--   end,
--   -- prohibit_response = function(self, player, card)
--   --  return player:getMark("@@test__keektszjens-prohibit-phase")>0 and card and card.trueName=="ssaet"
--   -- end,
-- })
test__keektszjens:addEffect(fk.CardEffectCancelledOut, {
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return data.card  and table.contains(data.card:getTableMark("test__keektszjens-phase"),player.id)
    -- and (not data.damageDealt or not data.damageDealt[data.tos[1]])
    -- and (data.card.trueName=="ssaet" and data.cardsResponded[1].trueName=="szjemh"
    --     or(data.card.trueName=="tous_tsiacs" and data.cardsResponded[1].trueName=="tsiac_keejs_dzius_keejs"  --nullification
          
    --     ))
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    local discards = room:askToDiscard(player, {
        min_num = 2,
        max_num = 2,
        include_equip = false,
        skill_name = test__keektszjens.name,
        cancelable = true,
        skip=false,
      })
      if #discards<3 then
        room:loseHp(player,1,test__keektszjens.name)
      end
  end,
})

return test__keektszjens
