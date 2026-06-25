
local khoucqmoon = fk.CreateSkill {
  name = "khoucqmoon",
}

Fk:loadTranslationTable{
  ["khoucqmoon"] = "空門",
  [":khoucqmoon"] = "伱失去伱冣後手牌後,伱回1.伱減去伱冣後體力後,伱抽1",  --有距離限制

  ["#khoucqmoon-invoke"] = "背水 是否發動 不選目幖則抽牌",

  -- ["$khoucqmoon1"] = "旅人多西望， 客雁難南歬",
  -- ["$khoucqmoon2"] = "霜露結瑤華， 煙波勞玉指",
}


khoucqmoon:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(khoucqmoon.name) or not player:isKongcheng() or not player:isWounded() then return end

      for _, move in ipairs(data) do
        if 
           move.from == player 
        then
          for _, info in ipairs(move.moveInfo) do
            if table.contains({Player.Hand },info.fromArea) then
              return true
            end
          end
        end
      end

  end,
  on_use = function(self, event, target, player, data)
    player.room:recover{
        who = player,
        num = 1,
        recoverBy = player,
        skillName = khoucqmoon.name,
      }
  end,
})

khoucqmoon:addEffect(fk.HpChanged, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return  target==player and player:hasSkill(khoucqmoon.name) and player.hp<1 and data.num < 0 
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(1,khoucqmoon.name)
  end,
})
return khoucqmoon
