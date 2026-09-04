local khiochhsaak = fk.CreateSkill {
  name = "khiochhsaak",
}

Fk:loadTranslationTable{
["khiochhsaak"] = "恐嚇",
[":khiochhsaak"] = "➀當伱受傷後若伱武將牌明置,伱可發動,暗置此武將牌.➁一其它脚色A轉始旹,若伱武將牌暗置,伱可發動,伱明置武將牌,選擇一段令A越過",
["#khiochhsaak-invoke"] = "恐嚇: 選擇%src階段跳過",

--思路1 自限 將牌限定  --多个將牌有發動多次
--思路2 暗置全武將牌

    -- -- local phases={"預段","伏段","補段","主段","撤段","末段"}
    -- local phases={"準僃階段","占卜階段","抽牌階段","用牌階段","弃牌階段","結束階段"}
-- ["phase1"] = "預段",
-- ["phase2"] = "伏段",
-- ["phase3"] = "補段",
-- ["phase4"] = "主段",
-- ["phase5"] = "撤段",
-- ["phase6"] = "末段",
["khiochhsaak-cancel"] = "不嚇它",
}

local H = require "packages/hegemony/util"
local S = require "packages/szyihhsoohssaet/szyih_guos" 

khiochhsaak:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(khiochhsaak.name) 
    and (not player:isFakeSkill(self))  --同技能止1次  --發動後暗1个將 技能變爲fake 无論別將是否有同技能--符合規則
      -- player:getMark("@khiochhsaak") == 0
    -- and H.inGeneralSkills(player, khiochhsaak.name)~=nil  --會占卜爲主將起動

  end,
  on_use = function(self, event, target, player, data)
    -- player.room:addPlayerMark(player, "@khiochhsaak",1)

    H.hideBySkillName(player, khiochhsaak.name,true)

    -- if player.deputyGeneral and player.deputyGeneral ~= "" and player.deputyGeneral ~= "anjiang"  then player:hideGeneral(true) return end
    -- if player.general and player.general ~= ""  and  player.general ~= "anjiang" then player:hideGeneral() end
  end,
})

khiochhsaak:addEffect(fk.TurnStart, {
  can_trigger = function(self, event, target, player, data)
    return target~=player and player:hasSkill(khiochhsaak.name) 
    and player:isFakeSkill(khiochhsaak.name) --有喑將有此技能 --喑將是換將實現 失去技能再亮將不恢復技能
    -- and player:getMark("@khiochhsaak") ~= 0  -- ?=1
  end,
  on_cost = function(self, event, target, player, data)
    -- local phase={"預段","伏段","補段","主段","撤段","末段","不發動"}
    -- local choices={Player.Start, Card.Judge, Player.Draw, Player.Play, Player.Discard, Player.Finish,}

    local choices = {}
    for i = 2, 7, 1 do
      p=S.getPhaseString(i)  --Util.PhaseStrMapper(phase)
      table.insert(choices, p)
    end

    table.insert(choices,"khiochhsaak-cancel")
    local choice = player.room:askToChoice(player, {
      choices = choices,
      skill_name = khiochhsaak.name,
      prompt = "#khiochhsaak-invoke:"..target.id,
    })
    if choice=="khiochhsaak-cancel" then return end
    event:setCostData(self,{phase =  S.getPhaseClass(choice)})
    return true
    end,
  on_use = function(self, event, target, player, data) --發動技能自動量--有同技能?
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


return khiochhsaak
