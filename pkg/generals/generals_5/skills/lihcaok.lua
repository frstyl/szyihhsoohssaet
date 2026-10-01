local lihcaok = fk.CreateSkill {
  name = "lihcaok",
}
Fk:loadTranslationTable{
["lihcaok"] = "理樂",
[":lihcaok"] = "應動｡伱占卜牌生效後伱可發動,若其爲紅,伱取得之,否則伱虛擬起動之",

["#lihcaok-choose"] = "理樂 選擇一脚色 視爲對其起動殺",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

lihcaok:addEffect(fk.FinishJudge, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(lihcaok.name) and
      data.card 
  end,
  on_use = function(self, event, target, player, data)
    if data.card.color ==Card.Red   then
      if  player.room:getCardArea(data.card) == Card.Processing then
        player.room:obtainCard(player, data.card, true, fk.ReasonPrey, player, lihcaok.name)
      end
    else
        local use=S.askToVirutalUse(player,{
        card=data.card,
        bypass_times=false,
        skip=false,
        cancelable=false,
      })
    end
  end,
})


return lihcaok
