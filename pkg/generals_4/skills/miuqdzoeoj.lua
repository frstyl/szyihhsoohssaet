local miuqdzoeoj = fk.CreateSkill {
  name = "miuqdzoeoj",
}

Fk:loadTranslationTable{
["miuqdzoeoj"] = "謀財",
[":miuqdzoeoj"] = "當其它角色受傷旹,若其手牌數不小于伱體力值,伱可發動｡伱獲取其1手牌.",

["#miuqdzoeoj-invoke"] = "謀財 獲取 %src 手牌",
}

miuqdzoeoj:addEffect(fk.DamageInflicted, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return (target ~= player) and player:hasSkill(miuqdzoeoj.name)
    and not target:isKongcheng()
      -- and target:getHandcardNum()>0 
    and target:getHandcardNum()>=player.hp
  end,
  on_cost = function(self, event, target, player, data)
    if player.room:askToSkillInvoke(player, {
      skill_name = miuqdzoeoj.name,
      prompt = "#miuqdzoeoj-invoke:"..target.id,
    }) 
    then
      event:setCostData(self, {tos = {target}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)

        if target.dead or player.dead or target:isKongcheng() then return end
        local cid = player.room:askToChooseCard(player, { 
          target = target, 
          flag = "h", 
          skill_name = miuqdzoeoj.name, 
        })
        player.room:obtainCard(player, cid, false, fk.ReasonPrey, player, miuqdzoeoj.name,nil,nil)

  end,
})




return miuqdzoeoj
