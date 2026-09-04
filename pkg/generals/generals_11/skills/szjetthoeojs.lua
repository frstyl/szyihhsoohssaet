local szjetthoeojs = fk.CreateSkill {
  name = "szjetthoeojs",
}

Fk:loadTranslationTable{
  ["szjetthoeojs"] = "設貸",
  [":szjetthoeojs"] = "一其它脚色主段執行旹,伱可弃置a張牌發動.其抽a,1段內｢殺｣次數上限+1,段終旹,(若伱未死亾)其需交与伱2×a牌,若其牌不足,其流失差值", 
--殺次數?
  ["@@szjetthoeojs-phase"] = "設貸",
  ["#szjetthoeojs-invoke"] = "設貸 %src 主段 伱可弃置牌令其抽等量牌",
  ["#szjetthoeojs-choose"] = "設貸 交還 %src %arg牌",

  ["$szjetthoeojs1"] = "白銀在此將了去",  --
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

szjetthoeojs:addEffect(fk.EventPhaseProceeding, {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(szjetthoeojs.name) 
    and target~=player
    and target.phase==Player.Play
    end,
  on_cost = function(self, event, target, player, data)
    local cards= player.room:askToDiscard(player, {
        min_num = 1,
        max_num = 999,
        include_equip = true,
        skill_name = szjetthoeojs.name,
        cancelable = true,
        prompt = "#szjetthoeojs-invoke:"..target.id,
        skip = true
      })
    if #cards>0 then
      event:setCostData(self, {cards = cards,tos={target}})
      return true
    end

  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local cards=event:getCostData(self).cards
    local n=#cards
    -- S.playCard(event:getCostData(self).cards,szjetthoeojs.name,player)
	room:throwCards(cards, szjetthoeojs.name,target,player)
    target:drawCards(n,szjetthoeojs.name)
    local t=target:getTableMark("@@szjetthoeojs-phase") 
    t[player.id]=n
    room:setPlayerMark(target,"@@szjetthoeojs-phase",t)  --多家?
  end,
})

szjetthoeojs:addEffect(fk.EventPhaseEnd, {
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return target:getTableMark("@@szjetthoeojs-phase")[player.id] 
  end,
  on_trigger=function(self, event, target, player, data)
    local room=player.room
    local n =2* target:getTableMark("@@szjetthoeojs-phase")[player.id] 
    local cards = room:askToCards(target, {
        min_num = n,
        max_num = n,
        include_equip = true,
        prompt = "#szjetthoeojs-choose:"..player.id.."::"..n,
        skill_name = szjetthoeojs.name,
        cancelable = false,
      })
      local m=n - #cards
    room:moveCardTo(cards, Player.Hand, player , fk.ReasonGive, szjetthoeojs.name, nil, false, target)
    if m>0 then 
      room:loseHp(target,m,szjetthoeojs.name,player)
    end
  end,
})

szjetthoeojs:addEffect("targetmod", {
  residue_func = function (self, player, skill, scope, card, to)
    if #player:getTableMark("@@szjetthoeojs-phase")>0 and card and card.trueName == "ssaet" and scope == Player.HistoryPhase then
        return player:getTableMark("@@szjetthoeojs-phase") 
    end
  end,
})

return szjetthoeojs
