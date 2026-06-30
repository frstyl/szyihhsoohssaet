local ddiachszjer = fk.CreateSkill {
  name = "ddiachszjer",
}

Fk:loadTranslationTable{
  ["ddiachszjer"] = "仗勢",
  [":ddiachszjer"] = "伱受到傷害旹,若有傷源且不爲伱,伱可選1角色非伱或傷源發動.其可對傷源使用1牌,若其使用牌且此牌致傷,防止伱所受傷害,否則伱可令其弃1手牌",

  ["#ddiachszjer-invoke"] = "仗勢：選擇1角色 令其對 %src 選擇牌",
  ["#ddiachszjer-use"] = "仗勢：对 %dest 使用牌，若致傷防止 %src所受傷害",
  ["#ddiachszjer-loseHp"] = "仗勢：是否令 %dest 失去1点体力？",

  ["$ddiachszjer1"] = "家父被那黑厮打的，呜呜呜~",
  ["$ddiachszjer2"] = "将军~您可要为奴家做主~",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

ddiachszjer:addEffect(fk.DamageInflicted, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ddiachszjer.name)
    and data.from and data.from~=player
  end,
  on_cost = function (self, event, target, player, data)
    local to = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = table.filter(player.room:getOtherPlayers(player),function(p)
      return p~=data.from
      end),
      skill_name = ddiachszjer.name,
      prompt = "#ddiachszjer-invoke:"..data.from.id,
      cancelable = true,
    })
    if #to>0 then 
      event:setCostData(self,{tos=to})  --寫于此?
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local to = event:getCostData(self).tos[1]
    local use = room:askToUseCard(to, {
      pattern = "ssaet",
      skill_name = ddiachszjer.name,
      prompt = "#ddiachszjer-use:"..player.id..":"..data.from.id,
      cancelable = true,
      extra_data = {
        exclusive_targets = {data.from.id},
        bypass_times = true,
        extraUse = true,
      },
      skip=false,
    })
    if use then
      room:useCard(use)
      end
    if  use and use.damageDealt then
      S.preventDamage({damageData=data,skillName=ddiachszjer.name})
    else
    if player.dead then return end
        local cards = room:askToDiscard(to, {
          min_num = 1,
          max_num = 1,
          include_equip = false,
          skill_name = ddiachszjer.name,
          prompt = "#ddiachszjer-discard",
          cancelable = false,
          skip = false,
        })
    end
  end,
})

return ddiachszjer
