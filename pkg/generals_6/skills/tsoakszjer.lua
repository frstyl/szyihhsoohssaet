local tsoakszjer = fk.CreateSkill {
  name = "tsoakszjer",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["tsoakszjer"] = "作勢",
  [":tsoakszjer"] = "鎖➀當其它角色使用牌指定伱爲目幖旹,必發.其交与伱1牌(明置),若不爲基本,此牌對伱无效,爲基本伱抽1➁當伱受傷旹,若伱伏區有牌,必發,防止此傷害",

  ["#tsoakszjer-choose"] = "作勢 交与%src 1牌 若不爲基本所用牌對其无效",

  ["$tsoakszjer1"] = "在昰里本官說已算",
  ["$tsoakszjer2"] = "昰个卻正是反詩汝若里得來",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tsoakszjer:addEffect(fk.TargetSpecifying, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target and target ~= player and player:hasSkill(tsoakszjer.name) and data.to ==player --and data.card.type==Card.TypeBasic --待改
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local cards=room:askToCards(target,{
      min_num=1,  --askToCard
      max_num=1,
      include_equip=true,
      pattern=".",
      prompt = "#tsoakszjer-choose:"..player.id,
      skill_name = tsoakszjer.name,
      cancelable = false,
    })
    room:moveCardTo(cards, Player.Hand, player, fk.ReasonGive, tsoakszjer.name, nil, true, player.id)
    if Fk:getCardById(cards[1]).type==Card.TypeBasic then 
      player:drawCards(1, tsoakszjer.name)
    else
      data:setNullified(player)
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
