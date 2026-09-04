local hzeepkoot = fk.CreateSkill {
  name = "hzeepkoot",
}

Fk:loadTranslationTable{
  ["hzeepkoot"] = "俠骨",
  [":hzeepkoot"] = "一其色受到傷害旹伱可打出1牌發動,若此傷害大于1減爲1否則-1｡若有傷源牌,伱取得之｡若打出牌不爲裝僃牌,伱選擇執行 流失1或此技能失效1轉｡",

  ["#hzeepkoot-invoke"]="俠骨 打出1脾 減少%src 所受傷害",
  ["#hzeepkoot-delay"]="俠骨 流失1 否則技能失效",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


hzeepkoot:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(hzeepkoot.name) 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local cards = S.askToPlayCard(player, {
		  min_num = 1,
		  max_num = 1,
		  include_equip = true,
		  skill_name = hzeepkoot.name,
		  cancelable = true,
      pattern = ".",
      prompt = "#hzeepkoot-invoke:"..data.to.id,
		  skip = true,
		})
    if #cards ~= 0 then
      event:setCostData(self, {cards = cards,tos={data.to}})
      return true
    end
  end,
  -- on_cost = function(self, event, target, player, data)
  --   local room = player.room
  --   local yes, ret = room:askToUseActiveSkill(player, {
  --     skill_name = "choose_cards_skill", 
  --     prompt = "#hzeepkoot-ask:"..data.to.id,
  --     cancelable = true, 
  --     extra_data = {
  --       num = 1,
  --       min_num = 0,
  --       include_equip = true,
  --       skillName = hzeepkoot.name,
  --       pattern = tostring(Exppattern{ id = table.filter(player:getCardIds("he"), function (id)
  --         local c= Fk:getCardById(id)
  --     return c.type == Card.TypeEquip and not player:prohibitResponse(c)
  --    end)}),
  --     }, 
  --     no_indicate = false,
  --     skip=true,
  --   })
  --   if yes then 
  --     event:setCostData(self, {tos={data.to},cards = ret.cards})
  --     return true
  --   end
  -- end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    S.playCard(event:getCostData(self).cards, hzeepkoot.name,player)
    S.changeDamage({damageData=data,num=(data.damage ==1 and -1 or 1-data.damage),skillName=hzeepkoot.name})
    if player.dead then return end

    if data.card and  player.room:getCardArea(data.card) == Card.Processing then
      player.room:obtainCard(player, data.card, true, fk.ReasonPrey, player, hzeepkoot.name)
    end
    if Fk:getCardById(event:getCostData(self).cards[1]).type==Card.TypeEquip then return end

    if player.room:askToSkillInvoke(player, {
        skill_name = hzeepkoot.name,
        prompt = "#hzeepkoot-delay",
        }) 
    then
      player.room:loseHp(player,1,hzeepkoot.name,player)
    else
      room:invalidateSkill(player,hzeepkoot.name,"-turn",hzeepkoot.name)
    end
  end,
})

return hzeepkoot
