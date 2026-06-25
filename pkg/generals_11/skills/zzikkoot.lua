local zzikkoot = fk.CreateSkill {
  name = "zzikkoot",
}

Fk:loadTranslationTable{
  ["zzikkoot"] = "蝕骨",
  [":zzikkoot"] = "伱對其他角色致傷後,或伱受其他角色傷後,伱可聲明1牌名(裝僃除外)發動.伱与其不能使用打出同名牌至各自轉終",

  ["#zzikkoot-invoke"] = "蝕骨 是否對 %dest 發動",
  ["#zzikkoot-choice"] = "蝕骨：選1",
  ["@zzikkoot"] = "蝕骨",

  ["$zzikkoot1"] = "今进退两难，势若蝕骨，魏王必当罢兵而还。",
  ["$zzikkoot2"] = "汝可令士卒收拾行装，魏王明日必定退兵。",
}

local U = require "packages/utility/utility"

local spec={
  on_cost = function (self, event, target, player, data)
    local room = player.room
    local to = data.to==player and data.from or data.to
    if not room:askToSkillInvoke(player,{skill_name=zzikkoot.name,prompt="#zzikkoot-invoke::"..to.id,}) then
      return
      end
    local all_names = Fk:getAllCardNames("btd", true)
    local names = table.simpleClone(all_names)
    names=table.filter(all_names, function(name)
    return not table.contains(player:getTableMark("zzikkoot"),name)
    end)
    local mark = U.askForChooseCardNames(room, player, names, 1, 1, zzikkoot.name, "#zzikkoot-choice:"..to.id, all_names, true, false)
    if #mark>0 then
      event:setCostData(self, {tos={to},mark=mark})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local mark = event:getCostData(self).mark
    room:addTableMarkIfNeed(player, "@zzikkoot", mark[1])
    room:addTableMarkIfNeed(event:getCostData(self).tos[1], "@zzikkoot", mark[1])
  end,
}

zzikkoot:addEffect(fk.Damage, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(zzikkoot.name) and data.to  and not data.to.dead  and  data.to~=player
  end,
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})
zzikkoot:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(zzikkoot.name) and data.from and not data.from.dead and  data.from~=player
  end,
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})

zzikkoot:addEffect(fk.TurnStart, {
  can_refresh = function (self, event, target, player, data)
    return target == player and player:getMark("@zzikkoot") ~= 0
  end,
  on_refresh = function (self, event, target, player, data)
    player.room:setPlayerMark(player, "@zzikkoot", 0)
  end,
})

zzikkoot:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    return table.contains(player:getTableMark("@zzikkoot"), card.trueName)
  end,
  prohibit_response = function(self, player, card)
    return table.contains(player:getTableMark("@zzikkoot"), card.trueName)
  end,
  -- prohibit_discard = function(self, player, card)
  --   return table.contains(player:getTableMark("@zzikkoot"), card.trueName)
  -- end,
})

return zzikkoot
