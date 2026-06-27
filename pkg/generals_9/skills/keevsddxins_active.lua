local keevsddxins_active = fk.CreateSkill {
  name = "keevsddxins_active&",
  tags={Skill.Permanent,}  --效果 不失去不失效
}

Fk:loadTranslationTable{
  ["keevsddxins_active&"] = "叫陣",
  [":keevsddxins_active&"] = "效果➀額定抽牌數-1➁所致傷視爲雷傷➂可將黑色牌轉化爲鬥將使用➃使用鬥將无視距離➄轉終,抽x(x爲伱本轉致傷次數)",

  ["@@keevsddxins_active"] = "叫陣",

  ["$keevsddxins_active1"] = "吾乃兀顏統軍帳下先鋒",
  ["$keevsddxins_active2"] = "戰書已下開戰",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

keevsddxins_active:addEffect("viewas", {  --不失效
  anim_type = "offensive",
  prompt = "#keevsddxins_active",
  pattern="tous_tsiacs",
  -- mute=true,
  muteCard=true,
  card_filter = function(self, player, to_select, selected)
    return  #selected == 0 and Fk:getCardById(to_select).color == Card.Black
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return  end
    local card = Fk:cloneCard("tous_tsiacs")
    card:addSubcards(cards)
    S.mixCard(card)
    card.skillName = keevsddxins_active.name
    return card
  end,
  enabled_at_play = function(self, player, response)
    return  player:getMark("@@keevsddxins-turn")>0 
  end,
    enabled_at_response = function(self, player, response)
    return  not response and  player:getMark("@@keevsddxins-turn")>0
  end,
})



keevsddxins_active:addEffect(fk.PreDamage, {
  -- is_delay_effect=ture,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:getMark("@@keevsddxins-turn") >0 and data.damageType~=fk.ThunderDamage
  end,
  on_trigger = function(self, event, target, player, data)
    data.damageType=fk.ThunderDamage
    -- player.room:broadcastSkillInvoke()
  end,
})

keevsddxins_active:addEffect(fk.DrawNCards, {
  is_delay_effect=ture,
  can_trigger= function(self, event, target, player, data)
    return  target==player and  player:getMark("@@keevsddxins-turn") >0 
  end,
  on_trigger = function(self, event, target, player, data)
    data.n=data.n-1
  end,
})

keevsddxins_active:addEffect(fk.TurnEnd, {
  is_delay_effect=ture,
  can_trigger= function(self, event, target, player, data)
    if  target==player and  player:getMark("@@keevsddxins-turn") >0  then
        local n = #player.room.logic:getActualDamageEvents(5, function (e)
            return e.data.from == player
          end, Player.HistoryTurn)
          if n > 0 then
            event:setCostData(self, {n = n})
            return true
          end
        end
  end,
  on_trigger = function(self, event, target, player, data)
    player:drawCards(event:getCostData(self).n,keevsddxins_active.name)
  end,
})


-- keevsddxins_active:addEffect(fk.TurnEnd, {
--   -- is_delay_effect=ture,
--   priority=0,
--   on_refresh = function(self, event, target, player, data)
--     return target==player
--   end,
--   on_refresh = function(self, event, target, player, data)
--     player.room:handleAddLoseSkills(player, "-keevsddxins_active&",nil,false,true)
--   end,
-- })

keevsddxins_active:addEffect("targetmod", {
  bypass_distances = function(self, player, skill, card)
    return card and player and player:getMark("@@keevsddxins-turn")>0 and card.trueName=="tous_tsiacs"
  end,
})

return keevsddxins_active
