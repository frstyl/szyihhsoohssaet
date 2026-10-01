local dzjecqdook = fk.CreateSkill{
  name = "dzjecqdook",
  -- tags = { Skill.Compulsory },
  related_skills={"tsziukzzyit_tthxinsdook"},

}

Fk:loadTranslationTable{
  ["dzjecqdook"] = "情毒",
  [":dzjecqdook"] = "伱其它脚色致傷後,伱可發動｡伱弃置其1牌,爲其附加咒術｢疢毒｣(已有則執行)",

  ["#dzjecqdook-invoke"] = "情毒 是否對 %src發動",

  ["$dzjecqdook1"] = "我欲行夏禹旧事，为天下人。",

}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

dzjecqdook:addEffect(fk.Damaged, {
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    return data.from==player and player:hasSkill(dzjecqdook.name) and not data.to.dead 
  end,
  on_cost = function (self, event, target, player, data)
    if player.room:askToSkillInvoke(player, {
      skill_name = dzjecqdook.name,
      prompt = "#dzjecqdook-invoke:"..data.to.id,
    }) then
      event:setCostData(self,{tos={data.to}})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    if player.dead or data.to.dead or data.to:isAllNude() then return end
    local cid = room:askToChooseCard(player, { target = data.to, flag = "he", skill_name = dzjecqdook.name })
    room:throwCard({cid}, dzjecqdook.name, data.to, player)
    if data.to.dead then return end
    if not  S.hasTsziukzzyit(data.to,"tthxinsdook") then
      S.addTsziukzzyitBuff(data.to,  "tthxinsdook",player)
    else
      player.room:throwCard(room:tableRandomPick(player:getCardIds("h"),1), "tsziukzzyit_tthxinsdook",data.to,data.to)
    end
  end,
})



return dzjecqdook
