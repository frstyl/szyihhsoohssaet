Fk:loadTranslationTable{
  ["ex__ddiuqmiuk"] = "綢繆",
  [":ex__ddiuqmiuk"] = "主動.選擇至多x角色發動,各緟鑄至多y.若所緟鑄牌同花,伱獲得技能浮槎(x爲伱體力值至少爲1,y爲輪數至少爲1)",
  -- [":ex__ddiuqmiuk"] = "主動.選擇至多x角色發動,各緟鑄至多y.若所緟鑄牌同花,伱獲得技能浮槎(x爲伱體力值至少爲1,y爲輪數至少爲1)",

  ["#ex__ddiuqmiuk"] = "綢繆：弃置任意张牌并摸等量的牌，若弃置了所有的手牌，你多摸一张牌",

  ["$ex__ddiuqmiuk1"] = "今雖得勝歸朝仍須小心謹慎",
}

local ex__ddiuqmiuk = fk.CreateSkill{
  name = "ex__ddiuqmiuk",
}

ex__ddiuqmiuk:addEffect("active", {
  anim_type = "drawcard",
  card_num = 0,
  min_target_num = 1,
  max_target_num = function(self,player)
    return player.hp>0 and player.hp or 1
  end,
  prompt = "#ex__ddiuqmiuk",
  max_phase_use_time = 1,
  target_filter = function(self, player, to_select, selected)
    return true--#selected < self.max_target_num
  end,
  on_use = function(self, room, effect)
    local n = room:getBanner("RoundCount")
    if n==nil or type(n)~="number" or n<1 then n=1 end
    for _, p in ipairs(effect.tos) do
      if not p.dead then
        p:drawCards(n,ex__ddiuqmiuk.name)
      end
    end
    local suits={}
    local get=true
    for _, p in ipairs(effect.tos) do
      if not p.dead then
        local cards = room:askToDiscard(p, {
          min_num = n,
          max_num = n,
          include_equip = false,
          skill_name = ex__ddiuqmiuk.name,
          cancelable = false,
          prompt = "#ex__ddiuqmiuk-discard",
        })
        for _, id in ipairs(cards) do
          local suit= Fk:getCardById(id).suit
          if not table.contains(suits,suit) then  --if table.insertIfNeed(suits,suit)
            table.insert(suits,suit)
          else
            get=false
          end
        end

      end
    end
    -- effect.from:drawCards(#suits,ex__ddiuqmiuk.name)
    if get then
      if not effect.from:hasSkill("biuqdzsaa",true,true) then
        room:handleAddLoseSkills(effect.from, "biuqdzsaa", nil, true, false)
      else
        room:addPlayerMark(effect.from,"biuqdzsaa",1)
      end
    else
       room:addPlayerMark(effect.from,MarkEnum.AddMaxCards,1)
    end
  end,
})
return ex__ddiuqmiuk
