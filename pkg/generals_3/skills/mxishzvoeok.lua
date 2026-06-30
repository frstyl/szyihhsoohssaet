local mxishzvoeok = fk.CreateSkill {
  name = "mxishzvoeok",
}

Fk:loadTranslationTable{
  ["mxishzvoeok"] = "魅惑",
  [":mxishzvoeok"] = "主旹,預打出1紅桃手牌指定1其它角色發動.若其已損回1,否則抽2,肰後伱執行相同效果",

  ["#mxishzvoeok-active"] = "魅惑 選擇1紅桃手牌与1其它角色",

  ["$mxishzvoeok1"] = "伱若有心,喫了我昰半盞㱚酒",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

mxishzvoeok:addEffect("active", {
  anim_type = "support",
  prompt = "#mxishzvoeok-active",
  max_phase_use_time = 1,
  card_filter = function(self, player, to_select, selected)
    return #selected ==0 
    and table.contains(player:getCardIds("h"),to_select)
    and Fk:getCardById(to_select).suit==Card.Heart 
    and not player:prohibitResponse(to_select)
  end,
  target_filter = function(self, player, to_select, selected)
    return #selected == 0 and to_select ~= player
  end,
  target_num = 1,
  card_num = 1,
  on_use = function(self, room, effect)
    local from = effect.from
    local target = effect.tos[1]
    room:throwCard(effect.cards, mxishzvoeok.name, from, from)

    if not target:isAlive() then return end
    if target:isWounded() then 
      room:recover({
        who = target,
        num = 1,
        recoverBy = from,
        skillName = mxishzvoeok.name,
      })
      if from:isAlive()  and from:isWounded()  then
        room:recover({
          who = from,
          num = 1,
          recoverBy = from,
          skillName = mxishzvoeok.name,
        })
      end
    else
      target:drawCards(2,mxishzvoeok.name)
      if from:isAlive()  then
        from:drawCards(2,mxishzvoeok.name)
      end
    end


  end,
})

return mxishzvoeok
