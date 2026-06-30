local cxesljet = fk.CreateSkill {
  name = "cxesljet",
}

Fk:loadTranslationTable{
["cxesljet"] = "義烈",
[":cxesljet"] = "當伱攻程內1角色成爲非伱所使用<a href='AttackCard'>進攻牌</a>目幖旹,伱流失1體力發動,伱迻除此目幖,肰後伱可弃使用者1牌",
["#cxesljet-invoke"]="義烈 流失1體力  迻除 %src 所用 %arg 目幖 %dest ",
["#cxesljet-discard"]="義烈 弃%src 1牌 ",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

cxesljet:addEffect(fk.TargetConfirming, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return  
    (player:inMyAttackRange(target) or target==player)
    and player:hasSkill(cxesljet.name) 
    and S.isAttackCard(data.card)  
    and  data.from ~= player 
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room
    if room:askToSkillInvoke(player, {
      skill_name = cxesljet.name,
      prompt = "#cxesljet-invoke:"..data.from.id..":"..target.id..":"..data.card:toLogString(),
    }) then
      event:setCostData(self, {tos = {data.from}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:loseHp(player, 1, cxesljet.name,player)
    data:cancelTarget(target)

    if data.from.dead or data.from:isNude() or  player.dead then return end
    if room:askToSkillInvoke(player, {
      skill_name = cxesljet.name,
      prompt = "#cxesljet-discard:"..data.from.id,
    }) then
      local id = room:askToChooseCard(player, {
        target = data.from,
        flag = "he",
        skill_name = cxesljet.name,
      })  --肰後伱可弃使用者1牌
      room:throwCard(id, cxesljet.name, data.from, player)
    end
    
  end,
})

return cxesljet
