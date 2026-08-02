
local hqujqtszjins = fk.CreateSkill{
  name = "hqujqtszjins",
  -- tags = { Skill.Compulsory },
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos"

Fk:loadTranslationTable{
  ["hqujqtszjins"] = "威震",
  [":hqujqtszjins"] = "伱{起動/打出/弃置}牌後,伱可發動,伱抽1,當轉全體脚色不可{起動/打出/弃置}牌",
--加彊?
  ["@hqujqtszjins-phase"] = "威震",
  ["hqujqtszjins-use"] = "起動",
  ["hqujqtszjins-response"] = "打出",
  ["hqujqtszjins-discard"] = "弃置",

  ["#hqujqtszjins-use"] = "威震 抽1 全體脚色此段不可 起動 牌",
  ["#hqujqtszjins-response"] = "威震 抽1 全體脚色此段不可 打出 牌",
  ["#hqujqtszjins-discard"] = "威震 抽1 全體脚色此段不可 弃置 牌",

  ["$hqujqtszjins1"] = "洞察機先 无有不破",
  ["$hqujqtszjins2"] = "意志被摧毀了无",
}


hqujqtszjins:addEffect(fk.CardUsing, {
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(hqujqtszjins.name)
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, { skill_name = hqujqtszjins.name ,prompt="#hqujqtszjins-use"})
  end,
  on_use= function(self, event, target, player, data)
    local room=player.room
    player:drawCards(1,hqujqtszjins.name)
    local t=room:getBanner("hqujqtszjins-phase") or {}
    table.insertIfNeed(t,"hqujqtszjins-use")
    room:setBanner("hqujqtszjins-phase",t)
    room:addTableMarkIfNeed(player,"@hqujqtszjins-phase","hqujqtszjins-use")
  end,
})

hqujqtszjins:addEffect(fk.CardResponding, {
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(hqujqtszjins.name)
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, { skill_name = hqujqtszjins.name ,prompt="#hqujqtszjins-response"})
  end,
  on_use= function(self, event, target, player, data)
    local room=player.room
    player:drawCards(1,hqujqtszjins.name)
    local t=room:getBanner("hqujqtszjins-phase") or {}
    table.insertIfNeed(t,"hqujqtszjins-response")
    room:setBanner("hqujqtszjins-phase",t)
    room:addTableMarkIfNeed(player,"@hqujqtszjins-phase","hqujqtszjins-response")
  end,
})
hqujqtszjins:addEffect(fk.AfterCardsMove, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(hqujqtszjins.name) then return end

      for _, move in ipairs(data) do
        if fk.ReasonDiscard==move.moveReason
          -- and move.from == player 
          -- and move.toArea == Card.DiscardPile
          and
          move.proposer==player
        then
          return true
        end
      end

  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, { skill_name = hqujqtszjins.name ,prompt="#hqujqtszjins-discard"})
  end,
  on_use= function(self, event, target, player, data)
    local room=player.room
    player:drawCards(1,hqujqtszjins.name)
    local t=room:getBanner("hqujqtszjins-phase") or {}
    table.insertIfNeed(t,"hqujqtszjins-discard")
    room:setBanner("hqujqtszjins-phase",t)
    room:addTableMarkIfNeed(player,"@hqujqtszjins-phase","hqujqtszjins-discard")
  end,
})

hqujqtszjins:addEffect(fk.BeforeCardsMove, {
  anim_type = "control",
  can_refresh = function(self, event, target, player, data)
    if not table.contains(Fk:currentRoom():getBanner("hqujqtszjins-phase") or {}, "hqujqtszjins-discard") then return end

      for _, move in ipairs(data) do
        if fk.ReasonDiscard==move.moveReason
          -- and move.from == player 
          -- and move.toArea == Card.DiscardPile
          and
          move.proposer~=nil --系統弃牌?
        then
          return true
        end
      end

  end,
  on_refresh= function(self, event, target, player, data)
    player.room:cancelMove(data,nil)
    -- sendLog()
  end,
})
hqujqtszjins:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    return      table.contains(Fk:currentRoom():getBanner("hqujqtszjins-phase") or {}, "hqujqtszjins-use")
  end,
  prohibit_response = function(self, player, card)
    return      table.contains(Fk:currentRoom():getBanner("hqujqtszjins-phase") or {}, "hqujqtszjins-response")
  end,
  prohibit_discard = function(self, player, card)
    return      table.contains(Fk:currentRoom():getBanner("hqujqtszjins-phase") or {}, "hqujqtszjins-discard")
  end,
})


return hqujqtszjins
