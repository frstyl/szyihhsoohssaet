local muohbxis = fk.CreateSkill {
  name = "muohbxis",
  related_skills={"tsjecqkaap"},

}

Fk:loadTranslationTable {
  ["muohbxis"] = "武僃",
  [":muohbxis"] = "伱補段終旹,伱可將伱1手牌牌置入1脚色A裝僃欄(伱選)發動,A選擇➀抽x(x爲A裝僃區牌數)➁當輪擁有技能｢精甲｣",

  ["#muohbxis-invoke"] = "武僃：將伱1手牌置入1脚色裝僃區",

  ["$muohbxis1"] = "怀兼爱之心，琢世间百器。",
  ["$muohbxis2"] = "机巧用尽，方化腐朽为神奇！",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


muohbxis:addEffect(fk.EventPhaseEnd, {
  can_trigger = function(self, event, target, player, data)
    return target==player 
    and player:hasSkill("muohbxis") 
    and player.phase == Player.Draw
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local success, dat = room:askToUseActiveSkill(player, {
      skill_name = "muohbxis_active",
      prompt = "#muohbxis-invoke",
      cancelable = true,
      skip=true,
    })
    if success and dat then
      event:setCostData(self, {cards = dat.cards, tos=dat.targets, choice = dat.interaction})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local skill = Fk.skills["muohbxis_active"]
    skill:onUse(player.room, {
      from = player,
      tos = event:getCostData(self).tos,
      cards=event:getCostData(self).cards,
      interaction_data =event:getCostData(self).choice,
    })
  end,
})

return muohbxis
