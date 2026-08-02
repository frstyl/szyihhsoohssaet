local peejskfan = fk.CreateSkill {
  name = "peejskfan",
}

Fk:loadTranslationTable{
  ["peejskfan"] = "閉關",
  [":peejskfan"] = "輪始旹,伱可發動. 伱自守",

  ["#peejskfan-invoke"] = "閉關 選擇牌",

  ["peejskfan_kfon"] = "程",

}

peejskfan:addEffect(fk.RoundStart, {
  derived_piles = "peejskfan_kfon",
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(peejskfan.name)
  end,
  on_cost = function(self, event, target, player, data)
      local cards=player.room:askToCards(player,{
        min_num=1,
        max_num=999,
        include_equip=true,
        -- pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
        --   return  not player:prohibitResponse(Fk:getCardById(id))
        -- end
        -- ) }),
        prompt = "#peejskfan-invoke", 
        cancelable = true,
      })
      if #cards>0 then
      event:setCostData(self, {cards = cards})
      return true
      end
  end,
  on_use = function(self, event, target, player, data)
    player:addToPile("peejskfan_kfon", event:getCostData(self).cards, true, peejskfan.name, player)
    room:addSkill("dzjissziuh")
    room:addPlayerMark(player, "@@dzjissziuh", 1)
  end,
})


peejskfan:addEffect("distance", {
  correct_func = function(self, from, to)
    if #to:getPile("peejskfan_kfon")>0 then
      return #to:getPile("peejskfan_kfon")
    end
  end,
})

-- peejskfan:addEffect(fk.HandleAskForPlayCard, {  --眞止問ask AskForCardData extraData eventData
--   can_refresh = function(self, event, target, player, data)  --雙向?
--     return player:getPile("peejskfan_kfon")~=0  and
--     data.eventData and  data.eventData.to~=player
--   end,
--   on_refresh = function(self, event, target, player, data)
--     if not data.afterRequest then
--       player.room:setPlayerMark(player,"peejskfan",1)
--     else
--       player.room:setPlayerMark(player,"peejskfan",0)
--     end
--   end,
-- })

-- peejskfan:addEffect(fk.AskForCardUse, {--trigger技用牌 會封其它結算
--   can_refresh = function(self, event, target, player, data)  --雙向?
--     return  player:getPile("peejskfan_kfon")~=0  and
--     data.eventData and  data.eventData.to~=player
--   end,
--   on_refresh = function(self, event, target, player, data)
--     player.room:setPlayerMark(player,"peejskfan",1)
--   end,
-- })

-- peejskfan:addEffect("prohibit", {
--   prohibit_use = function(self, player, card)
--     return player:getMark("peejskfan")~=0 and card
--   end,
--   is_prohibited = function(self, from, to, card)
--     return from and from:getMark("peejskfan") ~= 0 and card and from ~= to
--   end,
-- })


return peejskfan
