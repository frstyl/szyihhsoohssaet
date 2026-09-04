local keekhsio = fk.CreateSkill {
  name = "keekhsio",
}

Fk:loadTranslationTable{
  ["keekhsio"] = "擊虛",
  [":keekhsio"] = "其它脚色A起｢閃｣旹,伱可對A起動｢殺｣發動｡(起動前)A選擇此閃无效或驚䰟(體力視爲0結算瀕死)",  --攻程

  ["#keekhsio-use"] = "擊虛 對%src起動埋伏",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

keekhsio:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from ~= player and player:hasSkill(keekhsio.name) 
    and data.card.trueName=="szjemh"
  end,
  on_cost = function(self, event, target, player, data)
    local use = player.room:askToUseCard(player, {
      name = "mae_biuk",
      skill_name = keekhsio.name,
      prompt = "#keekhsio-use:"..target.id,
      cancelable = true,
      pattern="ssaet",
      extra_data = {
        must_targets = {data.from.id},
        -- exclusive_targets = {data.to.id},
        -- bypass_distances = true,
        -- bypass_times = true,
      },
      skip = true,
    })
    if use then
      event:setCostData(self, { extra_data = use })
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    if  player.room:askToSkillInvoke(player, { skill_name ="kracqhzoon" }) then
      local n = player.hp
      room:sendLog{
        type = "#StartKracqhzoon",
        from = player.id,
      }
      player.hp=0
      local dyingDataSpec = {
          who = player,
          damage = nil,
          killer = nil,
          hpLost = nil,
        }
      room:enterDying(dyingDataSpec)
      if player:isAlive() then player.hp=n end
      room:sendLog{
        type = "#EndKracqhzoon",
        from = player.id,
      }
    else
      S.useNullify(data,player,keekhsio.name)
    end
    if data.to.dead then return end
    player.room:useCard(event:getCostData(self).extra_data)
  end,
})


return keekhsio
