local giattszjens = fk.CreateSkill {
  name = "giattszjens",
}

Fk:loadTranslationTable{
  ["giattszjens"] = "竭戰",
  [":giattszjens"] = "一脚色A受傷後,若其體力不小于伱體力值,伱可選1項發動.➀令A自弃牌堆選擇1殺獲得➁令A无視次數起動1殺,",
  -- [":giattszjens"] = "伱可將1牌与伱上一所起動牌不同色者轉化爲殺起動發動.",

  ["#giattszjens-invoke"] = "竭戰 對%src 發動",
  ["giattszjens-get"] = "獲得 殺",
  ["giattszjens-use"] = "起動 殺",
  ["#giattszjens-prey"] = "竭戰 選擇殺獲得",
  ["#giattszjens-use"] = "竭戰 起動殺",

  -- ["#giattszjens"] = "竭戰 %arg 當殺",
  -- ["#giattszjens-no"] = "竭戰 不可用",

}

giattszjens:addEffect(fk.Damaged, {
  anim_type = "defensive",
  can_trigger= function(self, event, target, player, data)
    return player:hasSkill(giattszjens.name) --and data.to.hp>= player.hp
  end,
  -- on_cost= function(self, event, target, player, data)
  --   if player.room:askToSkillInvoke(player, {
  --     skill_name = giattszjens.name,
  --     prompt = "#giattszjens-invoke:"..data.to.id,
  --   })
  --   then
  --     event:setCostData(self, {tos = data.to})
  --     return true
  --   end
  -- end,
  on_cost= function(self, event, target, player, data)
    local choices={"giattszjens-get","giattszjens-use","Cancel"}
    local choice = player.room:askToChoice(player, {
      choices = choices,
      skill_name = giattszjens.name,
      prompt = "#giattszjens-invoke:"..data.to.id,
      all_choices = choices,
    })
    if choice~="Cancel" then
      event:setCostData(self, {tos = data.to,choice=choice})
      return true
    end
  end,
  on_use= function(self, event, target, player, data)
    local room=player.room
    if event:getCostData(self).choice=="giattszjens-get" then
      local cards = table.filter(room.discard_pile, function (id)
        return Fk:getCardById(id).trueName == "ssaet"
      end)
      if #cards==0 then return end
      local to =data.to
      local card = room:askToChooseCard(to, {
        target = to,
        flag = { card_data = {{ "pile_discard", cards }} },
        skill_name = giattszjens.name,
        prompt = "#giattszjens-prey",
      })
      room:moveCardTo(card, Card.PlayerHand, to, fk.ReasonJustMove, giattszjens.name, nil, true, to)
    else
      local use = room:askToUseCard(data.to, {
        skill_name = giattszjens.name,
        pattern = "ssaet",
        prompt = "#giattszjens-use",
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
      --   room:obtainCard(player, cards, true, fk.ReasonJustMove, player, giattszjens.name)
      -- end

  end,
})

-- giattszjens:addEffect("viewas", {
--   anim_type = "offensive",
--   pattern = "ssaet",
--   -- prompt = function(self,player)
--   --   local n=player:getMark("giattszjens")
--   --   if n~=0 and n~=3 then
--   --   local map={"log_spade","log_club","log_heart","log_diamond"}
--   --   return "#giattszjens:::"..map[n]
--   --   else 
--   --     return "#giattszjens-no"
--   --   end
--   -- end,
--   mute_card = true,
--   handly_pile = true,
--   card_filter = function(self, player, to_select, selected)
--     return #selected == 0 and Fk:getCardById(to_select).color ~= player:getMark("giattszjens-turn")
--   end,
--   view_as = function(self, player, cards)
--     if #cards ~= 1 then return end
--     local c = Fk:cloneCard("ssaet")
--     c.skillName = giattszjens.name
--     c:addSubcard(cards[1])
--     return c
--   end,
--   before_use = function(self, player, use)
--     player.room:setPlayerMark(player,"giattszjens-turn",use.card.color)
--   end,
--   enabled_at_play = function(self, player) 
--     return   player:getMark("giattszjens-turn")~=3
--   end,
--   enabled_at_response = function(self, player, response) 
--     return  not response  and player:getMark("giattszjens-turn")~=3
--   end,
-- })

return giattszjens
