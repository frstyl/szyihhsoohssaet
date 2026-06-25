local tszuohtszjens = fk.CreateSkill{
  name = "tszuohtszjens",
}

Fk:loadTranslationTable{
  ["tszuohtszjens"] = "主戰",
  [":tszuohtszjens"] = "任意角色A轉終,伱可發動｡若x>0,,伱令A抽x,否則伱視爲使用殺,止能選A攻程內角色｡(x爲A當轉使用殺次數)",  --將1牌轉化爲殺對A攻程內角色使用發動
  -- [":tszuohtszjens"] = "➀角色A轉終旹,若A于本轉內未使用殺,伱可預將1牌轉化爲殺,對A或A攻程內角色B使用發動.若A不爲伱,此殺結算畢旹,若其:{曾/未曾}致傷,伱可令A{弃1/交与B 1牌,A抽2}➁每轉終旹,若當前轉角色A本轉內使用過殺,伱可發動,令A抽1",

  ["#tszuohtszjens-ssaet"] = "主戰 %src轉終 是否使用殺",
  ["#tszuohtszjens-draw"] = "主戰 %src轉終 是否令其抽 %arg",

  -- ["#tszuohtszjens-discard-invoke"] = "主戰 是否令%src弃1",
  -- ["#tszuohtszjens-discard"] = "主戰 弃1",
  -- ["#tszuohtszjens-give-invoke"] = "主戰 是否交予%src1牌 伱抽2",
  -- ["#tszuohtszjens-give"] = "主戰 是否令%src弃1",

  ["$tszuohtszjens1"] = "旣不敢戰留伱何用",

}


tszuohtszjens:addEffect(fk.TurnEnd, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(tszuohtszjens.name) --and target:getMark("_tszuohtszjens-turn")~= 1  --0 未用 1用 2致傷
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local n = 0
    room.logic:getEventsOfScope(GameEvent.UseCard, 1, function (e)
      local dat=e.data
        if dat.from == target and dat.card.trueName=="ssaet" then
          n=n+1
        end
    end, Player.HistoryTurn)

    if n== 0 then


      local targets={}
      for _, p in ipairs(room.alive_players) do
        if  p==target or target:inMyAttackRange(p) then
          table.insert(targets, p.id)
        end
      end
      if #targets==0 then return end
      --  targets=table.map(targets,Util.IdMap)
      local use = room:askToUseVirtualCard(player, {
        name = "ssaet",
        skill_name = "tszuohtszjens",
        prompt = "#tszuohtszjens-ssaet:" .. target.id,
        cancelable = true,
        card_filter = {
        n = 0,
        -- cards = player:getCardIds("he"),
        },
        extra_data = {
          -- must_targets = {data.to.id},
          exclusive_targets = targets,  --id
          bypass_distances = true,
          bypass_times = true,
        },
        skip=true,
      })
      if use then
        use.extraUse = true
        event:setCostData(self,{tos = use.tos,n=n})
        return true
      end
    else
      if room:askToSkillInvoke(player,{
        skill_name = tszuohtszjens.name,
        prompt = "#tszuohtszjens-draw:" .. target.id.."::"..n,
      })
      then
        event:setCostData(self,{tos = {target},n=n})
        return true
      end
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local n = event:getCostData(self).n
    if n == 0 then
      local use =  event:getCostData(self).use
      room:useCard(use)

      -- if target==player then return end
      -- if use.damageDealt and use.damageDealt[use.tos[1]] then
      --   if  room:askToSkillInvoke(player,{
      --         skill_name = tszuohtszjens.name,
      --     prompt = "#tszuohtszjens-discard-invoke:"..target.id,
      --   }) 
      
      --   then --
      --     local cards = room:askToDiscard(target, {
      --       min_num = 1,
      --       max_num = 1,
      --       include_equip = true,
      --       skill_name = tszuohtszjens.name,
      --       cancelable = false,
      --       prompt = "#tszuohtszjens-discard",
      --       skip = false,
      --     })    
      --   end
      -- else
      --   if room:askToSkillInvoke(player,{
      --         skill_name = tszuohtszjens.name,
      --     prompt = "#tszuohtszjens-give-invoke:" .. use.tos[1].id,
      --   }) then
      --       local cards = room:askToCards(target, {
      --         min_num = 1,
      --         max_num = 1,
      --         skill_name = tszuohtszjens.name,
      --         pattern = ".",
      --         prompt = "#tszuohtszjens-give",
      --         cancelable = true,
      --       })
      --     if #cards > 0 then
      --       room:moveCardTo(cards, Player.Hand, use.tos[1], fk.ReasonGive, tszuohtszjens.name, nil, false, target.id)
      --       target:drawCards(2, tszuohtszjens.name)
      --     end
      --   end
      -- end
    else
      target:drawCards(n,tszuohtszjens.name)
    end
  end,
})



-- tszuohtszjens:addEffect(fk.CardUseFinished, {  --PreCardUse
--   can_refresh  = function(self, event, target, player, data)
--     return target==player.room:getCurrent() and data.card.trueName=="ssaet" and player:hasSkill(tszuohtszjens.name) 
--     and not (data.extra_data and data.extra_data.not_used)  --旋刀
--   end,
--   on_refresh = function(self, event, target, player, data)
--     player.room:addPlayerMark(target,"_tszuohtszjens-turn",1)
--   end,
-- })
return tszuohtszjens
