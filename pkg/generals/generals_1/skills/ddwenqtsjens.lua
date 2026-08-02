local ddwenqtsjens = fk.CreateSkill {
  name = "ddwenqtsjens",
}

Fk:loadTranslationTable{
  ["ddwenqtsjens"] = "傳箭",
  [":ddwenqtsjens"] = "伱轉始旹,伱可聲明數字x發動｡當轉伱額定抽牌數-x+2,伱執行x項｡➀當轉預段始旹,對1腳色起動虛擬｢探聽｣➁當轉弃段始旹,令伱當轉存牌數當轉+1➂當轉末段始旹伱可選1手牌發動,幖記此牌交予1脚色.(幖記:此牌視爲殺且因花色具有效果.)", 

  ["#ddwenqtsjens-number"] = "傳箭 聲明數",
  ["#ddwenqtsjens-invoke"] = "傳箭 ｢探聽｣1脚色",
  ["#ddwenqtsjens-mark"] = "傳箭 選擇牌与腳色",
  ["@@ddwenqtsjens-inhand"] = "傳箭",

  ["$ddwenqtsjens1"] = "此是山寨裏之傳箭,少刻便有船來",
  ["$ddwenqtsjens1"] = "一支響箭穿雲霄",
  ["$ddwenqtsjens1"] = "箭令一起消息立去",

}
--DrawNCards
ddwenqtsjens:addEffect(fk.TurnStart, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ddwenqtsjens.name) 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local choices = {}
      for i = 0, 3 do
        table.insert(choices, tostring(i))
      end
    local  number = tonumber(room:askToChoice(player, { ---@type integer
        choices = choices,
        skill_name = ddwenqtsjens.name,
        prompt = "#ddwenqtsjens-number"
      }))
    if number>0 then
      event:setCostData(self, {n = number})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)  --鎖
    local room = player.room
    local n =event:getCostData(self).n
    room:setPlayerMark(player,"ddwenqtsjens-turn",n)
    room:setPlayerMark(player,"@add_drawN-turn",-n+2+player:getMark("@add_drawN-turn"))
  end,
})

-- ddwenqtsjens:addEffect(fk.DrawNCards, {
--   anim_type = "support",
--   can_refresh= function(self, event, target, player, data)
--     return target == player 
--     and player:getMark("ddwenqtsjens-turn")~=0
--   end,
--   on_refresh = function(self, event, target, player, data)  --鎖
--     data.n = data.n - player:getMark("ddwenqtsjens-turn") +2
--   end,
-- })




ddwenqtsjens:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    return target == player 
    and table.contains({Player.Finish,Player.Start,Player.Discard}, player.phase)  
    and  player:getMark("ddwenqtsjens-turn")~=0 
  end,

  on_cost = function(self, event, target, player, data)
    local room = player.room
    room:removePlayerMark(player,"ddwenqtsjens-turn",1)
    if player.phase == Player.Finish then
      local tos, cards =  room:askToChooseCardsAndPlayers(player, {
        min_card_num = 1,
        max_card_num = 1,
        min_num = 0,
        max_num = 1,
        targets = room.alive_players,
        prompt = "#ddwenqtsjens-mark",
        skill_name = ddwenqtsjens.name,
        will_throw = true,
        cancelable = false,
      })
      if #cards>0 then
        event:setCostData(self,{tos=tos,cards=cards})
        return true
      end
    elseif player.phase == Player.Start then  
      local tos = room:askToChoosePlayers(player, {
        min_num = 1,
        max_num = 1,
        targets = room.alive_players,
        skill_name = ddwenqtsjens.name,
        prompt = "#ddwenqtsjens-invoke",
        cancelable = true,
      })
        if #tos >0 then
          event:setCostData(self,{tos=tos})
        return true
      end
    else
      return room:askToSkillInvoke(player, { skill_name = ddwenqtsjens.name })
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local dat=event:getCostData(self)
    if not dat then
            room:addPlayerMark(player, MarkEnum.AddMaxCardsInTurn, 1)

    elseif  dat.cards then
      if dat.tos[1] then
       room:moveCardTo(dat.cards, Player.Hand, dat.tos[1], fk.ReasonGive, ddwenqtsjens.name, nil, false, player, {"@@ddwenqtsjens-inhand",1, "dzzjek__ssaet",1})
      else
        room:setCardMark(Fk:getCardById(dat.cards[1]),"@@ddwenqtsjens-inhand",1)
      end
    elseif dat.tos then 
      player.room:useVirtualCard("thoeoms_tsshaet", nil,player, dat.tos, ddwenqtsjens.name, false)

    end
  end,
})

-- ddwenqtsjens:addEffect("filter", {
--   card_filter = function(self, to_select, player)
--     return to_select:hasMark("@@ddwenqtsjens-inhand")
--   end,
--   view_as = function(self, player, to_select)
--     local card = Fk:cloneCard("dzzjek__ssaet", to_select.suit, to_select.number)
--     card.skillName = ddwenqtsjens.name
--     return card
--   end,
-- })

-- ddwenqtsjens:addEffect("targetmod", {
--   bypass_distances =  function(self, player, skill, card, to)
--     return  card and card:hasMark("@@ddwenqtsjens-inhand") and card.suit==Card.Heart
--   end,
--   bypass_times = function(self, player, skill, scope, card)
--     return  card and card:hasMark("@@ddwenqtsjens-inhand") and card.suit==Card.Spade
--   end,
-- })


-- ddwenqtsjens:addEffect(fk.PreCardUse, {  --PreCardUse moveCardTo
--   can_refresh = function (self, event, target, player, data)
--     return target == player  and data.card
--       and data.card:getMark("@@ddwenqtsjens-inhand")>0
--   end,
--   on_refresh = function (self, event, target, player, data)
--     if data.card.suit==Card.Spade then
--       data.extraUse = true
--     elseif data.card.suit==Card.Diamond then
--       data.disresponsiveList = table.simpleClone(player.room.players)
--     elseif data.card.suit==Card.Club then
      -- data.extra_data=data.extra_data or {}
      -- data.extra_data.ignore_Armor_to=table.simpleClone(player.room.players)
--     end
--   end
-- })

return ddwenqtsjens
