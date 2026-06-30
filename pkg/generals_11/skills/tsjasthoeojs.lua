local tsjasthoeojs = fk.CreateSkill {
  name = "tsjasthoeojs",
}

Fk:loadTranslationTable{
  ["tsjasthoeojs"] = "借貸",
  [":tsjasthoeojs"] = "一其它角色主段始旹,伱可預弃a牌發動.其抽a,此段殺可用次數+1,此段終旹,(若伱未死亾)其需交与伱2×a牌,若其牌不足,其流失差值體力", 
--殺次數?
  ["@@tsjasthoeojs-phase"] = "借貸",
  ["#tsjasthoeojs-invoke"] = "借貸 %src 主段始 伱可弃牌令其抽等量牌",
  ["#tsjasthoeojs-choose"] = "借貸 交還 %src %arg牌",

  ["$tsjasthoeojs1"] = "白銀在此將了去",  --
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tsjasthoeojs:addEffect(fk.EventPhaseStart, {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(tsjasthoeojs.name) and target~=player
    and target.phase==Player.Play
    end,
  on_cost = function(self, event, target, player, data)
    local cards= S.askToPlayCard(player, {
        min_num = 1,
        max_num = 999,
        include_equip = true,
        skill_name = tsjasthoeojs.name,
        cancelable = true,
        prompt = "#tsjasthoeojs-invoke:"..target.id,
        skip = true
      })
    if #cards>0 then
      event:setCostData(self, {cards = cards,})
      return true
    end

  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local cards=event:getCostData(self).cards
    local n=#cards
    S.playCard(player,event:getCostData(self).cards,tsjasthoeojs.name)
    target:drawCards(n,tsjasthoeojs.name)
    local t=target:getTableMark("@@tsjasthoeojs-phase") 
    t[player.id]=n
    room:setPlayerMark(target,"@@tsjasthoeojs-phase",t)  --多家?
  end,
})

tsjasthoeojs:addEffect(fk.EventPhaseEnd, {
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return target:getTableMark("@@tsjasthoeojs-phase")[player.id] 
  end,
  on_trigger=function(self, event, target, player, data)
    local room=player.room
    local n =2* target:getTableMark("@@tsjasthoeojs-phase")[player.id] 
    local cards = room:askToCards(target, {
        min_num = n,
        max_num = n,
        include_equip = true,
        prompt = "#tsjasthoeojs-choose:"..player.id.."::"..n,
        skill_name = tsjasthoeojs.name,
        cancelable = false,
      })
      local m=n - #cards
    room:moveCardTo(cards, Player.Hand, player , fk.ReasonGive, tsjasthoeojs.name, nil, false, target)
    if m>0 then 
      room:loseHp(target,m,tsjasthoeojs.name,player)
    end
  end,
})

tsjasthoeojs:addEffect("targetmod", {
  residue_func = function (self, player, skill, scope, card, to)
    if #player:getTableMark("@@tsjasthoeojs-phase")>0 and card and card.trueName == "ssaet" and scope == Player.HistoryPhase then
        return player:getTableMark("@@tsjasthoeojs-phase") 
    end
  end,
})

return tsjasthoeojs
