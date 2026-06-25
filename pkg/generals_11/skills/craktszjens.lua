local craktszjens = fk.CreateSkill {
  name = "craktszjens",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable {
  ["craktszjens"] = "逆戰",
  [":craktszjens"] = "➀恆續.伱轉內,手牌區黑{錦囊/事件/法術}牌視爲无視距離｢鬥將｣｡➁伱使用鬥將指定目幖後旹必發,伱獲取目幖1手牌｡➂其它角色使用鬥將旹,若目幖包含伱,必發,視爲伱對其使用(迻除其它目幖)",

  ["#craktszjens"] = "逆戰：將1手牌置入伱裝僃區",

  ["$craktszjens1"] = "就拏伱來祭我死去之弟兄",
  ["$craktszjens2"] = "宋兵雄兵百萬竟无好漢一人",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 

craktszjens:addEffect("filter", {
  card_filter = function(self, to_select, player, isJudgeEvent)
    return 
    Fk:currentRoom():getCurrent() and Fk:currentRoom():getCurrent():hasSkill(craktszjens.name)
    and
    to_select.color==Card.Black 
    and table.contains({2,4,5},S.getCardTypeByName(to_select.trueName))
    and table.contains(player:getCardIds("h"), to_select.id)
  end,
  view_as = function(self, player, to_select)
    return Fk:cloneCard("distance__tous_tsiacs", to_select.suit, to_select.number)
  end,
})


craktszjens:addEffect(fk.TargetSpecified, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)  --按序 名不重要
    return target==player and player:hasSkill(craktszjens.name) 
    and data.card
    and data.card.trueName=="tous_tsiacs"
    and not data.to:isKongcheng()
  end,
  -- on_cost =function(self, event, target, player, data)
  --   local room=player.room
  --   if not room:askToSkillInvoke(player, {
  --     skill_name = craktszjens.name,
  --     prompt = "#craktszjens::".. data.to.id,
  --   }) then return end
  --   local cid = room:askToChooseCard(player, { target = data.to, flag = "h", skill_name = craktszjens.name })
  --   event:setCostData(self,{card=cid})
  --   return true
  -- end,
  on_use = function(self, event, target, player, data)
    if player.dead or data.to.dead or data.to:isKongcheng() then return end    
    local cid = player.room:askToChooseCard(player, { target = data.to, flag = "h", skill_name = craktszjens.name })
    player.room:obtainCard(player, cid, false, fk.ReasonPrey, player, craktszjens.name)
  end,
})

craktszjens:addEffect(fk.CardUsing, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return data.from~=player 
    and player:hasSkill(craktszjens.name) 
    and data.card.trueName=="tous_tsiacs"
    and table.contains(data.tos,player)
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room

    local p=target
    data.tos={p}
    data.from=player
    target=player

    data.extra_data=data.extra_data or {}
    data.extra_data.craktszjens=true
  end,
})

-- craktszjens:addEffect("targetmod", {
--   bypass_distances = function(self, player, skill, card)
--     return card and player and player:hasSkill(craktszjens.name) and card.skillNames=="tous_tsiacs"
--   end,
-- })
return craktszjens
