local biuhkiams = fk.CreateSkill {
  name = "biuhkiams",
}

Fk:loadTranslationTable{
  ["biuhkiams"] = "負劍",
  [":biuhkiams"] = "主旹,伱聲名1/名字数花色/點數發動,檢𡩡裝僃牌置于伱將牌上, 伱虛擬裝僃之",

  ["#biuhkiams"] = "負劍 隨機獲得1此花色坐騎牌",
  ["#biuhkiams-choose"] = "負劍 選擇1脚色 發動荐馬",

  ["$biuhkiams1"] = "好一匹棗紅馬",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

biuhkiams:addEffect("active", {
  anim_type = "control",
  prompt = "#biuhkiams",
  card_num=1,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(biuhkiams.name, Player.HistoryPhase) == 0
  -- end,
  interaction = function(self)
    return UI.ComboBox {
      choices = {"dzis", "suit", "number"},
    }
  end,
  on_use = function(self, room, effect)
    local card=Fk:getCardById(effect.cards[1])
    local pattern="."
    if self.interaction.data=="suit" then
      pattern =".|.|"..card:getSuitString().."|.|.|weapon"
    elseif self.interaction.data=="dzis"  then
      local n = S.getCardNameLength(card)
      t=table.filter(Fk:getAllCardNames("e",true), function(trueName) 
        return #trueName==n and Fk:cloneCard(trueName).sub_type==Card.SubtypeWeapon
      end)
      pattern =table.concat(t,",")
    else 
      pattern =".|"..card.number.."|.|.|.|weapon"
    end

      local cards=room:getCardsFromPileByRule(pattern,1,"allPiles")  --待改 過濾非馬
      if #cards==0 or effect.from.dead  then return end
      -- local player=effect.from
      -- room:moveCards({
      --   ids = cards,
      --   to = effect.from,
      --   toArea = Card.PlayerHand,
      --   moveReason = fk.ReasonJustMove,
      --   proposer = effect.from,
      --   skillName = biuhkiams.name,
      -- })
    effect.from:addToPile("biuhkiams_prac", cards, true, biuhkiams.name, effect.from)
    S.addVirtualEquip(effect.from,Fk:getCardById(cards[1]).trueName, biuhkiams.name)
  end,
})

biuhkiams:addLoseEffect(function (self, player)
  for _,id in ipairs(player:getPile("biuhkiams_prac")) do
      S.removeVirtualEquip(player,Fk:getCardById(id).name,biuhkiams.name)
  end
      -- player.room:setPlayerMark(player,"_kximqkaap",0)  --true
  player.room:moveCardTo(player:getPile("biuhkiams_prac"), Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, biuhkiams.name, nil, true, player)

end
)

return biuhkiams
