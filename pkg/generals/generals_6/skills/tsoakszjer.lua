local tsoakszjer = fk.CreateSkill {
  name = "tsoakszjer",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["tsoakszjer"] = "作勢",
  [":tsoakszjer"] = "伱成爲其它腳色A起動目幖旹,必發.A須交与伱1牌(明置),若伱因此得到｢{殺/閃/肉/酒}｣,伱抽1,否則此次起動對伱无效➁當伱受傷旹,若伱伏區有牌,必發,防止此傷害",

  ["#tsoakszjer-choose"] = "作勢 交与%src 1牌 若不爲 殺閃酒肉 迻除目幖",

  ["$tsoakszjer1"] = "在昰里本官說已算",
  ["$tsoakszjer2"] = "昰个卻正是反詩汝若里得來",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tsoakszjer:addEffect(fk.TargetConfirming, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return   data.from ~= player and data.to ==player and player:hasSkill(tsoakszjer.name)  --and data.card.type==Card.TypeBasic --待改
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local cards=room:askToCards(data.from,{
      min_num=1,  --askToCard
      max_num=1,
      include_equip=true,
      pattern=".",
      prompt = "#tsoakszjer-choose:"..player.id,
      skill_name = tsoakszjer.name,
      cancelable = false,
    })
    room:moveCardTo(cards, Player.Hand, data.from, fk.ReasonGive, tsoakszjer.name, nil, true, data.from.id)

	if cards[1] and table.contains({"ssaet","szjemh","tsiuh","nziuk"}, Fk:getCardById(cards[1]).trueName) then 
      player:drawCards(1, tsoakszjer.name)
    else
      data:setNullified(data.to)
	      -- data:cancelTarget(data.to)
    end
  end,
})

tsoakszjer:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(tsoakszjer.name) and #player:getCardIds("j")>0
  end,
  on_use = function(self, event, target, player, data)
    S.preventDamage({damageData=data,skillName=tsoakszjer.name})
  end,
})
return tsoakszjer
