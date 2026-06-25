Fk:loadTranslationTable{
  ["thoucqdoat"] = "通达",
  [":thoucqdoat"] = "伱失去牌後發動,伱將牌堆頂x牌置于伱武將牌上,稱爲略(x爲伱所失牌數).主旹,伱選1項与1其它角色A,預弃3同花或3異花略發動➀予A2傷➁觀看A區域全部牌,弃其中2牌",

  ["#thoucqliak-active"] = "通达  默認傷害",

  ["#thoucqliak-discard"] = "通达 ",

  ["thoucqdoat_liak"] = "略",
  ["damage"] = "致傷 ",
}

local thoucqdoat = fk.CreateSkill{
  name = "thoucqdoat",
  -- tags = { Skill.Compulsory },
}

thoucqdoat:addEffect(fk.AfterCardsMove, {
  derived_piles = "thoucqdoat_liak",
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(thoucqdoat.name)  then return false end
    local n=0
    for _, move in ipairs(data) do
      if move.from ==player and (move.to~=player or not table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)) then
        for _, info in ipairs(move.moveInfo) do
          if   (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)   then
            n=n+1
          end
        end
      end
    end
    if n>0 then
      event:setCostData(self, {n=n})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
      player:addToPile("thoucqdoat_liak", player.room:getNCards(event:getCostData(self).n), true, thoucqdoat.name, player)
  end,
})

thoucqdoat:addEffect("active", {
  anim_type = "offensive",
  prompt = "#thoucqliak-active",
  target_num = 1,
  -- min_card_num = 3,
  -- max_card_num = 4,
  card_num=3,
  expand_pile = "thoucqdoat_liak",
  max_phase_use_time = 1,
  interaction = function(self, player)
    return UI.ComboBox {
      choices = {"damage","discard"},
    }
  end,
  card_filter = function(self, player, to_select, selected)--5 -< 7
    if  Self:getPileNameOfId(to_select) ~= "thoucqdoat_liak" then return false end
    if Fk:getCardById(to_select).suit==Card.NoSuit then return false end
    if #selected <2 then return true end
    if #selected >2  then return false end
    if not Fk:getCardById(selected[1]):compareSuitWith(Fk:getCardById(selected[2])) then 
      return 
        table.every(selected, function (id)
          return not Fk:getCardById(to_select):compareSuitWith(Fk:getCardById(id) )
        end)
    else  
        return Fk:getCardById(selected[1]):compareSuitWith(Fk:getCardById(to_select))
    end

  end,
  target_filter = function(self, player, to_select, selected, selected_cards)
      return #selected == 0 and to_select~=player
  end,
  on_use = function(self, room, effect)
    local target=effect.tos[1]
    room:moveCardTo(effect.cards, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, thoucqdoat.name, nil, true,  effect.from)
    if self.interaction.data=="damage" then
    room:damage{
      from = effect.from,
      to = target,
      damage = 2,
      damageType = 1,
      skillName = thoucqdoat.name,
    }
    else
      cards = room:askToChooseCards( effect.from, {
        target = target,
        min = 2,
        max = 2,
        -- flag = "he",
        flag = { card_data = {{ "$Hand", target:getCardIds("h") },{"$Equip", target:getCardIds("e")},{"$Judge", target:getCardIds("j")}} },  --可見
        skill_name = thoucqdoat.name,
        prompt = "#thoucqdoat-discard",
      })
        room:throwCard(cards, thoucqdoat.name, effect.tos[1], effect.from)
    end
  end,
})
return thoucqdoat
