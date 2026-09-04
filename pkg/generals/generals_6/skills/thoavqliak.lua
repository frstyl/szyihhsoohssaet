local thoavqliak = fk.CreateSkill({
  name = "thoavqliak",
})

Fk:loadTranslationTable{
  ["thoavqliak"] = "韜略",
  [":thoavqliak"] = "主旹或伱受傷後,伱可与1其它脚色賭鬥發動｡贏腳色選擇1項伱執行➀伱移動場上1牌(置入對應區域替換元牌)➁伱取得雙方賭鬥牌｡若平,伱自弃1",

  ["#thoavqliak"] = "韜略：与一名脚色拼点，若赢，迻動場上1牌",

  -- ["#thoavqliak-discard"] = "韜略： 弃1手牌",
  ["thoavqliak-move"] = "移動場上1牌",
  ["thoavqliak-get"] = "取得賭鬥牌",
  ["#thoavqliak-win"] = "韜略 令 %src 執行1項",
  ["#thoavqliak-discard"] = "韜略 平局 弃1",
  ["#thoavqliak-choose"] = "韜略： 選擇脚色",

  ["$thoavqliak1"] = "韜略傳家遠弊平地能擒虎",

}

thoavqliak:addEffect("active", {
  anim_type = "offensive",
  prompt = "#thoavqliak",
  max_phase_use_time = 1,
  min_card_num = 0,
  max_card_num = 1,
  target_num = 1,
  can_use = function(self, player)
    return not player:isKongcheng() and player:usedSkillTimes(thoavqliak.name, Player.HistoryPhase) == 0
  end,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getCardIds("h"), to_select)
  end,
  target_filter = function(self, player, to_select, selected, selected_cards)
    return #selected == 0 and to_select ~= player and player:canPindian(to_select)
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = effect.tos[1]
    local pindian = player:pindian({target}, thoavqliak.name,effect.cards[1] and Fk:getCardById(effect.cards[1]) or nil)
    if player.dead then return end
    if pindian.results[target].winner==nil then
        room:askToDiscard(player, {
          min_num = 1,
          max_num = 1,
          include_equip = false,
          skill_name = thoavqliak.name,
          cancelable = false,
          prompt = "#thoavqliak-discard",
          skip = false,
        })
      return
    end
    local choice=room:askToChoice(pindian.results[target].winner, {
      choices = {"thoavqliak-get","thoavqliak-move"},
      skill_name = thoavqliak.name,
      prompt="#thoavqliak-win:"..player.id
    })
    if  choice=="thoavqliak-move" then
      local to = room:askToChoosePlayers(player, {
          targets = table.filter(room.alive_players ,function(p)
          return  #p:getCardIds("ej")>0
          end),
          min_num = 1,
          max_num = 1,
          prompt = "#thoavqliak-choose",
          skill_name = thoavqliak.name,
          cancelable = true,
        })
      if #to~=1 then return end
      local cid = room:askToChooseCard(player, { target = to[1], flag = "ej", skill_name = thoavqliak.name })    
      
      local to2 = room:askToChoosePlayers(player, {
          targets = table.filter(room.alive_players ,function(p)
          return  p~=to
          end),
          min_num = 1,
          max_num = 1,
          prompt = "#thoavqliak-choose",
          skill_name = thoavqliak.name,
          cancelable = true,
        })
      if #to2~=1 then return end
      if room:getCardArea(cid)==Card.PlayerEquip then
          room:moveCardIntoEquip(to2[1], cid, thoavqliak.name, true, player)  --player?why not id
      else
      -- local cardToMove = room:getCardOwner(cid):getVirualEquip(cid) or Fk:getCardById(cid)
        room:moveCardTo({cid},Card.PlayerJudge,to2[1], Fk.ReasonPut, thoavqliak.name,nil,true,player)
      end
    else
      local to_get={}
      local cid = pindian.fromCard and pindian.fromCard:getEffectiveId()
      if room:getCardArea(cid) == Card.DiscardPile then
        table.insert(to_get, cid)
      end

      local toCard = pindian.results[target].toCard
      cid = toCard and toCard:getEffectiveId()
      if room:getCardArea(cid) == Card.DiscardPile then
        table.insertIfNeed(to_get, cid)
      end
      if #to_get > 0 then
        room:obtainCard(player, to_get, true, fk.ReasonPrey, player, "thoavqliak")
      end

    end
  end,
})

thoavqliak_spec={
  on_cost = function (self, event, target, player, data)
    local room = player.room
    local success, dat = room:askToUseActiveSkill(player, {
      skill_name = "thoavqliak",
      prompt = "#thoavqliak:::"..(player:getLostHp()+1),
      cancelable = true,
      skip = true,
    })
    if success and dat then
      event:setCostData(self, {tos = dat.targets})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local tos = event:getCostData(self).tos
    local skill = Fk.skills["thoavqliak"]
    skill.interaction = skill.interaction or {}
    skill:onUse(player.room, {  --useSkill
      from = player,
      tos = tos,
    })
  end,
}


thoavqliak:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function (self, event, target, player, data)
    return target == player and player:hasSkill(thoavqliak.name)
  end,
  on_cost = thoavqliak_spec.on_cost,
  on_use = thoavqliak_spec.on_use,
})

return thoavqliak
