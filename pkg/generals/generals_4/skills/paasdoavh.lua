local paaskeecs = fk.CreateSkill {
  name = "paaskeecs",
}

Fk:loadTranslationTable{
["paaskeecs"] = "霸徑",
[":paaskeecs"] = "其它脚色主段始旹,伱預打出1基本牌發動,該脚色本轉不可起動牌与伱所弃牌同色者(含子牌)",
["#paaskeecs-ask"]="霸徑 弃牌 令 %src 不可起動打出同色牌",
["@paaskeecs-turn"] = "霸徑",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"


paaskeecs:addEffect(fk.EventPhaseStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return   target ~= player and player:hasSkill(paaskeecs.name) and target.phase == Player.Play and (not target.dead) 
      and (not player:isKongcheng()) 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local paaskeecs_card=room:askToCards(player,{ ---@type AskToChooseCardsParams
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = paaskeecs.name,
        pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("he"),function(id)
          local c=Fk:getCardById(id)
          return S.getCardTypeByName(c.trueName) == 1 and not player:prohibitResponse(c)
        end
        ) }),
        prompt = "#paaskeecs-ask:".. target.id,
        cancelable= true,
        skipDiscard = true, --skipDiscard
    })
    if #paaskeecs_card ~= 0 then
       event:setCostData(self,{tos={target},cards = paaskeecs_card})
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
    room:addTableMarkIfNeed(target, "@paaskeecs-turn",card:getColorString())  --tos?
  end,
})

-- paaskeecs:addEffect(fk.TurnEnd, {
  -- mute =true,
  -- is_delay_effect = true,
  -- can_refresh = function (self, event, target, player, data)
    -- if #player.room:getMark("@paaskeecs-turn")==0 then return end
  -- end,
  -- on_refresh = function (self, event, target, player, data)
    -- player.room:setMark("@paaskeecs-turn", 0)
  -- end,
-- })

paaskeecs:addEffect("prohibit", {  --不可起動打出同色牌 元版不能 轉化後牌不能 轉化歬牌不能 --肰則牌名殺?
  prohibit_use = function(self, player, card)
    if player:getMark("@paaskeecs-turn")==0 then return end
    if table.contains(player:getTableMark("@paaskeecs-turn"), card:getColorString()) then
      return true
    end
    if  card:isVirtual() then
      for _,id in ipairs(card.subcards) do
        if table.contains(player:getTableMark("@paaskeecs-turn"), Fk:getCardById(id):getColorString()) then
          return true
        end
      end
    end
  end,
  -- prohibit_response = function(self, player, card)
  --   if player:getMark("@paaskeecs-turn")==0 then return end
  --   if table.contains(player:getTableMark("@paaskeecs-turn"), card:getColorString()) then
  --     return true
  --   end
  --   if  card:isVirtual() then
  --     for _,id in ipairs(card.subcards) do
  --       if table.contains(player:getTableMark("@paaskeecs-turn"), Fk:getCardById(id):getColorString()) then
  --         return true
  --       end
  --     end
  --   end
  -- end,
})

return paaskeecs
