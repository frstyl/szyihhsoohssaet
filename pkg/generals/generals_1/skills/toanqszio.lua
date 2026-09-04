local toanqszio = fk.CreateSkill {
  name = "toanqszio",
  tags = {Skill.Compulsory},
}

Fk:loadTranslationTable{
  ["toanqszio"] = "丹書",
  [":toanqszio"] = "伱成为｢殺｣目幖後必發,起動者執行1項：➀弃置x手牌；➁此起動對伱无效。(x爲伱已損體力數至少爲1)",

  ["#toanqszio-discard"] = "丹書：打出 %arg ，或此殺對 %src 无效",

  ["$toanqszio1"] = "丹書鐵卷在此,誰敢不敬。",
  ["$toanqszio2"] = "御賜丹書鐵卷,可保祖孫三代",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

toanqszio:addEffect(fk.TargetConfirmed, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(toanqszio.name) and data.card.trueName == "ssaet"
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
          return  not 
          -- from:prohibitResponse(Fk:getCardById(id))
          from:prohibitDiscard(Fk:getCardById(id))
        end
        ) }),
        prompt = "#toanqszio-discard:"..player.id.."::"..n,
        cancelable = true,
      })
    if #cards==n then
      toom:throwCard(cards,toanqszio.name,from,from)
      -- S.playCard(cards,toanqszio.name,from)
    else
      S.effectNullify(data,player,toanqszio.name, true)
    end
  end,
})

return toanqszio
