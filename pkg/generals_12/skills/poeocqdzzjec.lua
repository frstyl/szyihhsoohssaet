local poeocqdzzjec = fk.CreateSkill({
  name = "poeocqdzzjec",
  tags={Skill.Compulsory},  --鎖定意爲必發 <- 不失效 <- 无次數限定 
})

Fk:loadTranslationTable{
  ["poeocqdzzjec"] = "崩城",
  [":poeocqdzzjec"] = "鎖定.伱轉內,伱失去冣後手牌後,必發,伱流失1體力",

  ["$poeocqdzzjec"] = "資之㴱則取之左逢其源",

}

poeocqdzzjec:addEffect(fk.AfterCardsMove, {
  anim_type = "negative",
  can_trigger = function(self, event, target, player, data)
    if not (player:hasSkill(poeocqdzzjec.name) and player:isKongcheng() and player.room.current == player) then return end
    for _, move in ipairs(data) do
      if move.from == player then
        for _, info in ipairs(move.moveInfo) do
          if info.fromArea == Card.PlayerHand then
            return true
          end
        end
      end
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:loseHp(player,1, poeocqdzzjec.name)
  end,
})


return poeocqdzzjec
