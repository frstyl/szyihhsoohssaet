local quandzsios = fk.CreateSkill({
  name = "quandzsios",
})
Fk:loadTranslationTable{
  ["quandzsios"] = "援助",  --䘙生 養生
  [":quandzsios"] = "一脚色A失去冣后手牌後,伱可發動｡全體脚色可交与伱1牌,伱交与A x牌(x爲牌數伱因所此得)", 

  ["#quandzsios-invoke"] = "援助  交予 %src 牌",
  ["#quandzsios-choose"] = "援助  選擇發動目幖",

  ["$quandzsios1"] = "吾大軍援糧何在",
  -- ["$quandzsios2"] = "援助五十六縣皆爲我土",
}

quandzsios:addEffect(fk.AfterCardsMove, {  --褈復檢測受歬技能干擾
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)  --同旹
    if not   player:hasSkill(quandzsios.name)  then return end
    if event:getCostData(self)==nil then
      local ps={}
      for _, move in ipairs(data) do
        if move.from and  move.from:isKongcheng() then
          for _, info in ipairs(move.moveInfo) do
            if info.fromArea == Card.PlayerHand then
              table.insertIfNeed(ps, move.from)
            end
          end
        end
      end
      if #ps>0 then
        event:setCostData(self,{ps=ps})
      else
        event:setCostData(self,{ps=nil})
      end
    end
  
    return event:getCostData(self) and  event:getCostData(self).ps  


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
        prompt = "#quandzsios-choose",
        skill_name = quandzsios.name,
        cancelable = true,
      })

    elseif #tobe==1 then
      if player.room:askToSkillInvoke(player, {
            skill_name = quandzsios.name,
            prompt = "#quandzsios-invoke:"..tobe[1].id,
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
  -- on_cost = function(self, event, target, player, data)
  --   local to =event:getCostData(self).tos[1]
  --   if player.room:askToSkillInvoke(player, {
  --         skill_name = quandzsios.name,
  --         prompt = "#quandzsios-invoke:"..to.id,
  --       }) 
  --   then
  --         -- event:setCostData(self,{tos={to}})
  --         return true
  --   end
  -- end,
	on_use = function(self, event, target, player, data)
    local room=player.room
    local to =event:getCostData(self).tos[1]
    local targets=room:getOtherPlayers(to) 
    targets=table.filter(targets,function(p)
    return not p:isKongcheng()
    end)
    if #targets==0 then return end
    local result = room:askToJointCards(player, {
      players = targets,
      min_num = 1,
      max_num = 999,
      cancelable = true,
      skill_name = quandzsios.name,
      prompt = "#quandzsios-give::" .. to.id,
    })
    local moveInfos = {}
    for _, p in ipairs(targets) do
      table.insert(moveInfos, {
        ids = result[p],
        from = p,
        to = to,
        toArea = Card.PlayerHand,
        moveReason = fk.ReasonGive,
        proposer = p,
        skillName = quandzsios.name,
      })
    end
    room:moveCards(table.unpack(moveInfos))
  end,
})


return quandzsios
