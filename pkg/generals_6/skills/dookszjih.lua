local dookszjih = fk.CreateSkill {
  name = "dookszjih",
}

Fk:loadTranslationTable{
  ["dookszjih"] = "毒矢",  --毒💩️
  [":dookszjih"] = "當伱使用殺對目幖角色致傷旹,伱可➀預打出1手牌發動,爲目幖附加毒.➁發動,此傷-1,目幖角色牢+1",

  ["#dookszjih-invoke"] = "毒矢 打出0至1手牌對 %src 發動",

  -- ["dook"] = "毒",  --技能
  -- ["@@dook"] = "毒",  --幖記
  -- ["@@antirecover-turn"] = "回復无效",
  -- ["#PreventRecoverBySkill"] = "由于 %arg 的效果，%from 受到回復被防止",

  ["$dookszjih1"] = "明搶易躲毒矢難防",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 

dookszjih:addEffect(fk.DamageCaused, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  target==player and player:hasSkill(dookszjih.name)
    and  data.card and data.card.trueName == "ssaet"
    and  data.by_user  --?
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local yes, ret = room:askToUseActiveSkill(player, {
      skill_name = "choose_cards_skill", 
      prompt = "#dookszjih-invoke:"..data.to.id, 
      cancelable = true, 
      extra_data = {
        num = 1,
        min_num = 0,
        include_equip = false,
        skillName = dookszjih.name,
        pattern = tostring(Exppattern{ id = table.filter(player:getHandlyIds(), function (id)
      return not player:prohibitResponse(Fk:getCardById(id))
     end)}),
      }, 
      no_indicate = false,
      skip=true,

    })
    if yes then 
      event:setCostData(self, {tos={data.to},cards = ret.cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    if  #event:getCostData(self).cards ==0 then

      S.changeDamage({damageData=data,num=data.damage ==-1,skillName=dookszjih.name})
        -- data:changeDamage(-1)
      player.room:addPlayerMark(data.to,"@loav",1)
    elseif #event:getCostData(self).cards ==1 then
      room:responseCard({
          card=Fk:getCardById(cards[1]),
          from=player,
          attachedSkillAndUser={muteCard=true},
        })
      player.room:setPlayerMark(data.to,"@@dook",1)
      room:addSkill("dook_rule")
    end
  end,
})

-- dookszjih:addEffect(fk.TurnStart, {
--   is_delay_effect=true,
--   can_trigger = function(self, event, target, player, data)
--     return target==player and player:getMark("@@dook")>0
--   end,
--   on_trigger = function(self, event, target, player, data)
--     player.room:loseHp(player,1,"dook")  --毒skill
--     player.room:setPlayerMark(player,"@@dook",0)
--     player.room:setPlayerMark(player,"@@antirecover-turn",1)
--   end,
-- })

-- dookszjih:addEffect(fk.PreHpRecover, {
--   is_delay_effect=true,
--   can_trigger = function(self, event, target, player, data)
--     return target==player and player:getMark("@@antirecover-turn")>0
--   end,
--   on_trigger = function(self, event, target, player, data)
--     data.prevented=true
--     player.room:sendLog{ type = "#PreventRecoverBySkill", from = player.id, arg = "dook" }
--   end,
-- })
return dookszjih
