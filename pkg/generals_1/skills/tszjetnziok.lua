local tszjetnziok = fk.CreateSkill {
  name = "tszjetnziok",
}
Fk:loadTranslationTable{
  ["tszjetnziok"] = "折辱",
  [":tszjetnziok"] = "其它角色A轉始旹,若其已損伱可選1項發動(半損可選2項).{➀/➁}打出1{黑/紅}牌,至A下轉始,其體力變化{翻倍/反轉}",

  ["#tszjetnziok_invoke"] = "折辱： 打出1{黑/紅}牌令 %src 體力變化{翻倍/反轉}",
  ["#tszjetnziok_active"] = "折辱： 黑翻倍 紅反轉",
  -- ["@@tszjetnziok-inarea"] = "折辱",
  -- ["#tszjetnziok-discard"] = "折辱： 執行別一項 ",

  ["both"] = "兼選",


  ["@@tszjetnziok_reverse"] = "反轉",
  ["@@tszjetnziok_double"] = "翻倍",
  ["#HpChangeReverse"] = "由于 %arg 效果，%from 體力變化值反轉",
  ["#HpChangeDouble"] = "由于 %arg 效果，%from 體力變化值翻倍",

  ["$tszjetnziok1"] = "林敎頭洗腳夫",
}


-- tszjetnziok:addEffect(fk.EventPhaseStart, {
--   can_trigger = function(self, event, target, player, data)
--     return target ~= player and player:hasSkill(tszjetnziok.name) 
--     and target:isWounded() and data.phase==Player.Start
--     and not player:isKongcheng()
--   end,

-- })

tszjetnziok:addEffect(fk.TurnStart, {
	can_refresh = function(self, event, target, player, data)
    return player==target and ( player:getMark("@@tszjetnziok_double")>0  or  player:getMark("@@tszjetnziok_reverse")>0 )
  end,
	on_refresh = function(self, event, target, player, data)
    player.room:setPlayerMark(effect.tos[1],"@@tszjetnziok_double",0)
    player.room:setPlayerMark(effect.tos[1],"@@tszjetnziok_reverse",0)
  end,
  can_trigger = function(self, event, target, player, data)
    return target ~= player and player:hasSkill(tszjetnziok.name) 
    and target:isWounded()
    and not player:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    local half = (target.hp<=((target.maxHp+1)//2))

    -- if half then half= true end
    local yes, dat = room:askToUseActiveSkill(player, {  --askToChooseCardsAndPlayers 等實調用此 askToUseActiveSkill
      skill_name = "tszjetnziok_active",
      prompt = "#tszjetnziok_invoke:"..target.id,
      cancelable = true,
      skip = true,  --不執行
      extra_data={
        half= half,
      },
    })
    if yes and dat then
      event:setCostData(self, {cards = dat.cards, tos = {target}})--, choice = dat.interaction
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local effect= event:getCostData(self)
    -- room:throwCard(effect.cards, tszjetnziok.name,player,player)
    local c1=Fk:getCardById(effect.cards[1])
    local c2=effect.cards[2] and Fk:getCardById(effect.cards[2])
    local red,black
    if c1.color==Card.Red then red=c1  black=c2 else  red=c2  black=c1 end



    if player.dead then return end
    if black  then
      player.room:responseCard({
        card=black,
        from=player,
        attachedSkillAndUser={muteCard=true},
      })
      room:setPlayerMark(effect.tos[1],"@@tszjetnziok_double",1)
    end

    if player.dead then return end
    if red then
      player.room:responseCard({
        card=red,
        from=player,
        attachedSkillAndUser={muteCard=true},
      })
      room:setPlayerMark(effect.tos[1],"@@tszjetnziok_reverse",1)
    end
  end,
})

tszjetnziok:addEffect(fk.BeforeHpChanged, {  --𢧵胡  --滿hp回復會中止  --回復不觸發瀕死
  priority=-999,
	can_trigger = function(self, event, target, player, data)
    -- return #card:getMark("@@tszjetnziok-inarea")>0
    return target==player 
    and ( player:getMark("@@tszjetnziok_double")>0  or  player:getMark("@@tszjetnziok_reverse")>0 )
  end,
	on_trigger = function(self, event, target, player, data)
    -- local data=table.simpleClone(data)
    if player:getMark("@@tszjetnziok_double")>0 then
      data.num=2*data.num
      player.room:sendLog{ type = "#HpChangeDouble", from = data.who.id, arg = tszjetnziok.name }
    end  
    if player:getMark("@@tszjetnziok_reverse")>0 then
      -- data.who.hp =data.who.hp -2* data.num  --无旹機 不致死
      data.num=-data.num
      data.reason=nil  --bug 待改
      -- data.num=0-data.num  --hp, assert(not (data.reason == "recover" and data.num < 0))
      player.room:sendLog{ type = "#HpChangeReverse", from = data.who.id, arg = tszjetnziok.name }
    end
  end,
})

return tszjetnziok
