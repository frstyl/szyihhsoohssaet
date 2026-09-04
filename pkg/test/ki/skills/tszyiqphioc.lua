local tszyiqphioc = fk.CreateSkill {
  name = "tszyiqphioc",
}


Fk:loadTranslationTable{ --拆解
  ["tszyiqphioc"] = "錐鋒",
  [":tszyiqphioc"] = "伱起動殺指定目幖後伱可選1項發動.➀弃置其x牌➁對其傷害基數+y(x=其體力值,y=下整(其此刻手牌數/2))",

  ["#tszyiqphioc-invoke"] = "錐鋒 令 %src 執行1項",
  ["tszyiqphioc-discard"] = "展示全部牌 弃置全部閃",
  ["tszyiqphioc-damage"] = "傷害基數+1",


  ["$tszyiqphioc1"] = "賊子伱往若里去",
  ["$tszyiqphioc2"] = "",
}

tszyiqphioc:addEffect(fk.TargetConfirmed, {  -- --PreCardEffect
  anim_type = "offensive",
  prompt = "#tszyiqphioc",
  can_trigger = function(self, event, target, player, data)
		return  data.from==player and player:hasSkill(tszyiqphioc.name)
    and (data.card.trueName=="ssaet" or data.card.trueName=="tous_tsiacs")
    -- and data:isOnlyTarget(data.to)
	end,
	on_cost = function(self, event, target, player, data)
    local choice = player.room:askToChoice(player, {
      choices = { "tszyiqphioc-discard", "tszyiqphioc-damage","Cancel" },
      skill_name = tszyiqphioc.name,
      prompt = "#tszyiqphioc-invoke:"..data.to.id,
      cancelable=true,
    })
    if choice~="" and choice~="Cancel" then
      event:setCostData(self,{choice=choice})
      return  true
    end
  end,
	on_use = function(self, event, target, player, data)
    local room=player.room
    local choice=event:getCostData(self).choice
    if choice=="tszyiqphioc-discard" then
		local cards=room:askToChooseCards(player,{
		target = data.to,
		min=data.hp,
		max=data.hp,
		cancelable=false,
		flag="he",
		skill_name=tszyiqphioc.name,
		})
		room:throwCards(cards, tszyiqphioc.name, data.to, player)
    else

      data.additionalDamage=(data.additionalDamage or 0) +data.to:getHandCardNum()//2
    end

  end,
})

-- tszyiqphioc:addEffect(fk.CardUseFinished, {
--   is_delay_effect=true,
--   can_trigger = function(self, event, target, player, data)
--     if  data.extra_data and data.extra_data.tszyiqphioc and  player.id==data.extra_data.tszyiqphioc.from  then
--       return true
--     end
--   end,
--   on_trigger = function(self, event, target, player, data)
--     local room=player.room
--     local exe=function(p,result)
--       if result==1      then
--          p:drawCards(1, tszyiqphioc.name)
--       else
--         room:askToDiscard(p, {
--           min_num = 1,
--           max_num = 1,
--           include_equip = false,
--           skill_name = tszyiqphioc.name,
--           cancelable = false,
--           prompt = "#tszyiqphioc-discard",
--           skip = false,
--         })
--       end
--     end
--     local t=data.extra_data.tszyiqphioc.t
--     for _, p in ipairs (room:getOtherPlayers(player)) do
--       if t[p.id] then
--         if not player.dead then exe(player,t[p.id][1]) end
--         if not p.dead then  exe(p,t[p.id][2]) end
--       end
--     end

--   end,
-- })

-- tszyiqphioc:addEffect(fk.PreCardEffect, {
--   can_trigger = function(self, event, target, player, data)
--     if data.to==player  and data.extra_data 
--     and
--     --  
--     data.extra_data.tszyiqphioc 
--     then
--       return true
--     end
--   end,
--   on_trigger = function(self, event, target, player, data)
--       data.additionalDamage=(data.additionalDamage or 0) +1

--   end,
-- })


return tszyiqphioc
