Fk:loadTranslationTable{
  ["sziacqtsoeoc"] = "熵增",--訾程
  [":sziacqtsoeoc"] = "伱失去牌後,必發,伱抽x",

  ["#thoucqliak-active"] = "熵增  先選效果,否則緟置選牌 默認傷害",

  ["#thoucqliak-discard"] = "熵增 ",

  ["sziacqtsoeoc_liak"] = "程",
  ["damage"] = "致傷 ",
}

local sziacqtsoeoc = fk.CreateSkill{
  name = "sziacqtsoeoc",
  tags = { Skill.Compulsory },
}

sziacqtsoeoc:addEffect(fk.AfterCardsMove, {
  derived_piles = "sziacqtsoeoc_liak",
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(sziacqtsoeoc.name)  then return false end
    local t={}
    for _, move in ipairs(data) do
      if move.from ==player and (move.to~=player or not table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)) then
        for _, info in ipairs(move.moveInfo) do
          if   (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)   then
            table.insert(t,info.cardId)
          end
        end
      end
    end
    if #t>0 then
      event:setCostData(self, {n=#t})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(event:getCostData(self).n)
  end,
})

return sziacqtsoeoc
