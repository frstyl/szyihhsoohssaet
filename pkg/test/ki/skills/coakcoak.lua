local coakcoak = fk.CreateSkill {
  name = "coakcoak",
}

Fk:loadTranslationTable{
  ["coakcoak"] = "諤諤",
  [":coakcoak"] = "伱主段始旹,伱可選1其它腳色區域內有牌者發動,伱弃置其1｡一其它腳色抵消牌後,伱可對其發動", 

  ["#coakcoak-invoke"] = "諤諤 弃 %dest 區域內牌 ",
  ["#coakcoak-choose"] = "諤諤 弃1腳色區域內牌 ",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec={
  on_use = function(self, event, target, player, data)
    local to =event:getCostData(self).tos[1]
    local cid = room:askToChooseCard(player, { target = to, flag = "hej", skill_name = coakcoak.name })
    room:throwCard({cid}, coakcoak.name, to, player)
  end,
}

coakcoak:addEffect(fk.CardEffectCancelledOut, {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(coakcoak.name) 
    and data.to~=player 
    and not data.to:isAllNude()
  end,
  on_cost = function(self, event, target, player, data)
    if player.room:askToSkillInvoke(player, { skill_name = coakcoak.name,prompt="#coakcoak-invoke::"..data.to.id }) then
      event:setCostData(self,{tos={data.to}})
      return true
    end
  end,
  on_use = spec.on_use,

})

coakcoak:addEffect(fk.EventPhaseStart, {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(coakcoak.name) and target==player
    and data.phase==Player.Play
  end,
  on_cost = function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      targets = table.filter(player.room.alive_players,function(p)
        return p~=player and not p:isAllNude()
      end),
      min_num = 1,
      max_num = 1,
      prompt = "#coakcoak-choose",
      skill_name = coakcoak.name,
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, { tos = tos })
      return true
    end
  end,
  on_use = spec.on_use,
})
return coakcoak
