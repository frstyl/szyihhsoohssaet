local thouqhsiac = fk.CreateSkill {
  name = "thouqhsiac",
}

Fk:loadTranslationTable{
  ["thouqhsiac"] = "偸香",
  [":thouqhsiac"] = "任一角色使用牌被抵消或无效後旹,伱可選一項發動.➀回1➁抽1.執行後,,伱可選擇1其它存活女角色令其執行別一項",

  ["#thouqhsiac-choose"] = "偸香 選擇",
  ["thouqhsiac-draw"] = "抽1",
  ["thouqhsiac-recover"] = "回1",
  ["#thouqhsiac-choose-femal"] = "偸香 選擇1其它存活女角色,其%arg",
  ["#thouqhsiac-choose-femalthouqhsiac-draw"] = "偸香 選擇1其它存活女角色,其抽1",
  ["#thouqhsiac-choose-femalthouqhsiac-draw"] = "偸香 選擇1其它存活女角色,其回1",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec={
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(thouqhsiac.name)
    -- and table.contains({"buac_hzfan_mujs_nzjen","tsiac_keejs_dzius_keejs"},data.card.trueName)
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    local choices={"thouqhsiac-draw", "thouqhsiac-recover","Cancel"}

    local choice = player.room:askToChoice(player, {
      choices = choices,
      skill_name = thouqhsiac.name,
      prompt = "#thouqhsiac-choose",
    })
    if choice~="Cancel" then
      event:setCostData(self, {choice = choice,})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local choice=event:getCostData(self).choice
    local to =player
    if choice=="thouqhsiac-draw" then
      to:drawCards(1,thouqhsiac.name)
        choice = "thouqhsiac-recover" 
    else 
    player.room:recover{
        who = to,
        num = 1,
        card = nil,
        recoverBy = player,
        skillName = thouqhsiac.name,
      }
        choice = "thouqhsiac-draw" 
    end

    if player.dead then return end
      local targets=table.filter(player.room:getOtherPlayers(player),function(p)
      return p:isFemale()
      end)
      if #targets>0 then 
         local tos = room:askToChoosePlayers(player, {
          targets = targets,
          min_num = 1,
          max_num = 1,
          prompt = "#thouqhsiac-choose-femal"..choice,
          skill_name = thouqhsiac.name,
          cancelable = true,
        })
        if #tos>0 then 
          to =tos[1]
          if choice=="thouqhsiac-draw" then
            to:drawCards(1,thouqhsiac.name)
          else 
          player.room:recover{
              who = to,
              num = 1,
              card = nil,
              recoverBy = player,
              skillName = thouqhsiac.name,
            }
          end
        end
      end
  end,
}
thouqhsiac:addEffect(fk.CardEffectCancelledOut, {
  anim_type = "support",
  can_trigger=spec.can_trigger,
  on_cost=spec.on_cost,
  on_use=spec.on_use,

})
thouqhsiac:addEffect(S.AftereffectNullify, {
  anim_type = "support",
  can_trigger=spec.can_trigger,
  on_cost=spec.on_cost,
  on_use=spec.on_use,

})

return thouqhsiac
