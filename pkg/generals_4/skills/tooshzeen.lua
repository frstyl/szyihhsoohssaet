local tooshzeen = fk.CreateSkill {
  name = "tooshzeen",
}

Fk:loadTranslationTable{
  ["tooshzeen"] = "妬賢",
  [":tooshzeen"] = "其它脚色A于其補段外得牌後,若其在伱攻程內伱,伱可預打出1手牌發動.A選擇1項➀交予伱1♣️牌,流失1體力,取得伱所打出牌➁展示全部手牌,弃置其中點數不小于x者(x爲伱所打出牌之點數),若无伱弃1",


  ["#tooshzeen-invoke"] = "妬賢 %src抽牌 是否打打出♣牌發動",
  ["#tooshzeen-choose"] = "妬賢 選擇發動目幖",

  ["tooshzeen-get"] = "交予 %src ♣牌 流失1體力", --♠♥♣♦
  ["tooshzeen-show"] = "展示全部手牌,弃點數大于 %arg 者", --♠♥♣♦
  ["#tooshzeen-discard"] = "妬賢 弃1手牌",

  ["$tooshzeen1"] = "何人題下昰詩䛐在此",

  ["$tooshzeen2"] = "或六六之秊或六六之數",
  ["$tooshzeen3"] = "靑竹蛇兒口,黃蜂尾上刺",
  ["$tooshzeen4"] = "事非耦肰也",
  ["$tooshzeen5"] = "取來文策一察便知有无",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tooshzeen:addEffect(fk.AfterCardsMove, {
  trigger_times= function(self, event, target, player, data)
    return 999
  end,
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(tooshzeen.name)  then return end
    if event:getCostData(self) and event:getCostData(self).ps then
      return true
    end
      local tos={}
      for _, move in ipairs(data) do
        if  move.to
            and move.to.phase ~= Player.Draw
        -- and move.skillName~= "phase_draw" 
        -- and move.to ~=player and move.toArea == Card.PlayerHand 
        -- and move.moveReason==fk.ReasonDraw 
          and table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea) 
        then

          for _, info in ipairs(move.moveInfo) do
            if not (move.from==move.to and table.contains({Card.PlayerEquip,Card.PlayerHand }, info.fromArea) ) then
                table.insertIfNeed(tos, move.to)
            end
          end

        end
      end

    if #tos==0 then return end --同旹抽牌?
    event:setCostData(self,{ps=tos,choosed={}})
    return true
  end,
  on_cost = function(self, event, target, player, data)
    local ps = event:getCostData(self).ps or {}
    local choosed=event:getCostData(self).choosed or {}
    local targets=table.filter(ps,function(p)
        return  
        -- player~=p
        -- and 
        player:inMyAttackRange(p) 
        and not table.contains(choosed,p)
        -- and player:canPindian(p)
        end)
    if #targets==0 then
      event:setCostData(self, {ps=ps,choosed={}})
       return 
    end

    if #targets >1 then
      local tos, cards = player.room:askToChooseCardsAndPlayers(player, {
        min_card_num = 1,
        max_card_num = 1,
        include_equip=false,
        -- will_throw=true,
        min_num = 1,
        max_num = 1,
        targets = targets,  --
        -- targets=player.room.alive_players,
        pattern = tostring(Exppattern{ id = table.filter(player:getHandlyIds(), function (id)
        return not player:prohibitResponse(Fk:getCardById(id))
      end)}),
        skill_name = tooshzeen.name,
        prompt = "#tooshzeen-choose",
        cancelable = true,
      })
      if #tos > 0 and #cards > 0 then
        table.insertIfNeed(choosed,tos[1])
        event:setCostData(self, {ps=ps,choosed=choosed,tos = tos, cards = cards,})
        return true
      end
    else
      local cards = S.askToPlayCard(player,{
        min_num=1,
        max_num=1,
        pattern=".",
        include_equip=false,
        prompt="#tooshzeen-invoke:"..targets[1].id,
        skill_name = tooshzeen.name,
        cancelable = true,
        skip = true,
      })
      if #cards>0 then
        event:setCostData(self, {ps=ps,choosed=ps, tos = targets,cards=cards})
        return true
      end
    end

    event:setCostData(self, {ps=ps,choosed={}})

  end,
  on_use = function(self, event, target, player, data)
    local room = player.room    
    local to=event:getCostData(self).tos[1]
    local card=Fk:getCardById(event:getCostData(self).cards[1])
    S.playCard(player,{card.id},tooshzeen.name)
    if to.dead then return end

    local yes, dat = room:askToUseActiveSkill(to, {
    skill_name = "tooshzeen_active",
    prompt = "#tooshzeen-choose:"..player.id,
    cancelable = true,
    skip = true,  --不執行
    extra_data=
    {from=player.id,
    number=card.number
    },
  })

    if yes and #dat.cards == 1 then
      room:obtainCard(player, dat.cards, true, fk.ReasonGive, to, tooshzeen.name)
      room:loseHp(to, 1, tooshzeen.name,player)
      if to.dead  then return end

      local ids ={card.id}
      ids= table.filter(ids, function (id)
        return table.contains(player.room.discard_pile, id)
      end)
      ids = player.room.logic:moveCardsHoldingAreaCheck(ids)
      if #ids~=1 then return end
      room:obtainCard(to,ids, true, fk.ReasonPrey, nil, tooshzeen.name)
    else 
      local cards=to:getCardIds("h")
      to:showCards(cards)
      if to.dead then return end

      local n =card.number
      cards=table.filter(cards,function(id)
      return Fk:getCardById(id).number>=n
      end)
      if #cards>0 then
        room:throwCard(cards, tooshzeen.name, to,to)
      else
        if  player.dead then return end
        room:askToDiscard(player, {
          min_num = 1,
          max_num = 1,
          include_equip = false,
          skill_name = tooshzeen.name,
          cancelable = true,
          prompt = "#tooshzeen-discard",
          skip = false
        })
        
      end
    end

  end,
})


return tooshzeen
