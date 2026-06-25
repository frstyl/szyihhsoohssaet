local toanqszio = fk.CreateSkill {
  name = "toanqszio",
  tags = {Skill.Compulsory},
}

Fk:loadTranslationTable{
  ["toanqszio"] = "丹書",
  [":toanqszio"] = "鎖定｡伱成为｢殺｣目幖後必發，殺使用者執行1項：➀實打出x手牌；➁此｢殺｣對伱无效。(x爲伱已損體力值至少爲1)",

  ["#toanqszio-discard"] = "丹書：打出 %arg ，或此殺對 %src 无效",

  ["$toanqszio1"] = "丹書鐵卷在此,誰敢不敬。",
  ["$toanqszio2"] = "御賜丹書鐵卷,可保祖孫三代",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

toanqszio:addEffect(fk.TargetConfirmed, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(toanqszio.name) and data.card.trueName == "ssaet"
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local from =data.from
    local n= math.max(player:getLostHp(),1)
    local cards=player.room:askToCards(data.from,{
        min_num=n,
        max_num=n,
        include_equip=false,
        pattern=tostring(Exppattern{ id = table.filter(from:getCardIds("h"),function(id)
          return  not from:prohibitResponse(Fk:getCardById(id))
        end
        ) }),
        prompt = "#toanqszio-discard:"..player.id.."::"..n,
        cancelable = true,
      })
    if #cards==n then
      S.playCard(from,cards,toanqszio.name)
    else
      S.effectNullify(data,player,toanqszio.name)
    end
  end,
})

return toanqszio
