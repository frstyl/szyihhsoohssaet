local szioqnoans = fk.CreateSkill{
  name = "szioqnoans",
}

Fk:loadTranslationTable{
  ["szioqnoans"] = "紓難",
  [":szioqnoans"] = "其它腳色起動進攻牌對目幖脚色生效前,伱可發➀發動,抽1,將目幖轉爲伱(目幖爲伱不可選)➁(需爲僅存目幖)打出1牌發動,此牌對目幖无效,若此牌不爲轉化/虛擬牌將將其迻除遊戲.轉終,起動者獲得之｡",

  ["#szioqnoans-invoke"] = "紓難 %src 對 %dest 起動 %arg，伱可發動",

  ["szioqnoans_transfer"] = "抽1 轉于伱",
  ["szioqnoans_recycle"] = "打出1 无效",

  ["$szioqnoans1"] = "且慢",  --
  -- ["$szioqnoans1"] = "慢著,不要輕動",  --
  ["$szioqnoans2"] = "待俺尋思尋思",
  ["$szioqnoans3"] = "緟新開始夫",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


szioqnoans:addEffect(fk.PreCardEffect, {  --PreCardEffect --TargetSpecifying TargetConfirming
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(szioqnoans.name)
	and data.from --
	and data.from~=player
	and data.to
    and
    S.isAttackCard(data.card.name)
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
	local t={}
	if data:isOnlyTarget(data.to) then table.insert(t,"szioqnoans_recycle") end
	if data.to~=player then table.insert(t,"szioqnoans_transfer") end
	if #t==0 then return end
    local success, dat = room:askToUseActiveSkill(player, {
      skill_name = "szioqnoans_active",
      prompt = "#szioqnoans-invoke:"..data.from.id..":"..data.to.id..":"..data.card:toLogString(),
      cancelable = true,
      extra_data = {
        -- from = data.from.id,
        -- to=data.to.id,
        -- card = data.card:toLogString(),
		choices=t,
      }
    })
    if success and dat then
      event:setCostData(self, {tos = {data.from}, choice = dat.interaction, cards = dat.cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    -- data.extra_data =  data.extra_data or {}
    -- data.extra_data.szioqnoans= data.extra_data.szioqnoans or {}
    -- data.extra_data.szioqnoans[player.id]=true
    local choice = event:getCostData(self).choice

    if choice:startsWith("szioqnoans_transfer") then
      -- data.target=player
      -- data.to=player
      -- if not player.dead then
      --   player:drawCards(1, szioqnoans.name)
      -- end
	  player:drawCards(1,szioqnoans.name)
	  data.to=player
      -- data:cancelTarget(target)
      -- if not player.dead then --not data.from:isProhibited(player, data.card) an
        -- data:addTarget(player)
      -- end
    else
	    S.playCard(event:getCostData(self).cards, szioqnoans.name,player)
      -- data.nullifiedTargets = table.simpleClone(room.players)
      S.effectNullify(data)
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
