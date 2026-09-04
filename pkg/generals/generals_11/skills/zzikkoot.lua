local zzikkoot = fk.CreateSkill {
  name = "zzikkoot",
}

Fk:loadTranslationTable{
  ["zzikkoot"] = "蝕骨",
  [":zzikkoot"] = "伱對其它脚色致傷後,或伱受其它脚色傷後,伱可聲明1牌名發動.伱与其不可起動打出同名牌至各自轉終",

  ["#zzikkoot-invoke"] = "蝕骨 是否對 %dest 發動",
  ["#zzikkoot-choice"] = "蝕骨：選1",
  ["@$zzikkoot"] = "蝕骨",

  ["$zzikkoot1"] = "今进退两难，势若蝕骨，魏王必当罢兵而还。",
  ["$zzikkoot2"] = "汝可令士卒收拾行装，魏王明日必定退兵。",
}

-- local U = require "packages/utility/utility"
local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec={
  on_cost = function (self, event, target, player, data)
    local room = player.room
    local to = data.to==player and data.from or data.to
    -- if not room:askToSkillInvoke(player,{skill_name=zzikkoot.name,prompt="#zzikkoot-invoke::"..to.id,}) then
    --   return
    -- end
    -- local all_names = Fk:getAllCardNames("btd", true)
    -- local names = table.simpleClone(all_names)
    -- names=table.filter(all_names, function(name)
    -- return not table.contains(player:getTableMark("zzikkoot"),name)
    -- end)
    -- local mark = U.askForChooseCardNames(room, player, names, 1, 1, zzikkoot.name, "#zzikkoot-choice:"..to.id, all_names, true, false)
    local types={ "basic", "trick", "equip", "magic", "allusion" }
    local type =room:askToChoice(player, {
      choices = types,
      skill_name = "zzikkoot",
      cancelable=true,
      prompt="#zzikkoot-invoke::"..to.id,
     }) 
    if type=="Cancel" then return end
    local allCardNames = S.getCardNamesByType(table.indexOf(types,type))
    local name = room:askToChoice(player, { choices = allCardNames, skill_name = "zzikkoot" }) 
    -- local name = UI.CardNameBox { choices = all_names, all_choices = all_names }
    if name~= "khouc" then
      event:setCostData(self, {tos={to},choices={name}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local mark = event:getCostData(self).choices[1]
    room:addTableMarkIfNeed(player, "@$zzikkoot", mark)
    room:addTableMarkIfNeed(event:getCostData(self).tos[1], "@$zzikkoot", mark)
  end,
}

zzikkoot:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return (data.from == player or data.to == player )
	and player:hasSkill(zzikkoot.name) and data.to  and not data.to.dead  and  data.to~=player
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
    return target == player and player:getMark("@$zzikkoot") ~= 0
  end,
  on_refresh = function (self, event, target, player, data)
    player.room:setPlayerMark(player, "@$zzikkoot", 0)
  end,
})

zzikkoot:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    return card and player and table.contains(player:getTableMark("@$zzikkoot"), card.trueName)
  end,
  prohibit_response = function(self, player, card)
    return card and player and  table.contains(player:getTableMark("@$zzikkoot"), card.trueName)
  end,
  -- prohibit_discard = function(self, player, card)
  --   return table.contains(player:getTableMark("@$zzikkoot"), card.trueName)
  -- end,
})

return zzikkoot
