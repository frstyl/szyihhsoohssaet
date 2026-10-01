local seenqtszjis = fk.CreateSkill {
  name = "seenqtszjis",
}

Fk:loadTranslationTable{
  ["seenqtszjis"] = "先至",
  [":seenqtszjis"] = "伱成爲起動目幖後,伱可選擇1項發動,➀伱抽1➁起動1元實牌",


  ["#seenqtszjis-use"] = "先至 起動牌",

  ["$seenqtszjis1"] = "善战者后动，一击而毙敌。",
  ["$seenqtszjis2"] = "我所善者，后发制人尔。",
}

seenqtszjis:addEffect(fk.TargetConfirmed, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(seenqtszjis.name)
  end,
  on_cost = function(self, event, target, player, data)
    local choice=player.room:askToChoice(from, {
       choices = {"draw1","use","recast"},
        skill_name = "seenqtszjis",
        cancelable=true,
  })
  if choice~="Cancel" then
    event:setCostData(self,{choice=choice})
    return true
  end
  end,
  on_use = function(self, event, target, player, data)
    local choice=event:getCostData(self).choice
    if choice=="draw1" then
          player:drawCards(1, seenqtszjis.name)
    elseif choice=="use" then
    -- if player.dead or player.phas==Player.Play then return end
      -- player.room:askToUseRealCard(player, {
      --   pattern = player:getCardIds("h"),
      --   skill_name = seenqtszjis.name,
      --   prompt = "#seenqtszjis-use",
      --   extra_data = {
      --     bypass_times = false,
      --     extraUse = false,
      --     bypass_distances=false,
      --     bypass_moment=true,
      --   },
      --   cancelable=true,
      --   skip=false,
      -- })
      local use = player.room:askToUseCard(player, {
        skill_name = seenqtszjis.name,
        pattern = ".", --
        -- cards=,
        prompt = "#seenqtszjis-use",
        cancelable = false,
        skip=false,
        extra_data = {
          -- bypass_distances = true,
          bypass_times = true,
          extraUse=true,
          not_passive=true,
          bypass_moment=true,
        },
      })
	  if use then
        room:useCard(use)
      end
      else
        player.room:recastCard(player:getCardIds("h"), player,seenqtszjis.name)
      end
  end,
})



return seenqtszjis
