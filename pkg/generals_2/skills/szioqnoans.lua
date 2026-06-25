local szioqnoans = fk.CreateSkill{
  name = "szioqnoans",
}

Fk:loadTranslationTable{
  ["szioqnoans"] = "紓難",
  [":szioqnoans"] = "一進攻牌對目幖角色生效前,若使用者不爲伱且目幖數等于1,伱可預打出1牌發動.伱選擇1項➀將目幖轉爲伱(目幖爲伱不可選)➁此牌對目幖无效,若此牌不爲轉化牌將將其迻除遊戲.轉終,使用者得之 ",

  ["#szioqnoans-invoke"] = "紓難 %src 對 %dest 使用 %arg，伱可打出1牌發動",

  ["szioqnoans_transfer"] = "抽1并將%arg轉于伱",
  ["szioqnoans_recycle"] = "无效%arg，轉終%dest 收回之",

  ["$szioqnoans1"] = "且慢",  --
  -- ["$szioqnoans1"] = "慢著,不要輕動",  --
  ["$szioqnoans2"] = "待俺尋思尋思",
  ["$szioqnoans3"] = "緟新開始夫",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


szioqnoans:addEffect(fk.TargetConfirming, {  --PreCardEffect --TargetSpecifying TargetConfirming
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if 
    data.from~=player
    and
    S.isAttackCard(data.card.name)
    and player:hasSkill(szioqnoans.name) --
    and data:isOnlyTarget(data.to) 
    and data.to.hp <= player.hp then
      if(data.extra_data==nil or data.extra_data.szioqnoans==nil or data.extra_data.szioqnoans[player.id]==nil)  then

        return true
      end
    end
    -- and (data.extra_data==nil or data.extra_data.szioqnoans==nil or data.extra_data.szioqnoans[player.id]==nil)
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local success, dat = room:askToUseActiveSkill(player, {
      skill_name = "szioqnoans_active",
      prompt = "#szioqnoans-invoke:"..data.from.id..":"..data.to.id..":"..data.card:toLogString(),
      cancelable = true,
      extra_data = {
        from = data.from.id,
        to=data.to.id,
        card = data.card:toLogString(),
      }
    })
    if success and dat then
      event:setCostData(self, {tos = {target}, choice = dat.interaction, cards = dat.cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    data.extra_data =  data.extra_data or {}
    data.extra_data.szioqnoans= data.extra_data.szioqnoans or {}
    data.extra_data.szioqnoans[player.id]=true
    local choice = event:getCostData(self).choice
    -- room:throwCard(event:getCostData(self).cards, szioqnoans.name, player, player)
    room:responseCard({
				card=Fk:getCardById(event:getCostData(self).cards[1]),
				from=player,
				attachedSkillAndUser={muteCard=true},
			})

    if choice:startsWith("szioqnoans_transfer") then
      -- data.target=player
      -- data.to=player
      -- if not player.dead then
      --   player:drawCards(1, szioqnoans.name)
      -- end
      data:cancelTarget(target)
      if not player.dead then --not data.from:isProhibited(player, data.card) an
        data:addTarget(player)
      end
    else
      -- data.nullifiedTargets = table.simpleClone(room.players)
      S.effectNullify(data.use)
      if not data.from.dead and not data.card:isVirtual() and room:getCardArea(data.card) == Card.Processing then
        data.from:addToPile(szioqnoans.name, data.card, true, szioqnoans.name)
      end
    end
  end,
})

szioqnoans:addEffect(fk.TurnEnd, {
  mute = true,
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    return #player:getPile(szioqnoans.name) > 0
  end,
  on_cost = Util.TrueFunc,
  on_use = function(self, event, target, player, data)
    player.room:moveCardTo(player:getPile(szioqnoans.name), Card.PlayerHand, player, fk.ReasonJustMove)
  end,
})


return szioqnoans
