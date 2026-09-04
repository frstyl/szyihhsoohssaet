local tszihkvoa = fk.CreateSkill({
  name = "tszihkvoa",
})

Fk:loadTranslationTable{
  ["tszihkvoa"] = "止戈",
  [":tszihkvoa"] = "其它脚色主段始旹,伱可發動,其可交与伱1殺或武器牌,不執行則弃置1牌,對伱起動虛擬鬥將",


  ["#tszihkvoa-card"] = "觀陣:%dest 起動 %arg 伱可打出1同花色牌發令其无效",
  -- ["#tszihkvoa-damage"] = "觀陣：伱受到 %arg 傷害 伱可弃1同花色牌發防止傷害",

  ["$tszihkvoa1"] = "伱昰太乙三才陣何足爲奇",
  ["$tszihkvoa2"] = "九宮八卦已无敵,河洛四像眞堪奇",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"


tszihkvoa:addEffect(fk.EventPhaseEnd, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return
      player:hasSkill(tszihkvoa.name) 
      and target ~= player 
      and target.phase==Player.Draw
  end,
  on_use = function(self, event, target, player, data)
    -- local to =target
    local room=player.room
    local card = room:askToCards(target, {
      min_num = 1,
      max_num = 1,
      skill_name = tszihkvoa.name,
      include_equip = true,
      cancelable = true,
      pattern = "ssaet;.|.|.|.|.|weapon",
      prompt = "#tszihkvoa-give:"..player.id..":"..target.id,
    })
    if #card > 0 then
      room:moveCardTo(card, Card.PlayerHand, player, fk.ReasonGive, tszihkvoa.name, nil, false, target)
    else
      if not target:isNude()  then room:askToDiscard(target, {
          min_num = 1,
          max_num = 1,
          include_equip = true,
          skill_name = tszihkvoa.name,
          cancelable = false,
        })
        if target.dead then return end
      end
      room:useVirtualCard("tous_tsiacs", nil,  target,{player}, tszihkvoa.name, true)
    end
  end,
})



return tszihkvoa
