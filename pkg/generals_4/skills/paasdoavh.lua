local paasdoavh = fk.CreateSkill {
  name = "paasdoavh",
}

Fk:loadTranslationTable{
["paasdoavh"] = "霸道",
[":paasdoavh"] = "當其它角色主段始旹,伱預打出1基本牌發動,該角色本轉不可使用牌与伱所弃牌同色者(含子牌)",
["#paasdoavh-ask"]="霸道 弃牌 令 %src 不能使用打出同色牌",
["@paasdoavh-turn"] = "霸道",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"


paasdoavh:addEffect(fk.EventPhaseStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return   target ~= player and player:hasSkill(paasdoavh.name) and target.phase == Player.Play and (not target.dead) 
      and (not player:isKongcheng()) 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local paasdoavh_card=room:askToCards(player,{ ---@type AskToChooseCardsParams
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = paasdoavh.name,
        pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("he"),function(id)
          local c=Fk:getCardById(id)
          return S.getCardTypeByName(c.trueName) == 1 and not player:prohibitResponse(c)
        end
        ) }),
        prompt = "#paasdoavh-ask:".. target.id,
        cancelable= true,
        skipDiscard = true, --skipDiscard
    })
    if #paasdoavh_card ~= 0 then
       event:setCostData(self,{tos={target},cards = paasdoavh_card})
       return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local card= Fk:getCardById(event:getCostData(self).cards[1])  --id?
    room:responseCard({
				card=card,
				from=player,
				attachedSkillAndUser={muteCard=true},
			})
    room:addTableMarkIfNeed(target, "@paasdoavh-turn",card:getColorString())  --tos?
  end,
})

-- paasdoavh:addEffect(fk.TurnEnd, {
  -- mute =true,
  -- is_delay_effect = true,
  -- can_refresh = function (self, event, target, player, data)
    -- if #player.room:getMark("@paasdoavh-turn")==0 then return end
  -- end,
  -- on_refresh = function (self, event, target, player, data)
    -- player.room:setMark("@paasdoavh-turn", 0)
  -- end,
-- })

paasdoavh:addEffect("prohibit", {  --不能使用打出同色牌 元版不能 轉化後牌不能 轉化歬牌不能 --肰則牌名殺?
  prohibit_use = function(self, player, card)
    if player:getMark("@paasdoavh-turn")==0 then return end
    if table.contains(player:getTableMark("@paasdoavh-turn"), card:getColorString()) then
      return true
    end
    if  card:isVirtual() then
      for _,id in ipairs(card.subcards) do
        if table.contains(player:getTableMark("@paasdoavh-turn"), Fk:getCardById(id):getColorString()) then
          return true
        end
      end
    end
  end,
  -- prohibit_response = function(self, player, card)
  --   if player:getMark("@paasdoavh-turn")==0 then return end
  --   if table.contains(player:getTableMark("@paasdoavh-turn"), card:getColorString()) then
  --     return true
  --   end
  --   if  card:isVirtual() then
  --     for _,id in ipairs(card.subcards) do
  --       if table.contains(player:getTableMark("@paasdoavh-turn"), Fk:getCardById(id):getColorString()) then
  --         return true
  --       end
  --     end
  --   end
  -- end,
})

return paasdoavh
