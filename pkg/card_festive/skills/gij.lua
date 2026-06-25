local cardSkill = fk.CreateSkill {
  name = "gij_skill",
}

Fk:loadTranslationTable{
  ["#gij-ask"] = "祈 令%dest %arg 判定 生效,中止此旹機",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt="#gij",
  can_use = Util.FalseFunc,  --不能主動旹用
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if  effect.from.dead then return end
    effect.from:drawCards(1,cardSkill.name)
  end,
})

-- cardSkill:addEffect(fk.AskForRetrial, {  --与技能同旹?--不屬使用 單純迻動
  -- priority = 2,  --与技能同旹?
--   global = true,
--   can_trigger = function(self, event, target, player, data)
--     return #table.filter(player:getCardIds("h"), 
--       function(id)
--         return Fk:getCardById(id).tureName == "gij"
--       end)>0
--   end,
--   on_trigger = function(self, event, target, player, data)
--     local room = player.room

--     local cards = room:askToCards(player, {
--       min_num = 1,
--       max_num = 1,
--       skill_name = "touh_ttwenh_seec_jje",
--       pattern = "gij",
--       prompt = "#touh_ttwenh_seec_jje::"..target.id..":"..data.reason,
--       cancelable = true,
--     })
--     if cards then
--     player.room:changeJudge{
--       card = Fk:getCardById(cards[1]),
--       player = player,
--       data = data,
--       skillName = "touh_ttwenh_seec_jje",
--       response = false,
--       exchange=true,
--     }
--     end
--   end,
-- })

cardSkill:addEffect(fk.AskForRetrial, {
  priority = 2,  --与技能同旹?
  global = true,
  can_trigger = function(self, event, target, player, data)
    if player~=target then return end
    local players=S.getHolders({"gij"})
    if  #players>0 then
      event:setCostData(self,{players=players})
      return true
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=target.room
    local params={
      skill_name = "gij_skill",
      pattern="gij",
      cancelable=true,
      prompt="#gij-ask::"..target.id..":"..data.reason,
      skip=true,
      extra_data = {
        gij = true,
      }
    }
  local use = room:askToNullification(event:getCostData(self).players, params)  --選上家再選下家?

    if use then
      use.toCard=data.card
      use.extra_data = use.extra_data or {}
      use.extra_data.gij = true    
      player.room:useCard(use)
      return true  --終止旹機 寫于何処?
    end
  end,
})

return cardSkill


