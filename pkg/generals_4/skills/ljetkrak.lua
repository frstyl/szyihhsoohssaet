
local ljetkrak = fk.CreateSkill{
  name = "ljetkrak",
}
Fk:loadTranslationTable{
["ljetkrak"] = "烈戟",
[":ljetkrak"] = "補段終旹,預弃1牌發動,伱越過主段弃段,視爲使用1殺,此殺无視次數距離,目標上限+1,結算期閒伱无視防具,此殺致傷旹,伱可使用1非轉化手牌",

["#ljetkrak-choose"] = "烈戟 選擇所弃牌 与殺目幖 自動迻除不合理目幖",
["#ljetkrak-use"] = "烈戟 伱可使用1牌",
}


ljetkrak:addEffect(fk.EventPhaseEnd, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ljetkrak.name) and player.phase == Player.Draw
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    --   local targets = table.filter(room:getOtherPlayers(player, false), function (p)
    --   return player:canUseTo(Fk:cloneCard("ssaet"), p, {bypass_distances = true, bypass_times = true})
    -- end)
      local tos, cards = room:askToChooseCardsAndPlayers(player, {
        min_num = 1,
        max_num = 2,
        min_card_num = 1,
        max_card_num = 1,
        targets = room:getOtherPlayers(player, false),
        pattern = ".|.|.",
        skill_name = ljetkrak.name,
        prompt = "#ljetkrak-choose",
        cancelable = true,
        will_throw = true,
      })
    if #tos>0 and #cards>0 then
        event:setCostData(self, {targets = tos, cards = cards})  --not tos
        return true
    end
    end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    player:skip(Player.Play)
    player:skip(Player.Discard)
    local targets = event:getCostData(self).targets
    -- room:sortByAction(targets)

    room:throwCard(event:getCostData(self).cards, ljetkrak.name, player, player)
    player.room:addPlayerMark(player, "@@ignoreArmor",1)
    player.room.logic:getCurrentEvent():findParent(GameEvent.SkillEffect, true):addCleaner(function()
        player.room:removePlayerMark(player, "@@ignoreArmor",1)
    end)
    room:useVirtualCard("ssaet", nil, player, targets, ljetkrak.name, true)  --zzin souk


  end,
})

-- ljetkrak:addEffect(fk.TargetSpecified, {  --青鋼
--   can_trigger = function(self, event, target, player, data)
--     return target == player  and data.card
--     and table.contains(data.card.skillNames, ljetkrak.name)
--     and not data.to.dead
--   end,
--   on_trigger = function(self, event, target, player, data)

--     player.room:addPlayerMark(, "@@punsmuoh-MarkArmorNullified-phase",1)

--       player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true):addCleaner(function()
--          player.room:removePlayerMark(data.to,"@@punsmuoh-MarkArmorNullified-phase", 1) 
--          end
--       )
--   end,
-- })

ljetkrak:addEffect(fk.Damage, {  --致傷用牌
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    if target == player and data.card 
    -- and data.card.trueName == "ssaet" 
    and table.contains(data.card.skillNames, ljetkrak.name)  then  --傷源未必爲使用者 使用者未必爲技能發動者
      local e = player.room.logic:getCurrentEvent().parent
      while e do
        if e.event == GameEvent.SkillEffect then
          local dat = e.data
          if dat.skill.name == ljetkrak.name and dat.who == player then
            return true
          end
        end
        e = e.parent
      end
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local use = player.room:askToUseRealCard(player, {
      -- pattern = Player.Hand,  --被封
      skill_name = ljetkrak.name,
      prompt = "#ljetkrak-use",
      extra_data = {
        bypass_times = true,
        extraUse = true,
      }
    })
    -- if use then
    -- player.room:useCard(use)  
    -- end
  end,
})



return ljetkrak
