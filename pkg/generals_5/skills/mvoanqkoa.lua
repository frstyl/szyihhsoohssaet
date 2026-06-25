local mvoanqkoa = fk.CreateSkill{
  name = "mvoanqkoa",
}


Fk:loadTranslationTable{
["mvoanqkoa"] = "曼歌",
[":mvoanqkoa"] = "末段始旹,伱可發動.伱判定,若与此流程內上次判定牌類別不同,伱可再次判定.流程終止旹,伱選擇令1角色抽x或回x/2",

["#mvoanqkoa-choose"] = "曼歌 選擇一角色 視爲對其使用殺",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

mvoanqkoa:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(mvoanqkoa.name) and player.phase == Player.Finish
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local cardtype={}
    local lastTyep=0
    while true do
      local judge = {
        who = player,
        reason = mvoanqkoa.name,
        pattern = ".|.|.",
      }
      room:judge(judge)

      local names=S.getCardTypeByName(S.getCardTypeByName(judge.card.name),true)
      names=table.concat(names,",")
      local judge2 = {
        who = player,
        reason = mvoanqkoa.name,
        pattern = ".|.|.|.|".."^"..names
      }
      room:judge(judge2)

      if  player.dead 
        or S.getCardTypeByName(judge.card.name ) ==S.getCardTypeByName(judge2.card.name )  --沁心 --需先手之 盾將
        or not room:askToSkillInvoke(player, { skill_name = mvoanqkoa.name }) then
        break
      end

    end

    if  player.dead then return end

  end,
})

return mvoanqkoa
