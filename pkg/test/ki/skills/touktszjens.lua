local touktszjens = fk.CreateSkill {
  name = "touktszjens",
}

Fk:loadTranslationTable{
  ["touktszjens"] = "督戰",  --督戰
  [":touktszjens"] = "一脚色A受傷後,伱可選1項發動.➀令A自弃牌堆或処理區選擇1｢殺｣獲得➁令A可起動1殺(无視次數)",
  -- [":touktszjens"] = "伱可將1牌与伱上一所起動牌不同色者轉化爲殺起動發動.",

  ["#touktszjens-invoke"] = "督戰 對%src 發動",
  ["touktszjens-get"] = "獲得 ｢殺｣牌",
  ["touktszjens-use"] = "起動 ｢殺｣",
  ["#touktszjens-prey"] = "督戰 選擇殺獲得",
  ["#touktszjens-use"] = "督戰 起動1殺",

  -- ["#touktszjens"] = "督戰 %arg 當殺",
  -- ["#touktszjens-no"] = "督戰 不可用",

}

touktszjens:addEffect(fk.Damaged, {
  anim_type = "defensive",
  can_trigger= function(self, event, target, player, data)
    return player:hasSkill(touktszjens.name) --and data.to.hp>= player.hp
  end,
  -- on_cost= function(self, event, target, player, data)
  --   if player.room:askToSkillInvoke(player, {
  --     skill_name = touktszjens.name,
  --     prompt = "#touktszjens-invoke:"..data.to.id,
  --   })
  --   then
  --     event:setCostData(self, {tos = data.to})
  --     return true
  --   end
  -- end,
  on_cost= function(self, event, target, player, data)
    local choices={"touktszjens-get","touktszjens-use","Cancel"}
    local choice = player.room:askToChoice(player, {
      choices = choices,
      skill_name = touktszjens.name,
      prompt = "#touktszjens-invoke:"..data.to.id,
      all_choices = choices,
    })
    if choice~="Cancel" then
      event:setCostData(self, {tos = data.to,choice=choice})
      return true
    end
  end,
  on_use= function(self, event, target, player, data)
    local room=player.room
    if event:getCostData(self).choice=="touktszjens-get" then
      local cards = table.filter(room.discard_pile, function (id)
        return Fk:getCardById(id).trueName == "ssaet"
      end)
      local cards2 =  table.filter(room.processing_area, function (id)
        return Fk:getCardById(id).trueName == "ssaet"
      end)
      if #cards==0 and #cards2==0 then return end
      local to =data.to
      local card = room:askToChooseCard(to, {
        target = to,
        flag = { card_data = {
          { "pile_discard", cards }, { "processing_area", cards2 },
        } },
        skill_name = touktszjens.name,
        prompt = "#touktszjens-prey",
      })
      room:moveCardTo(card, Card.PlayerHand, to, fk.ReasonJustMove, touktszjens.name, nil, true, to)
    else
      local use = room:askToUseCard(data.to, {
        skill_name = touktszjens.name,
        pattern = "ssaet",
        prompt = "#touktszjens-use",
        cancelable=false,
        extra_data = {
          bypass_times = true,
          extraUse=true,
        },
      })
      if use then
        room:useCard(use)
      end
    end
      -- local cards = room:getCardsFromPileByRule("ssaet", 1, "discardPile")
      -- if #cards > 0 then
      --   room:obtainCard(player, cards, true, fk.ReasonJustMove, player, touktszjens.name)
      -- end

  end,
})

-- touktszjens:addEffect("viewas", {
--   anim_type = "offensive",
--   pattern = "ssaet",
--   -- prompt = function(self,player)
--   --   local n=player:getMark("touktszjens")
--   --   if n~=0 and n~=3 then
--   --   local map={"log_spade","log_club","log_heart","log_diamond"}
--   --   return "#touktszjens:::"..map[n]
--   --   else 
--   --     return "#touktszjens-no"
--   --   end
--   -- end,
--   mute_card = true,
--   handly_pile = true,
--   card_filter = function(self, player, to_select, selected)
--     return #selected == 0 and Fk:getCardById(to_select).color ~= player:getMark("touktszjens-turn")
--   end,
--   view_as = function(self, player, cards)
--     if #cards ~= 1 then return end
--     local c = Fk:cloneCard("ssaet")
--     c.skillName = touktszjens.name
--     c:addSubcard(cards[1])
--     return c
--   end,
--   before_use = function(self, player, use)
--     player.room:setPlayerMark(player,"touktszjens-turn",use.card.color)
--   end,
--   enabled_at_play = function(self, player) 
--     return   player:getMark("touktszjens-turn")~=3
--   end,
--   enabled_at_response = function(self, player, response) 
--     return  not response  and player:getMark("touktszjens-turn")~=3
--   end,
-- })

return touktszjens
