local cardSkill = fk.CreateSkill {
  name = "theen_djis_puanh_phius_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#theen_djis_puanh_phius_skill",
  can_use = function(self, player, card, extra_data)
    return not player:prohibitUse(card) 
    and S.magicCanUse(player, card, extra_data)
  end,  
  on_use = function (self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)
    cardUseEvent.toCard=cardUseEvent.card
  end,
  mod_target_filter = Util.FalseFunc,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect) --无目幖 直接執行effect --對全體效果 无目幖--復活自己
    for _, to in ipairs(room:getAllPlayers(true)) do
    if  to.dead then
      S.revive({
        who=p,
        skill=cardSkill.name
      })
    else 
      room:changeHp(to,-1,nil,cardSkill.name)
    end
  end
  end,
})



return cardSkill
