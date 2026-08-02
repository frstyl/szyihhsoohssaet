local askToDiscardHomoChromic = fk.CreateSkill({
  name = "askToDiscardHomoChromic",
})

askToDiscardHomoChromic:addEffect("active", {  --弃同色牌
  mute = true,
  card_num = 1,
  card_filter = function (self, player, to_select, selected)
    if not self.color then return end --Card.Black = 1  Card.Red = 2--- 无色Card.NoColor = 3

    if Fk:currentRoom():getCardArea(to_select) == Card.PlayerSpecial then
      local pile = ""
      for p, t in pairs(Self.special_cards) do
        if table.contains(t, to_select) then
          pile = p
          break
        end
      end
      if not string.find(self.pattern or "", pile) then return false end
    end

    local checkpoint = true
    local card = Fk:getCardById(to_select)

    local status_skills = Fk:currentRoom().status_skills[ProhibitSkill] or Util.DummyTable
    for _, skill in ipairs(status_skills) do
      if skill:prohibitDiscard(Self, card) then
        return false
      end
    end

    if not self.include_equip then
      checkpoint = checkpoint and (Fk:currentRoom():getCardArea(to_select) ~= Player.Equip)
    end

    if   self.same_color==nil or self.same_color==true then  --不寫 同色
       checkpoint =checkpoint and  ( self.color~=Card.NoColor and self.color == card.color )
    elseif self.same_color==false then  --不同
      checkpoint =checkpoint and (self.color==Card.NoColor or  self.color ~=card.color  )
    elseif self.same_color==2 then  --異色 非 黑紅互轉
      checkpoint =checkpoint and ( self.color~=Card.NoColor and card.color~=Card.NoColor and self.color~=card.color)
    end

    return checkpoint
  end,
  -- on_use = function(self, room, effect)
  --   room:throwCard(effect.card, self.skillName, effect,from, effect,from)
  -- end,
})


return askToDiscardHomoChromic
