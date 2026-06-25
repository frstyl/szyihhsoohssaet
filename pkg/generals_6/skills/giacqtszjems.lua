Fk:loadTranslationTable{
  ["giacqtszjems"] = "彊占",
  [":giacqtszjems"] = "末段始旹,伱可選擇1有手牌其它角色發動.伱獲取其全部手牌,伱下个轉始旹,伱將全部手牌交与其",

  ["#giacqtszjems-choose"] = "彊占 選擇目幖 獲取其全部手牌,伱下个轉始旹,伱將全部手牌交与其",
  ["@@giacqtszjems"] = "彊占",

  ["$giacqtszjems1"] = "我就是要占已伱後花園伱能拏把我怎像",
  ["$giacqtszjems2"] = "三日不外般,先喫我一百訓棍",
}

local giacqtszjems = fk.CreateSkill{
  name = "giacqtszjems",
}

giacqtszjems:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(giacqtszjems.name) and player.phase == Player.Finish
  end,
  on_cost = function(self, event, target, player, data)
    local to =player.room:askToChoosePlayers(player, {
          targets = table.filter(player.room.alive_players, function(p)
          return p~= player and not p:isKongcheng()
          end),
          min_num = 1,
          max_num = 1,
          prompt = "#giacqtszjems-choose",
          skill_name = giacqtszjems.name,
          cancelable = true,
        })
      if #to>0 then
        event:setCostData(self,{tos=to})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local to =event:getCostData(self).tos[1]
    player.room:moveCardTo(to:getCardIds("h"), Player.Hand, player, fk.ReasonPrey, giacqtszjems.name, nil, true, player)
    player.room:setPlayerMark(player,"@@giacqtszjems",to.id)
  end,
})


giacqtszjems:addEffect(fk.TurnStart, {
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return target == player  and player:getMark("@@giacqtszjems")~=0 
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:moveCardTo(player:getCardIds("h"), Player.Hand, player.room:getPlayerById(player:getMark("@@giacqtszjems")), fk.ReasonGive, giacqtszjems.name, nil, true, player)
    player.room:setPlayerMark(player,"@@giacqtszjems",nil)
  end,
})
return giacqtszjems
