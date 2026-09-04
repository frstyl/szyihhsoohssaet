local kwiqsik = fk.CreateSkill {
  name = "kwiqsik",
  -- tags = { Skill.Compulsory },
}
Fk:loadTranslationTable{
  ["kwiqsik"] = "龜息",
  [":kwiqsik"] = "伱受傷後,伱可發動,伱存牌數+1➁伱牌被弃置後,伱可發動,伱獲得1護甲",

  ["#kwiqsik-invoke"] = "龜息 選擇目幖 ",


  ["$kwiqsik1"] = "一對白龍爭上下",
  ["$kwiqsik2"] = "董一撞在此",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

kwiqsik:addEffect(fk.Damaged, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return data.to==player and player:hasSkill(kwiqsik.name) 
  end,
  on_use = function(self, event, target, player, data)
    player.room:addPlayerMark(target,MarkEnum.AddMaxCards,1)
  end,
})

kwiqsik:addEffect(fk.AfterCardsMove, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(kwiqsik.name)  then return end

      for _, move in ipairs(data) do  --起動打出未寫proposer
        if move.from ==player 
        and fk.ReasonDiscard== move.moveReason 
        then
          for _, info in ipairs(move.moveInfo) do
            if   table.contains({Card.PlayerEquip,Card.PlayerHand },info.fromArea) then
                return  true
            end
          end
        end
      end

  end,
  on_use = function(self, event, target, player, data)
    player.room:changeShield(player,1)
  end,
})
return kwiqsik
