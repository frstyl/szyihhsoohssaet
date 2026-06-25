local khiochhsaas = fk.CreateSkill {
  name = "khiochhsaas",
}

Fk:loadTranslationTable{
["khiochhsaas"] = "恐嚇",
[":khiochhsaas"] = "➀當伱受傷後若伱武將牌明置,伱可發動,暗置此武將牌.➁一其他角色A轉始旹,若伱武將牌暗置,伱可發動,伱明置武將牌,選擇一段令A越過",
["#khiochhsaas-invoke"] = "恐嚇: 選擇%src階段跳過",

    -- -- local phases={"預段","伏段","補段","主段","撤段","末段"}
    -- local phases={"準僃階段","判定階段","抽牌階段","用牌階段","弃牌階段","結束階段"}
-- ["phase1"] = "預段",
-- ["phase2"] = "伏段",
-- ["phase3"] = "補段",
-- ["phase4"] = "主段",
-- ["phase5"] = "撤段",
-- ["phase6"] = "末段",
["khiochhsaas-cancel"] = "不嚇它",
}
local H = require "packages/hegemony/util"

local S = require "packages/szyihhsoohssaet/szyih_guos" 

khiochhsaas:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(khiochhsaas.name) 
    and (not player:isFakeSkill(self))  -- player:getMark("@khiochhsaas") == 0
  end,
  on_use = function(self, event, target, player, data)
    -- player.room:addPlayerMark(player, "@khiochhsaas",1)
    if not H.hasGeneral(player, true) then
    player:hideGeneral()
    else
    H.hideBySkillName(player, khiochhsaas.name) --    player:hideGeneral(isDeputy == "d") --判定技能源武將牌?
    end
    
  end,
})

khiochhsaas:addEffect(fk.TurnStart, {
  can_trigger = function(self, event, target, player, data)
    return target~=player and player:hasSkill(khiochhsaas.name) 
    and player:isFakeSkill(khiochhsaas.name) 
    -- and player:getMark("@khiochhsaas") ~= 0  -- ?=1
  end,
  on_cost = function(self, event, target, player, data)
    -- local phase={"預段","伏段","補段","主段","撤段","末段","不發動"}
    -- local choices={Player.Start, Card.Judge, Player.Draw, Player.Play, Player.Discard, Player.Finish,}

    local choices = {}
    for i = 2, 7, 1 do
      p=S.getPhaseString(i)  --Util.PhaseStrMapper(phase)
      table.insert(choices, p)
    end

    table.insert(choices,"khiochhsaas-cancel")
    local choice = player.room:askToChoice(player, {
      choices = choices,
      skill_name = khiochhsaas.name,
      prompt = "#khiochhsaas-invoke:"..target.id,
    })
    if choice=="khiochhsaas-cancel" then return end
    event:setCostData(self,{phase =  S.getPhaseClass(choice)})
    return true
    end,
  on_use = function(self, event, target, player, data)
    local phase = event:getCostData(self).phase
    -- target:skip(phase)  --跳過階段 旹機 在實際跳過旹生成
    S.skipPhase(target.id , phase)
  end,
  })
--語音
  -- before_use = function (self, player, use)
  --   local room = player.room
  --   if use.card.trueName == "buac_hzfan_mujs_nzjen" then
  --     player:broadcastSkillInvoke(longhun.name, 1)
  --     room:notifySkillInvoked(player, longhun.name, "control")
  --   elseif use.card.trueName == "szjemh" then
  --     player:broadcastSkillInvoke(longhun.name, 2)
  --     room:notifySkillInvoked(player, longhun.name, "defensive")
  --   elseif use.card.trueName == "nziuk" then
  --     player:broadcastSkillInvoke(longhun.name, 3)
  --     room:notifySkillInvoked(player, longhun.name, "support")
  --   elseif use.card.trueName == "ssaet" then
  --     player:broadcastSkillInvoke(longhun.name, 4)
  --     room:notifySkillInvoked(player, longhun.name, "offensive")
  --   end
  -- end,


return khiochhsaas
