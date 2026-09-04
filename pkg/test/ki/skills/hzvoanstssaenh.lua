local hzvoanstssaenh = fk.CreateSkill {
  name = "hzvoanstssaenh",
  tags={Skill.Switch}
}

Fk:loadTranslationTable{  --分爲4?
["hzvoanstssaenh"] = "換盞",--1/4換盞  --抑揚
[":hzvoanstssaenh"] = "輪流發動｡伱失去牌後,伱可發動.伱占卜,占卜牌生效後,若其爲{➀紅/➁黑},伱起動之,否則取得之｡",

["#hzvoanstssaenh-invoke"] = "換盞 起動牌",

}


hzvoanstssaenh:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(hzvoanstssaenh.name) then return end
    local areas={Card.PlayerEquip,Card.PlayerHand  }
    for _, move in ipairs(data) do
      if move.from ==player and (move.to~=player or not table.contains(areas, move.toArea)) then
        for _, info in ipairs(move.moveInfo) do
          if table.contains(areas, info.fromArea)  then
            return true
          end
        end
      end
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
      local judge = {
        who = player,
        reason = hzvoanstssaenh.name,
        -- pattern = ".|.|"..
        pattern= player:currentSwitchState()==fk.SwitchYang and ".|.|red" or ".|.|black"
      }
      room:judge(judge)
  end,
})

hzvoanstssaenh:addEffect(fk.FinishJudge, {
  mute = true,
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    return target == player and not player.dead and data.reason == hzvoanstssaenh.name 
    and  player.room:getCardArea(data.card) == Card.Processing
    and data:matchPattern()
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    local cards= {data.card.id}
    local use = player.room:askToUseRealCard(player, {
      skill_name = hzvoanstssaenh.name,
      prompt = "#hzvoanstssaenh-invoke",
      pattern = tostring(Exppattern{ id = cards }),
      cancelable = false,
      extra_data = {
        expand_pile = cards,
        bypass_times=true,
        extraUse=true,
      },
      skip = false,
    })
    if not use then
      player.room:obtainCard(player, data.card, true, fk.ReasonPrey, nil, hzvoanstssaenh.name)
    end
  end,
})

return hzvoanstssaenh
