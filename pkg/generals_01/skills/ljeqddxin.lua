Fk:loadTranslationTable{
  ["ljeqddxin"] = "離塵",
  [":ljeqddxin"] = "額度抽牌旹,若x大于0,伱可發動,此次抽牌數+x,若x>2,伱令一其它角色予伱1傷(x爲全場有附有昏睡者)",


  ["#ljeqddxin-invoke"] = "離塵 額外抽 %arg",
  ["#ljeqddxin-choose"] = "離塵 額外抽 %arg 令一角色予伱一傷",

  ["$ljeqddxin1"] = "哈哈哈哈哈哈哈哈！",
  ["$ljeqddxin2"] = "伯符，且看我这一手！",
}

local ljeqddxin = fk.CreateSkill{
  name = "ljeqddxin",
  -- tags = { Skill.Compulsory },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

ljeqddxin:addEffect(fk.DrawNCards, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
  if not (player==target and player:hasSkill(ljeqddxin.name)) then return end
    local n=0
    for _, p in ipairs(player.room.alive_players) do
      if S.hasTsziukzzyit(p,"hsoondzzyes") then n = n+1 end
    end
    if n>0 then
      event:setCostData(self,{n=n})
      return true
    end
  end,
  on_cost = function(self, event, target, player, data)
    local n = event:getCostData(self).n
    local tos={}
    if n>2 then
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = player.room:getOtherPlayers(player),
      skill_name = ljeqddxin.name,
      prompt = "#ljeqddxin-choose:::"..n,
      cancelable = true,
    })
      if #tos > 0 then
        event:setCostData(self, {n=n ,tos = tos})
        return true
      end
    else
      return player.room:askToSkillInvoke(player, { skill_name = ljeqddxin.name ,prompt="#ljeqddxin-invoke:::"..n,}) 
    end
  end,
  on_use = function(self, event, target, player, data)
    data.n = data.n + event:getCostData(self).n
    if player.dead then return end
    if event:getCostData(self).tos then 
        player.room:damage{
          from = event:getCostData(self).tos[1],
          to = player,
          damage = 1,
          skillName = ljeqddxin.name,
        }
      end
  end,
})


return ljeqddxin
