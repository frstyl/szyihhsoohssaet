local deecstsshaek = fk.CreateSkill {
  name = "deecstsshaek",
}

Fk:loadTranslationTable{
  ["deecstsshaek"] = "定策",
  [":deecstsshaek"] = "輪限1.一角色A主段始旹,伱可發動.伱視爲使用[廟算于先],若A不爲伱,伱選擇1卽旹錦囊交予A,當段內A使用此牌伱可爲其增加1合理目幖",

  ["@@deecstsshaek-phase"] = "定策",

  ["#deecstsshaek-invoke"] = "定策 %src 轉段始",
  ["#deecstsshaek-choose"] = "定策 選擇牌交予 %src",
  ["#deecstsshaek-targets"] = "定策 爲%arg 增減目幖",


  ["$deecstsshaek1"] = "小弚有一計",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

deecstsshaek:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return  data.phase==Player.Play and player:hasSkill(deecstsshaek.name) and  player:usedSkillTimes(deecstsshaek.name, Player.HistoryRound) == 0 

  end,
  on_cost = function(self, event, target, player, data)
    if player.room:askToSkillInvoke(player, {
      skill_name = deecstsshaek.name,
      prompt = "#deecstsshaek-invoke:"..target.id,
    })  then
      event:setCostData(self, {tos = {target}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    room:useVirtualCard("mxevs_svoans_quo_seen", nil, player, {player}, deecstsshaek.name, true)
    if player.dead  then return end

    if target~=player then
      local cards = room:askToCards(player, {
        min_num = 1,
        max_num = 1,
        include_equip = false,
        prompt = "#deecstsshaek-choose:"..target.id,
        skill_name = deecstsshaek.name,
        pattern = tostring(Exppattern{ id = table.filter(player:getHandlyIds(), function (id)
          return S.isCommonTrick(Fk:getCardById(id))
         end)}),
        cancelable = false,
      })
      if #cards==0 then return end
      -- room:setPlayerMark(player,"@deecstsshaek-phase",{cid=cards[1],to=target.id})
      -- room:setCardMark(Fk:getCardById(cards[1]),{"@@deecstsshaek-phase",player.id} )
      room:moveCardTo(cards, Player.Hand, target, fk.ReasonGive, deecstsshaek.name, nil, false, player.id,{"@@deecstsshaek-phase",player.id})

      -- if target.dead then return end
    end

      -- local use=room:askToUseRealCard(target, {
      --   pattern = cards,
      --   skill_name = deecstsshaek.name,
      --   prompt = "#deecstsshaek-use",
      --   extra_data = {
      --     bypass_times = false,
      --     extraUse = false,
      --     expand_pile = cards,
      --     deecstsshaek=player.id
      --   },
      -- })
      -- if use and not player.dead then
      --   local choice = room:askToChoice(player, {
      --     choices = {"add","minus","Cancel"},
      --     skill_name = deecstsshaek.name,
      --   })

      --   if choice=="add" then 
      --     local to  = room:askToChoosePlayers(player, {
      --       targets = table.filter(room.alive_players,function(p)
      --         return not table.contains(use.tos,p) and target:canUseTo(use.card)
      --       end),
      --       min_num = 1,
      --       max_num = 1,
      --       prompt = "#deecstsshaek-tos:::"..use.card:toLogString(),
      --       skill_name = deecstsshaek.name,
      --       cancelable = true,
      --     })
      --     use:addTarget(to[1])
      --   elseif choice=="minus"  then
      --     local to  = room:askToChoosePlayers(player, {
      --       targets = use.tos,
      --       min_num = 1,
      --       max_num = 1,
      --       prompt = "#deecstsshaek-tos:::"..use.card:toLogString(),
      --       skill_name = deecstsshaek.name,
      --       cancelable = true,
      --     })
      --      use:removeTarget(to[1])
      --   else

      --   end
      --   room:useCard(use) 
      -- end
  end,
})
deecstsshaek:addEffect(fk.AfterCardTargetDeclared, {
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return data.card:getMark("@@deecstsshaek-phase") ==player.id
    -- return player:getMark("@deecstsshaek-phase")~=0 and player:getMark("@deecstsshaek-phase").cid ==data.card.id and player:getMark("@deecstsshaek-phase").to==target.id 
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    -- room:setCardMark(data.card, "@deecstsshaek-phase", 0)
    local targets = data:getExtraTargets({bypass_distances = false})
    table.insertTable(targets, data.tos)
    local to = room:askToChoosePlayers(player, {
      skill_name = deecstsshaek.name,
      min_num = 1,
      max_num = 1,
      targets = targets,
      prompt = "#deecstsshaek-targets:::"..data.card:toLogString(),
      cancelable = true,
      extra_data = table.map(data.tos, Util.IdMapper),
      target_tip_name = "addandcanceltarget_tip",
    })
    if #to > 0 then
      to = to[1]
      if table.contains(data.tos, to) then
        data:removeTarget(to)
      else
        data:addTarget(to)
      end
    end
  end,
})
return deecstsshaek
