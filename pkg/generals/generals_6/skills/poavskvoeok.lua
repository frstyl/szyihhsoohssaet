local poavskvoeok = fk.CreateSkill {
  name = "poavskvoeok",
  tags = {Skill.Composite},
}

Fk:loadTranslationTable{
["poavskvoeok"] = "報國",
[":poavskvoeok"] = "➀應動｡一其它脚色受傷害旹,若其體力不大于(伱體力值或傷害值),伱可發動,將此傷害轉于伱➁伱受傷後可發動,伱抽x(x爲伱已損體力數)",

["#poavskvoeok-invoke"]="報國 將 %src 所受傷害轉于伱",
-- ["#poavskvoeok-choose"]="報國 投出 %arg 手牌將  %src 傷害轉予伱",
-- ["#poavskvoeok-draw"]="報國 抽 %arg",

["$poavskvoeok1"] = "大丈夫爲國䀆忠 死而无憾",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- poavskvoeok:addAcquireEffect(function (self, player)
--     player:addSkill("#poavskvoeok_draw") 
-- end)

-- poavskvoeok:addLoseEffect (function (self, player)
--     player:loseSkill("#poavskvoeok_draw") 
-- end)




poavskvoeok:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return (data.to ~= player) 
    and player:hasSkill(poavskvoeok.name) 
    and (data.to.hp <=player.hp or data.to.hp <=data.damage )
  end,
  on_cost = function(self, event, target, player, data)
      if 
          player.room:askToSkillInvoke(player, {
          skill_name = poavskvoeok.name,
          prompt = "#poavskvoeok-invoke:"..data.to.id,
        }) 
      then
        event:setCostData(self,{tos={data.to}})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    data.extra_data=data.extra_data or {}
    -- data.extra_data.poavskvoeok==player.id
    data.extra_data.origin_to=data.extra_data.origin_to or data.to
    data.to=player
    -- return true

  end,
})


-- poavskvoeok:addEffect(fk.Damaged, {
--   anim_type = "masochism",
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(poavskvoeok.name) 
--   end,
--   on_cost= function(self, event, target, player, data)
--      return 
--      player.room:askToSkillInvoke(player, {
--       skill_name = poavskvoeok.name,
--       prompt = "#poavskvoeok-draw:::"..player:getLostHp()
--     }) 
--   end,
--   on_use = function(self, event, target, player, data)
--     player:drawCards(player:getLostHp(), poavskvoeok.name)
--   end,
-- })

return poavskvoeok
