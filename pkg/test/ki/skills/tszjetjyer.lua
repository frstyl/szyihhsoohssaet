local tszjetjyer = fk.CreateSkill{
  name = "tszjetjyer",
}

Fk:loadTranslationTable{
  ["tszjetjyer"] = "折銳",
  [":tszjetjyer"] = "脚色A轉始旹,伱可發動.伱聲明1牌類B｡A 1轉內下次起動牌聲明旹,若牌類与B:同,无效之;不同,A 1轉內不可起動B牌類",

  ["#tszjetjyer-invoke"] = "折銳： %src 是否發動",

  ["$tszjetjyer1"] = "吾已埋下伏兵，敌兵一来，管教他瓮中捉鳖。",
  ["$tszjetjyer2"] = "我已设下重重圈套，就等敌军入彀矣。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tszjetjyer:addEffect(fk.TurnStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(tszjetjyer.name) and data.who~=player
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room
    local to = data.who
    local choices={"action","trick","equip","goods" ,"magic","allusion"}  --S.
    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = tszjetjyer.name,
      prompt = "#tszjetjyer-choose",
      prompt="#tszjetjyer-invoke:"..to.id,
      cancelable=true,
    })
    if choice~="Cancel" then
      local t  =table.indexOf(choices,choice)
      event:setCostData(self,{tos={to}, choice=t})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local dat = event:getCostData(self)
    room:addTableMark(player, "@tszjetjyer-turn",{player, dat.choice })
  end,
})

tszjetjyer:addEffect(fk.CardUsing, {-- --AfterCardUseDeclared
  anim_type = "control",
  -- is_dellay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return  player:getMark("@tszjetjyer-turn")~=0
  end,
  on_trigger = function (self, event, target, player, data)
    local room = player.room
    for _, t in ipairs( player:getTableMark("@tszjetjyer-turn")) do
      if t[2] == S.getCardTypeByName(data.card.trueName) then
        S.useNullify(data,tszjetjyer.name, t[1])
      else

        room:addTableMarkIfNeed(target, "@tszjetjyer-prohibit-turn", t[2])
      end
    end
  end,
})

tszjetjyer:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    if player:getMark("@tszjetjyer-prohibit-turn")==0 then return end
    if table.contains(player:getTableMark("@tszjetjyer-prohibit-turn"), S.getCardTypeByName(card.trueName)) then
    return true
    end
    if card:isVirtual() then
      for _,id in ipairs(card.subcards) do

        if table.contains(player:getTableMark("@tszjetjyer-prohibit-turn"), S.getCardTypeByName(Fk:getCardById(id).trueName)) then
          return true
        end
      end
    end
  end,
  -- prohibit_response = function(self, player, card)
  --   if player:getMark("@tszjetjyer-prohibit-turn")==0 then return end
  --   if table.contains(player:getTableMark("@tszjetjyer-prohibit-turn"), S.getCardTypeByName(card.trueName)) then
  --   return true
  --   end
  --   if card:isVirtual() then
  --     for _,id in ipairs(card.subcards) do

  --       if table.contains(player:getTableMark("@tszjetjyer-prohibit-turn"), S.getCardTypeByName(Fk:getCardById(id).trueName)) then
  --         return true
  --       end
  --     end
  --   end
  -- end,
  -- prohibit_discard = function(self, player, card)
  --   if player:getMark("@tszjetjyer-prohibit-turn")==0 then return end
  --   if table.contains(player:getTableMark("@tszjetjyer-prohibit-turn"), S.getCardTypeByName(card.trueName)) then
  --   return true
  --   end
  --   if card:isVirtual() then
  --     for _,id in ipairs(card.subcards) do

  --       if table.contains(player:getTableMark("@tszjetjyer-prohibit-turn"), S.getCardTypeByName(Fk:getCardById(id).trueName)) then
  --         return true
  --       end
  --     end
  --   end
  -- end,
})


return tszjetjyer
