local punsmuoh = fk.CreateSkill {
  name = "punsmuoh",
  tags = { Skill.Switch },
}

Fk:loadTranslationTable{
  ["punsmuoh"] = "奮武",
  [":punsmuoh"] = "依序發動.➀伱可將1紅牌轉化爲殺使用發動.此殺不計入次數,其結算終旹若其未對目幖致傷,令伱下次所用殺无視距離且致傷旹傷害值+1,➁伱可將1黑牌轉化爲殺使用發動.此牌反失效反抵消",

  ["@@punsmuoh-switch-yang"] = "奮武",
  ["@@punsmuoh-switch-yin"] = "奮武",
  ["punsmuoh-nodamage"] = "奮武",

  ["$punsmuoh1"] = "想走,沒若麼容㑥",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

punsmuoh:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#punsmuoh",
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0   and Fk:getCardById(to_select).color == player:getSwitchSkillState(punsmuoh.name,true)+1
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("ssaet")
    c.skillName = punsmuoh.name  --幖記此牌
    c:setMark("@@punsmuoh-switch".."-"..player:getSwitchSkillState(punsmuoh.name,false,true),player.id)
    c:addSubcard(cards[1])
    return c
  end,
  before_use = function(self, player, use)
    if use.card:getMark("@@punsmuoh-switch-yin") then
      use.extra_data =use.extra_data or {}
      use.extra_data.antiNullify=true
      use.extra_data.antiCancel=true
    else
      data.extraUse = true
    end
  end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response = function(self, player, response) 
    return  not response 
  end,
})



punsmuoh:addEffect(fk.CardUseFinished, {-- CardEffectCancelledOut
  anim_type = "drawcard",
  can_refresh = function(self, event, target, player, data)
    if  data.card:getMark("@@punsmuoh-switch-yang")==player.id
    -- and player.id == data.card:getMark("punsmuoh-from")
    then
      if  not data.damageDealt  then return true end
      for _,p in ipairs(data.tos) do
        if not data.damageDealt[p] or data.damageDealt[p]<=0 then
          return true
        end
      end
    end
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:setPlayerMark(player,"punsmuoh-nodamage",1)
  end,
})


punsmuoh:addEffect(fk.CardUsing, {  --不算發動技能  --加傷幖記
  is_delay_effect = true,
  anim_type = "drawcard",
  can_refresh = function(self, event, target, player, data)
    return target==player
    and data.card   and data.card.trueName=="ssaet"
    and player:getMark("punsmuoh-nodamage")>0
  end,
  on_refresh = function(self, event, target, player, data)
    data.extra_data=data.extra_data or {}
    data.antiNullify=true
    player.room:setPlayerMark(player,"punsmuoh-nodamage",0)
    player.room:setCardMark(data.card,"punsmuoh-damage-card-phase",player.id)  --  --插入中使用此牌會增傷
    player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true):addCleaner(function()
      player.room:setCardMark(data.card, "punsmuoh-damage-card-phase", 0)  --  --插入中使用此牌會增傷
    end)
  end,
})

punsmuoh:addEffect(fk.DamageCaused, {  --不算發動技能
  is_delay_effect = true,
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return  data.card   and data.card:getMark("punsmuoh-damage-card-phase")==player.id 
  end,
  on_trigger = function(self, event, target, player, data)
    S.changeDamage({damageData=data, num=1,skillName=punsmuoh.name})
  end,
})

-- punsmuoh:addEffect(fk.TargetSpecified, {  --不算發動技能
--   can_trigger = function (self, event, target, player, data)
--     return data.card:getMark("@@punsmuoh-switch-yin")==player.id
--     -- and data.from==player --問一次
--   end,
--   on_trigger = function (self, event, target, player, data)
--     -- data:setUnoffsetable(data.to)
--     data.unoffsetable = true
--     -- player.room:setPlayerMark(data.to, "@@MarkArmorNullified-round",1)  --同旹清理
--   end
-- })

local anti={
  can_trigger = function (self, event, target, player, data)
    return data.card:getMark("@@punsmuoh-switch-yin")==player.id
    -- and data.from==player --問一次
  end,
  on_trigger = function (self, event, target, player, data)
    data.isCancellOut = false
  end
}

punsmuoh:addEffect(fk.CardEffectCancelledOut, {  --不算發動技能
  can_trigger = anti.can_trigger,
  on_trigger=anti.on_trigger,
})

-- punsmuoh:addEffect(S.AfterUseNullify, {
--   can_trigger = anti.can_trigger,
--   on_trigger=anti.on_trigger,
  
-- })

-- punsmuoh:addEffect(S.AftereffectNullify, {
--   can_trigger = anti.can_trigger,
--   on_trigger=anti.on_trigger,
  
-- })


-- punsmuoh:addEffect(S.AftereffectNullify, {
--   can_trigger = anti.can_trigger,
--   on_trigger = function (self, event, target, player, data)
--     data.nullified=false
--     -- data:antiNullify()
--   end,
-- })

punsmuoh:addEffect("targetmod", {
  -- bypass_times = function(self, player, skill, scope, card)
  -- end,
  bypass_distances = function(self, player, skill, card)
    return card and card.trueName=="ssaet" and player:getMark("punsmuoh-nodamage")>0
  end,
  -- extra_target_func = function(self, player, skill, card)
  -- end,
})

return punsmuoh
