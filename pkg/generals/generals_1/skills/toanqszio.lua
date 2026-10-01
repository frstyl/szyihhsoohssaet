local toanqszio = fk.CreateSkill {
  name = "toanqszio",
  tags = {Skill.Compulsory},
}

Fk:loadTranslationTable{
  ["toanqszio"] = "丹書",
  [":toanqszio"] = "伱成为｢殺｣目幖後必發,起動者選擇執行1項：➀弃置x手牌；➁迻除目幖。(x爲伱已損體力數至少爲1)｡➁伱體力上限視爲与冣大者同",

  ["#toanqszio-discard"] = "丹書：投出 %arg ，或此殺對 %src 无效",

  ["$toanqszio1"] = "丹書鐵卷在此,誰敢不敬。",
  ["$toanqszio2"] = "御賜丹書鐵卷,可保祖孫三代",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

toanqszio:addAcquireEffect(function (self, player)
  player.room:setPlayerMark(player,"toanszio-maxHp",player.maxHp)
  local n =player.maxHp
  for _,p in ipairs(player.room.alive_players) do
    if p.maxHp>n then 
      n=p.maxHp
    end
  end
    if n >player.maxHp then
      player.maxHp=n
      -- player.room:broadcastProperty(player, "hp")
      player.room:setPlayerProperty(player, "maxHp", n)
    end
end)

toanqszio:addLoseEffect (function (self, player)
  local n  =player:getMark(r,"toanszio-maxHp")
    player.maxHp = n
    room:broadcastProperty(player, "hp")
    room:setPlayerProperty(player, "maxHp", n)
end)

toanqszio:addEffect(fk.MaxHpChanged, {
  anim_type = "defensive",
  can_refresh = function(self, event, target, player, data)
    return data.who ~= player  and player:hasSkill(toanqszio.name,true)
  end,
  on_refresh = function(self, event, target, player, data)
    local n =0

    for _,p in ipairs(player.room:getOtherPlayers(player)) do
      if p.maxHp>n then 
        n=p.maxHp
      end
    end
    n =math.max(player:getMark("toanszio-maxHp"), n) 
    if n ~=player.maxHp then
      player.maxHp=n
      -- player.room:broadcastProperty(player, "hp")
      player.room:setPlayerProperty(player, "maxHp", n)
    end
  end,
})

toanqszio:addEffect(fk.BeforeMaxHpChanged, {
  anim_type = "defensive",
  can_refresh = function(self, event, target, player, data)
    return data.who == player and player:hasSkill(toanqszio.name,true)
  end,
  on_refresh = function(self, event, target, player, data)
    data.prevented=true
    player.room.logic:breakEvent()
  end,
})

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
      -- S.effectNullify(data,player,toanqszio.name, true)
      data:cancelCurrentTarget()
    end
  end,
})

return toanqszio
