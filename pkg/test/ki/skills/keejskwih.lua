local keejskwih = fk.CreateSkill({
  name = "keejskwih",
})
Fk:loadTranslationTable{
  ["keejskwih"] = "繼晷",  --䘙生 養生
  [":keejskwih"] = "一脚色A 一次失去不少于2牌後,伱可發動｡伱流失1,令A抽2,",  --被取得算2

  ["#keejskwih-invoke"] = "繼晷  令 %src 抽2",
  ["#keejskwih-choose"] = "繼晷  選擇發動目幖",

  ["$keejskwih1"] = "兵精將猛山川險峻獨霸一方",
  ["$keejskwih2"] = "援助五十六縣皆爲我土",
}

keejskwih:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if event:getCostData(self)==nil then
      local t={}
      for _, move in ipairs(data) do
        if move.from  and (move.to~=move.from  or not table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)) then
          for _, info in ipairs(move.moveInfo) do
            if   (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)   then
              t[move.from.id] = (t[move.from.id] or 0) +1
            end
          end
        end
      end

      local ps={}
      local room=player.room
      for i,n in pairs(t) do
        if n>1 then
        table.insertIfNeed(ps, room:getPlayerById(i))
        end
      end

      if #ps>0 then
        event:setCostData(self,{ps=ps})
      else
        event:setCostData(self,{ps=nil})
      end
    end

    return event:getCostData(self) and  event:getCostData(self).ps  
    and player:hasSkill(keejskwih.name) 

  end,
  trigger_times= function(self, event, target, player, data)
    return 999
  end,
  on_cost = function(self, event, target, player, data)

    local choosed= event:getCostData(self).choosed or {}
    local ps =event:getCostData(self).ps
    local tobe = table.filter(ps,function(p)
      return not table.contains(choosed,p)
    end)
    if #tobe==0 then  event:setCostData(self, {ps=ps}) return end

    local to ={}
    if #tobe >1 then
       to = player.room:askToChoosePlayers(player, {
        targets = tobe,
        min_num = 1,
        max_num = 1,
        prompt = "#keejskwih-choose",
        skill_name = keejskwih.name,
        cancelable = true,
      })

    elseif #tobe==1 then
      if player.room:askToSkillInvoke(player, {
            skill_name = keejskwih.name,
            prompt = "#keejskwih-invoke:"..tobe[1].id,
          }) 
      then
        to=tobe
      end
    end

      if #to > 0 then
        table.insertIfNeed(choosed,to[1])
        event:setCostData(self, {ps=ps,tos = to,choosed=choosed})
        -- self:use(event, target, player, data)
        -- self:doCost(event, target, player, data)
        return true
      else
        event:setCostData(self, {ps=ps})
      end

  end,

	on_use = function(self, event, target, player, data)
    -- local room=player.room
    player.room:loseHp(player,1,keejskwih.name,player)
    local to =event:getCostData(self).tos[1]
    to:drawCards(2)
  end,
})


return keejskwih
