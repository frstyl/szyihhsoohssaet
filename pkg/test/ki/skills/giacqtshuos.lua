local giacqtshuos = fk.CreateSkill {
  name = "giacqtshuos",
}

Fk:loadTranslationTable{
  ["giacqtshuos"] = "擊銳",
  [":giacqtshuos"] = "伱起動｢殺｣對目幖腳色致傷後,(若其存活),伱可發動,伱防止傷害,取得其1牌,伱令伱回1,其回1",

  ["#giacqtshuos-invoke"] = "擊銳 是否對 %src 發動 0牌确定則其弃牌",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

giacqtshuos:addEffect(fk.Damaged, {  --
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  data.from==player and player:hasSkill(giacqtshuos.name) 
    and data.to~=player
    and not data.to.dead 
    and data.card.trueName
    and data.card.trueName=="ssaet"
    and data.by_user
  end,
  on_use = function(self, event, target, player, data)
    S.preventDamage({damageData=data,skillName=giacqtshuos.name})

    if not data.to:isNude() then
      local cid = room:askToChooseCard(player, { target = data.to, flag = "he", skill_name = giacqtshuos.name })
      room:obtainCard(player, cid, false, fk.ReasonPrey, player, giacqtshuos.name)
    end
    if not player.dead and player:isWounded() then
        room:recover{
          who = player,
          num = 1,
          recoverBy = player,
          skillName = sjiqkius.name,
        }
    end
    if not data.to.dead and data.to:isWounded() then

          room:recover{
        who = to,
        num = 1,
        recoverBy = player,
        skillName = sjiqkius.name,
      }
    end
  end,
})


return giacqtshuos
