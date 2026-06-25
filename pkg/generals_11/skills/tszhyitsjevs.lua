local tszhyitsjevs = fk.CreateSkill {
  name = "tszhyitsjevs",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["tszhyitsjevs"] = "出鞘",
  [":tszhyitsjevs"] = "當伱指定成爲殺目幖後,伱可選擇1項執行發動➀緟鑄x手牌➁將手牌抽至x(x爲體力上限)",  --无效果

  ["#tszhyitsjevs-invoke"] = "出鞘 選擇緟鑄牌 若爲0則抽牌至體力上限",
}

local tszhyitsjevs_spec = {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(tszhyitsjevs.name) and data.card.trueName=="ssaet"
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local yes, ret = room:askToUseActiveSkill(player, {
      skill_name = "choose_cards_skill", 
      prompt = "#tszhyitsjevs-invoke", 
      cancelable = true, 
      extra_data = {
        num = player.maxHp,
        min_num = 0,
        include_equip = false,
        skillName = tszhyitsjevs.name,
        pattern = ".",
      }, 
      no_indicate = false,
      skip=true,
    })
    if yes then 
      event:setCostData(self, {cards = ret.cards})
      return true
    end
  end,  
  on_use = function(self, event, target, player, data)
    local room=player.room
    local cards =  event:getCostData(self).cards
    if  #cards~=3 then
      local num = player.maxHp - player:getHandcardNum()
      if num > 0 then
        player:drawCards(num, tszhyitsjevs.name)
      end
    else 
      room:recastCard(cards, player, tszhyitsjevs.name)
    end
  end,
}

-- tszhyitsjevs:addEffect(fk.TargetSpecified, tszhyitsjevs_spec)

tszhyitsjevs:addEffect(fk.TargetConfirmed, tszhyitsjevs_spec)

return tszhyitsjevs
