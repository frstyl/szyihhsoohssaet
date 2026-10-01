local syenqhquj = fk.CreateSkill {
  name = "syenqhquj",
}

Fk:loadTranslationTable{
  ["syenqhquj"] = "宣威",
  [":syenqhquj"] = "伱對其它脚色致傷後,若其有牌,伱可發動,伱選擇其1至傷害值牌置于伱將牌上,轉終,伱廢除宣威牌,抽等量牌",

  ["#syenqhquj-invoke"] = "除外 %dest %arg牌",
  ["syenqhquj-hquj"] = "宣威",

}

syenqhquj:addEffect(fk.Damaged, {
  -- name="#syenqhquj_main_skill",
  can_trigger = function(self, event, target, player, data)
    if  data.from == player and player:hasSkill(syenqhquj.name) and not data.to:isNude() and data.damage>0
	  then
      return true
    end
  end,
  on_cost = function(self, event, target, player, data)

    if player.room:askToSkillInvoke(player, { skill_name = syenqhquj.name,prompt="#syenqhquj-invoe::"..data.to..":::"..data.damage })  then
      event:setCostData(self, {tos={data.to}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)

      local to=event:getCostData(self).tos[1]
      local cards = player.room:askToChooseCards(player, {
         target = data.to,
        flag = "he", 
        skill_name = syenqhquj.name,
        min=1,
        max=data.damage,
        cancelable=false,
       })
      player:addToPile("syenqhquj_hquj", cards, true, syenqhquj.name) 

  end,
  }   
) --

syenqhquj:addEffect(fk.TurnEnd, {
  can_trigger = function(self, event, target, player, data)
    return 
      #player:getPile("syenqhquj_hquj") >0
  end,
  on_trigger = function(self, event, target, player, data)
    local n = #player:getPile("syenqhquj_hquj")
    player.room:moveCardTo(player:getPile("syenqhquj_hquj"), Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, syenqhquj.name, nil, true, player)
    if not player.dead then
      player:drawCards(n,syenqhquj.name)
    end
  end,
})
return syenqhquj
