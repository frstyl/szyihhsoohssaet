local khiakdeek = fk.CreateSkill {
  name = "khiakdeek",
}

Fk:loadTranslationTable{
  ["khiakdeek"] = "卻敵",
  [":khiakdeek"] = "一其它角色A使用殺旹,若伱在A攻程內,伱可打出1牌无色或与殺異色者發動,此次使用无效,A選擇弃1武器(武器欄中武器牌)或令伱選擇➀視爲伱對A使用殺➁伱獲得此殺(子牌)",

  ["#khiakdeek-invoke"] = "卻敵  %src使用 %arg, 伱可打出1異色牌令其无效",
  ["#khiakdeek-discard"] = "卻敵 弃武器",

  ["$khiakdeek1"] = "吾乃兀顏統軍帳下先鋒",
  ["$khiakdeek2"] = "戰書已下開戰",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

khiakdeek:addEffect(fk.CardUsing, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target~=player and  player:hasSkill(khiakdeek.name) and data.card.trueName=="ssaet"
    and data.from:inMyAttackRange(player)
    and not (data.extra_data and data.extra_data.nullified)
    end,
    on_cost = function(self, event, target, player, data)
      local cards=player.room:askToCards(player,{
			min_num=1,
			max_num=1,
			include_equip=true,
			pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("he"),function(id)
        local c = Fk:getCardById(id)
				return not player:prohibitResponse(c) and (c.color~=data.card.color or c.color==Card.NoColor)--:compareColorWith(data.card,true) and 
			end
			) }),
      prompt = "#khiakdeek-invoke:"..target.id.."::"..data.card:toLogString(),
			cancelable = true,
		})
      if #cards==1 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    S.playCard(player,event:getCostData(self).cards,khiakdeek.name)
    -- data.nullified=true
    S.useNullify(data,player,khiakdeek.name)  --殺進程?
    -- data:removeAllTargets()

    local weapons=data.from:getEquipments(Card.SubtypeWeapon)
    -- weapons=table.filter(weapons,function(id)
    -- return Fk:getCardById(id).sub_type==Card.SubtypeWeapon  --??
    -- end)
    local discard=false
    if #weapons~=0 then 
      local cards= S.askToPlayCard(data.from,{
          min_num=1,
          max_num=1,
          include_equip=true,
          pattern =tostring(Exppattern{ id =weapons  }),
          cancelable=true,
          prompt="#khiakdeek-discard",
          skip=true,
        })
      if #cards>0 then
        discard=true
        room:throwCard(cards, khiakdeek.name, data.from, data.from)
        return
      end
    end

    if discard==true then return end
      local choice = room:askToChoice(player, {
        choices = {"khiakdeek-cards","khiakdeek-ssaet"},
        skill_name = khiakdeek.name,
      })
    if choice=="khiakdeek-cards"  then
      local cards = room:getSubcardsByRule(data.card, { Card.Processing })
      if #cards==0 then return end
      room:obtainCard(player, cards, false, fk.ReasonJustMove, player, khiakdeek.name)
    else
      room:useVirtualCard("ssaet", nil, player, data.from, khiakdeek.name, true)  --zzin souk
    end
      -- for _, p in ipairs(data.tos) do
      --   local use =  room:askToUseCard(p, { 
      --   skill_name = "ssaet", 
      --   pattern = "ssaet", 
      --   prompt = prompt, 
      --   cancelable = true, 
      --   extra_data =  {

      --   must_targets = {data.from.id},
      --   -- bypass_times = true,
      --   -- extraUse=true,
      --   bypass_times = false,
      --   -- extraUse=false,
      -- }, 
      --   -- event_data = effect,
      --   skip=true, 
      -- })
      --  if use then
      --   room:UseCard(use)
      --   return
      --  end
      -- end


  end,
})

-- khiakdeek:addEffect(fk.CardUsing, {
--   can_trigger = function(self, event, target, player, data)
--     return target~=player and  player:hasSkill(khiakdeek.name) and data.card.trueName=="ssaet"
--     and data.from:inMyAttackRange(player)
--     end,
--     on_cost = function(self, event, target, player, data)
--     local yes, ret = player.room:askToUseActiveSkill(player, {
--       skill_name = "discard_skill", 
--       prompt = "#khiakdeek-invoke:"..data.from.id, 
--       cancelable = true, 
--       extra_data = {
--         num = 1,
--         min_num = 0,
--         include_equip = false,
--         skillName = khiakdeek.name,
--         pattern = ".|.|spade,club,nocolorblack",
--       }, 
--       no_indicate = false,
--       skip=true,

--     })
--     if yes then 
--       event:setCostData(self, {cards = ret.cards})
--       return true
--     end
--   end,
--   on_use = function(self, event, target, player, data)
--   local room=player.room
--   local cards =event:getCostData(self).cards
--   if #cards>0 then
--   room:throwCard(cards, khiakdeek.name, player, player)
--   else
--     room:loseHp(player,1,khiakdeek.name,player)
--   end
--   local weapons=data.from:getEquipments(Card.SubtypeWeapon)
--   weapons=table.filter(weapons,function(id)
--   return Fk:getCardById(id).sub_type==Card.SubtypeWeapon  --??
--   end)
--   if #weapons~=0 then 
--     local cards=player.room:askToDiscard(data.from,{
--         min_num=1,
--         max_num=1,
--         include_equip=true,
--         pattern =tostring(Exppattern{ id =weapons  }),
--         cancelable=true,
--         prompt="#khiakdeek-discard",
--         skip=true,
--       })
--     if #cards>0 then
--       room:throwCard(cards, khiakdeek.name, data.from, data.from)
--       return
--     end
--   end
  
--   data:removeAllTargets()

--   end,
-- })

return khiakdeek
