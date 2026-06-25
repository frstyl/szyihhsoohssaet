
local deeploacs = fk.CreateSkill{
  name = "deeploacs",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["deeploacs"] = "疊浪",
  [":deeploacs"] = "當伱失去牌後,伱獲得x幖記,若x爲耦數,伱可發動,伱抽x/2(x爲伱當次所失牌數)",

  -- ["@thoucqliak"] = "疊浪  先選效果,否則緟置選牌 默認傷害",

}

deeploacs:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_refresh= function(self, event, target, player, data)
    if not player:hasSkill(deeploacs.name,true)  then return false end
    local n=0
    for _, move in ipairs(data) do
      if move.from ==player and (move.to~=player or not table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)) then
        for _, info in ipairs(move.moveInfo) do
          if   (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)   then
            n=n+1
          end
        end
      end
    end
    if n>0 then
      event:setCostData(self, {n=n})
      return true
    end
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:addPlayerMark(player,"@deeploacs", event:getCostData(self).n)

  end,
  can_trigger= function(self, event, target, player, data)
    return event:getCostData(self) and player:hasSkill(deeploacs.name) and (player:getMark("@deeploacs"))%2==0
  end,
  on_use= function(self, event, target, player, data)
    local n = player:getMark("@deeploacs")//2
    player.room:setPlayerMark(player,"@deeploacs", 0)
    player:drawCards(n, deeploacs.name)
  end,
})


return deeploacs
