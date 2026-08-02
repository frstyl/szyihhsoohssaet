local tsjasthoeojs = fk.CreateSkill {
  name = "tsjasthoeojs",
  tags={Skill.NotViewAs},
}
Fk:loadTranslationTable{
  ["tsjasthoeojs"] = "借貸",
  [":tsjasthoeojs"] = "伱可起動演練｢殺｣｢閃｣｢肉｣｢酒｣旹,伱可選擇一其它腳色A(手牌數大于1)發動,伱取得其2手牌,記錄A｡伱補段終,對每个記錄,若記錄腳色存活,伱選擇交与其2牌或受其1傷不可對其發動取技能｡冣後淸除記錄",

  ["#tsjasthoeojs-get"] = "借貸 取得 %dest 2手牌",
  ["#tsjasthoeojs-give"] = "借貸 交与 %dest 2手牌",
}


tsjasthoeojs:addEffect("viewas", {
  anim_type = "offensive",
  pattern = ".|.|.|.|ssaet,szjemh,nziuk,tsiuh",
  prompt = "#tsjasthoeojs",
  -- mute_card = true,
  -- handly_pile = true,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected == 0 and Fk:getCardById(to_select).color == Card.Red
  -- end,
  view_as = function(self, player, cards)
    return nil
  end,
  target_filter = function(self, player, to_select, selected, selected_cards, c, extra_data)
    return  #selected==0 
    and to_select~=player 
    and to_select:getHandcardNum()>1
    and not table.contains(player:getTableMark("@tsjasthoeojs_black"), to_select.id)
  end,
  feasible = function(self, player, selected, selected_cards, card)
    return #selected ~= 0
  end,
  on_use = function(self, room, cardUseEvent, card, params)  --beforeUse前 returun轉化起動信息  --cardUseEvent 實爲SkillUseData ,params handleUseCardParams is_response, card viewAs--beforeUse
    local player = cardUseEvent.from
    local to =cardUseEvent.tos[1]
    local cards = room:askToChooseCards(player, {
        target = to,
        min = 2,
        max = 2,
        flag = "h",
        skill_name = tsjasthoeojs.name,
        prompt = "#tsjasthoeojs-get::"..to.id
      })
    if #cards==2 then
      room:obtainCard(player, cards, true, fk.ReasonPrey, player, tsjasthoeojs.name)
      room:addTableMark(player,"tsjasthoeojs",to.id)
    end

    return tsjasthoeojs.name
  end,
  enabled_at_play = function(self, player) 
    return player:usedEffectTimes(tsjasthoeojs.name, Player.HistoryPhase) == 0
  end,
  enabled_at_response = function(self, player, response) 
    return  true
  end,
})


tsjasthoeojs:addEffect(fk.EventPhaseEnd, {
  can_trigger = function(self, event, target, player, data)  --雙向?
    return  player:getMark("tsjasthoeojs")~=0
    and player.phase==Player.Draw
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    for _, pid in ipairs(player:getMark("tsjasthoeojs")) do
      if player.dead then break end
      local to =room:getPlayerById(pid)
      if not to.dead then 
        local cards=room:askToCards(player, {
        min_num = 2,
        max_num = 2,
        skill_name = tsjasthoeojs.name,
        -- pattern = ,
        prompt = "#tsjasthoeojs-give::"..to.id,
        include_equip=true,
        cancelable = true,
        })
        if #cards~=2 then
          -- room:loseHp(player,1,tsjasthoeojs.name,player)
            room:damage{
            from = to,
            to = player,
            damage = 1,
            skillName = tsjasthoeojs.name,
          }
          room:addTableMarkIfNeed(player,"@tsjasthoeojs_black", to.id)
        else
          room:obtainCard(to, cards, true, fk.ReasonGive, player, tsjasthoeojs.name)
        end
      end

    end
    room:setPlayerMark(player,"tsjasthoeojs",nil)
  end,
})
return tsjasthoeojs
