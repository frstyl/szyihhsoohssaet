
local pjecskrak = fk.CreateSkill {
  name = "pjecskrak",
}

Fk:loadTranslationTable{
["pjecskrak"] = "并戟",
[":pjecskrak"] = "主動.預將2張A類牌轉化爲「殺」使用發動.此「殺」无距離限制可額外指定x目幖(x爲伱已損體力値),且若A爲錦囊,此「殺」无次數限制;裝備:此「殺」无效目幖防具至當段終",
--區分伱已此法所用 与 此牌?
["#pjecskrak"] = "2同類牌轉化爲殺",

["$pjecskrak1"] = "來一个,殺一个.來一對,殺一雙",
["$pjecskrak2"] = "絳霞影裏,卷一道凍地仌霜",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

pjecskrak:addEffect("viewas", {
  anim_type = "offensive",
  prompt = "#pjecskrak",
  pattern = "ssaet",
  card_filter = function(self, player, to_select, selected)
    return  #selected == 0 or 
      (#selected == 1 
      and 
      -- Fk:getCardById(to_select).type == Fk:getCardById(selected[1]).type
            S.compareCardType(Fk:getCardById(to_select).name,Fk:getCardById(selected[1]).name)

    )
    -- if to_select.getTypeString() ==selected[1].getTypeString

  end,
  view_as = function(self, player, cards)
    if #cards ~= 2 then return  end
    local card = Fk:cloneCard("ssaet")
    card:addSubcards(cards)
    card.skillName = pjecskrak.name
    S.mixCard(card)
    return card
  end,
 
  -- before_use = function(self, player, use)
  -- if Fk:getCardById(use.card.subcards[1]).type==Card.TypeTrick then
  --   use.extraUse =true
  --   end
  -- end,
  enabled_at_response = function(self, player, response) --響應
    return  not response  --此response为打出 不能用于打出 
  end,
})

pjecskrak:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card)
    return card --and scope == Player.HistoryPhase 
    and table.contains(card.skillNames, pjecskrak.name)
    -- and Fk:getCardById().type==Card.TypeTrick
    and S.getCardTypeByName(Fk:getCardById(card.subcards[1])) == 2
  end,
  bypass_distances = function(self, player, skill, card)
    return card and card.skillNames and table.contains(card.skillNames, pjecskrak.name)
  end,
  extra_target_func = function(self, player, skill, card)
    if card and card.skillNames and table.contains(card.skillNames, pjecskrak.name) then
      return player:getLostHp()
    end
  end,
})

pjecskrak:addEffect(fk.TargetSpecified, {  --无視防具 --待改
  can_refresh = function(self, event, target, player, data)
    return target == player  and data.card  --問一次
      and data.card.skillNames  and table.contains(data.card.skillNames, pjecskrak.name) 
      and Fk:getCardById(data.card.subcards[1]).type==Card.TypeEquip
      -- and S.getCardTypeByName(Fk:getCardById(card.subcards[1])) == 3
      and not data.to.dead 
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:addPlayerMark(data.to, "@@MarkArmorNullified-phase",1)
  end,
})

-- pjecskrak:addEffect("invalidity", {
--   invalidity_func = function(self, player, skill)
--     if not (
--       skill:getSkeleton() --被invalidity skill
--       and skill:getSkeleton().attached_equip and  Fk:cloneCard(skill:getSkeleton().attached_equip).sub_type == Card.SubtypeArmor
--    ) then
--         return
--     end
--         local card=nil
--         local ignore=false
--         local event =RoomInstance and RoomInstance.logic:getCurrentEvent()
--         if not event then 
--           goto request
--         end
--         if event.event==GameEvent.AimEvent then  
--       --     event.data.card.skillNames  and table.contains(event.data.card.skillNames, pjecskrak.name) 
--       -- and Fk:getCardById(event.data.card.subcards[1]).type==Card.TypeEquip theen
--           -- ignore=true 
--           card = event.data.card
--           goto OK
--         elseif event.event == GameEvent.Damage then
--           card = event.data.card
--           goto OK
--         elseif event.event == GameEvent.UseCard then
--          card = event.data.card
--             goto OK
--         elseif event.event == GameEvent.CardEffectEvent then
--             card = event.data.use.card
--             goto OK
--         end


--         ::request::
--         if ClientInstance and ClientInstance.current_request_handler   --request不屬于event中
--         and ClientInstance.current_request_handler.player  
--         and  ClientInstance.current_request_handler.skill_name==pjecskrak.name
--           then
--             card = Fk.skills[pjecskrak.name]:viewAs(player, ClientInstance.current_request_handler.pendings)
--         end

--         ::OK::
        
--       if --ignore or  --可行
--       (
--       card  and card.skillNames  and table.contains(card.skillNames, pjecskrak.name) 
--       and Fk:getCardById(card.subcards[1]).type==Card.TypeEquip      
--       )
--       then  --from:hasSkill(muoqtssioh.name)  會封自己防具
--         for _, id in ipairs(player:getEquipments(Card.SubtypeArmor)) do
--           local card = Fk:getCardById(id)
--           if  skill:getSkeleton().attached_equip == card.name then
--             return true
--           end
--         end
--       end
  
--   end,
-- })

return pjecskrak

