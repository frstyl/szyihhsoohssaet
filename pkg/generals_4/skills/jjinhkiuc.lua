local jjinhkiuc = fk.CreateSkill {
  name = "jjinhkiuc",
}

Fk:loadTranslationTable{
  ["jjinhkiuc"] = "引弓",
  [":jjinhkiuc"] = "主旹至多2次.伱預展示1手牌發動.伱攻程加减ceil(x/2),伱手牌點數等于x者視爲殺(x爲所展示牌點數).伱使用殺結算後,褈置此技能(效果与次數)",

  ["#jjinhkiuc-active"] = "引弓 展示1手牌",
  ["@jjinhkiuc"] = "引弓",
  ["@jjinhkiuc-atkrange"] = "攻程",

  ["add"] = "增",
  ["minus"] = "减",

  ["$jjinhkiuc1"] = "弓开秌月分明",

}
jjinhkiuc:addEffect("active", {
  anim_type = "support",
  prompt = "#jjinhkiuc-active",
  target_num = 0,
  card_num = 1,
  max_phase_use_time=2,
  -- can_use=function(self, player)
  --   return player:usedEffectTimes(self, Player.HistoryPhase)<1+player:getLostHp()
  -- end,
  interaction = function(self, player)
    return UI.ComboBox {  
      choices = {"add","minus"}
    }
  end,
  card_filter = function(self, player, to_select, selected)
    return #selected ==0 and table.contains(player:getCardIds("h"),to_select)
    and Fk:getCardById(to_select).number~=0
  end,
  on_use = function(self, room, effect)
    local p=effect.from
    p:showCards(effect.cards)
    local number=Fk:getCardById(effect.cards[1]).number
    -- room:setPlayerMark(p,"@jjinhkiuc",number)
    room:addTableMark(p,"@jjinhkiuc",number)
      number= (number+1)//2
    if self.interaction.data=="minus" then 
      number= -number
    end
    room:setPlayerMark(p,"@jjinhkiuc-atkrange",p:getMark("@jjinhkiuc-atkrange")+number)  --初始爲0
    p:filterHandcards()
  end,
})

jjinhkiuc:addEffect("atkrange", {
  correct_func = function(self, player)
    if player:getMark("@jjinhkiuc-atkrange") ~=0 then
        return player:getMark("@jjinhkiuc-atkrange")
    end
  end
})

jjinhkiuc:addEffect("filter", {
  card_filter = function(self, to_select, player)
    if  player:getMark("@jjinhkiuc") ~=0 then 
      return 
       table.contains(player:getCardIds("h"), to_select.id)
      and table.contains(player:getTableMark("@jjinhkiuc"), to_select.number)
    end
  end,
  view_as = function(self, player, to_select)
    local card = Fk:cloneCard("ssaet", to_select.suit, to_select.number)
    card.skillName = jjinhkiuc.name
    return card
  end,
})

jjinhkiuc:addEffect(fk.CardUseFinished, { --??
  can_refresh = function(self, event, target, player, data)
    return 
    target == player
    and data.card.trueName=="ssaet" 
    and player:getMark("@jjinhkiuc") ~=0
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:setPlayerMark(player,"@jjinhkiuc",0) 
    player.room:setPlayerMark(player,"@jjinhkiuc-atkrange",0) 
    player:setSkillUseHistory(jjinhkiuc.name)
  end,
  })

return jjinhkiuc
