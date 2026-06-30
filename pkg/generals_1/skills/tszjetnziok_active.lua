local tszjetnziok_active = fk.CreateSkill {
  name = "tszjetnziok_active",
}
Fk:loadTranslationTable{
  -- ["tszjetnziok_active"] = "折辱",
}


tszjetnziok_active:addEffect("active", {
  mute = true,
  prompt = "#tszjetnziok_active",
  min_card_num = 1,
  max_card_num = 2,
  target_num = 0,
  max_phase_use_time=1,
  -- handly_pile = true,  --弃
  -- interaction = function(self,player)
  --   local t= { "@@tszjetnziok_reverse-round", "@@tszjetnziok_double-round" }
  --   if self.half then table.insert(t,"both") end
  --   return UI.ComboBox {choices = t }
  -- end,
  card_filter = function(self, player, to_select, selected)
    -- local n = (self.interaction.data=="both") and 2 or 1
    
    if table.contains(player:getCardIds("h"), to_select)
      and  not player:prohibitResponse(to_select) 
    then
      local c =Fk:getCardById(to_select).color
      return Fk:getCardById(to_select).color~=Card.NoColor and ((#selected==0 )or (#selected==1 and c~=Fk:getCardById(selected[1]).color))
    end
  end,
  -- target_filter = = function(self, player, to_select, selected)
  --   if #selected ~= 0 then return end
  --   return table.contains(player:getCardIds("h"), to_select)
  --   and  not player:prohibitDiscard(to_select) 
  -- end,
  -- feasible = function (self, player, selected, selected_cards)
  --   return (self.interaction.data=="both" and #selected_cards ==2 )
  --   or (self.interaction.data~="both" and #selected_cards ==1)
  -- end,
  on_use = function(self, room, effect)
    local player =effect.from
    local to =effect.tos[1]

    local color=Fk:getCardById(effect.cards[1]).color
    room:throwCard(effect.cards, tszjetnziok_active.name,player,player)
    room:setPlayerMark(player,"_tszjetnziok_active",to.id)
    -- room:addPlayerMark(player,"_tszjetnziok_active-times-phase",1)

    local exec = function()
      if color == Card.Red then
        to:drawCards(to:getLostHp(),tszjetnziok_active.name)
        room:askToDiscard(to,{
            min_num = to:getLostHp()+1,
            max_num = to:getLostHp()+1,
            skill_name = tszjetnziok_active.name,
            include_equip = false,
            cancelable = false,
            skip=false,
          })

        -- room:setPlayerMark(player,"_tszjetnziok_active-color-phase",1)  --Card.Black== 1 止能用
        room:setPlayerMark(to,"@@tszjetnziok_active-reverse-round",1)
      elseif  color == Card.Black then
        room:recover{  --hp滿 當爲 recover prevented
          who = to,
          num = 1,
          recoverBy = player,
          skillName = tszjetnziok_active.name,
        }
        room:loseHp(to,1,tszjetnziok_active.name,effect.from)
        -- room:setPlayerMark(player,"_tszjetnziok_active-color-phase",2)
        room:setPlayerMark(to,"@@tszjetnziok_active-double-round",1)
      end

    end
    

    exec()
    if   to.hp<=(to.maxHp+1)//2 and not to.dead and not player:isKongcheng() then  --次數?
      color= color==Card.Red and Card.Black or Card.Red
      local theColor=table.filter(player:getCardIds("h"), function(id)
        return Fk:getCardById(id).color==color
      end)
      local discards = room:askToDiscard(player, {
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = tszjetnziok_active.name,
        prompt = "#tszjetnziok_active-discard",  --..color==Card.Red and "black" or "red"
        pattern=tostring(Exppattern{ id = theColor }),
        cancelable = true,
        skip = true,
      })
      if #discards>0 then
        room:throwCard(discards, tszjetnziok_active.name,player,player)
        exec()
      end
      -- room:askToUseActiveSkill(player,{
      --   skill_name=tszjetnziok_active.name,
      --   cancelable=true,
      --   skip=false,
      --   extra_data={
      --     target=to.id,
      --   }
      -- })
    end

  end,
})

return tszjetnziok_active
