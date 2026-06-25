Fk:loadTranslationTable{
  ["ddiuqmiuk"] = "綢繆",
  [":ddiuqmiuk"] = "主動.選擇至多x角色發動,各緟鑄1.若所緟鑄牌同花,伱抽1",
  -- [":ddiuqmiuk"] = "主動.選擇至多x角色發動,各緟鑄至多y.若所緟鑄牌同花,伱獲得技能浮槎(x爲伱體力值至少爲1,y爲輪數至少爲1)",

  ["#ddiuqmiuk-active"] = "綢繆： 令至多 %arg 角色各緟鑄1",
  ["#ddiuqmiuk-choose"] = "綢繆：緟鑄1",

  ["$ddiuqmiuk1"] = "今雖得勝歸朝仍須小心謹慎",
}

local ddiuqmiuk = fk.CreateSkill{
  name = "ddiuqmiuk",
}

ddiuqmiuk:addEffect("active", {
  anim_type = "drawcard",
  card_num = 0,
  min_target_num = 1,
  prompt=function(self,player)
    return "#ddiuqmiuk-active::"..(player.hp>0 and player.hp or 1)
  end,
  max_target_num = function(self,player)
    return player.hp>0 and player.hp or 1
  end,
  prompt = "#ddiuqmiuk",
  max_phase_use_time = 1,
  target_filter = function(self, player, to_select, selected)
    return true--#selected < self.max_target_num
  end,
  on_use = function(self, room, effect)
    room:sortByAction(effect.tos)
    local suits={}
    -- local get=false

        local result = room:askToJointCards(effect.from,{
        players = effect.tos,
        min_num = 1,
        max_num = 1,
        include_equip = true,
        cancelable = false,
        pattern = ".|.|.|hand,equip",
        skill_name = ddiuqmiuk.name,
        prompt = "#ddiuqmiuk-choose",
        will_throw = false,
      })
      for _, p in ipairs(effect.tos) do
        if not p.dead  and result[p] and result[p][1] then
          table.insertIfNeed(suits, Fk:getCardById(result[p][1]).suit)
          room:recastCard(result[p], p, ddiuqmiuk.name)
        end
      end
      if not effect.from.dead and #suits==1 then 
        effect.from:drawCards(1,ddiuqmiuk.name)
      end
  end,
})
return ddiuqmiuk
