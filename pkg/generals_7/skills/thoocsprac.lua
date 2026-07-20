local thoocsprac = fk.CreateSkill {
  name = "thoocsprac",
}

Fk:loadTranslationTable{
  ["thoocsprac"] = "統兵",
  [":thoocsprac"] = "伱致傷後/受傷後,伱可選1項令受傷或致傷脚色執行發動.➀將手牌抽至自身體力上限➁手牌弃至自身體力值.因統兵所抽牌无視次數限制",  --丈八 --削不計入次數

  ["thoocsprac-draw-self"] = "伱 抽牌至體力上限",
  ["thoocsprac-discard-self"] = "伱 手牌弃至體力值",
  ["thoocsprac-draw"] = "令 %src 抽牌至體力上限",
  ["thoocsprac-discard"] = "令 %src 手牌弃至體力值",
  ["thoocsprac-todiscard"] = "弃 %arg 手牌",

  ["@@thoocsprac-inhand"] = "統兵",

  ["$thoocsprac1"] = "看伱等已是秊衰命䀆",
  ["$thoocsprac2"] = "汝昰斯未聽過我李成聞達之威名无"
}

local spec = {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(thoocsprac.name)
  end,
  on_cost = function(self, event, target, player, data)
    local to=data.from~=player and data.from   or data.to
    local choices={"thoocsprac-draw-self", "thoocsprac-discard-self",
    "thoocsprac-draw:"..to.id, "thoocsprac-discard:"..to.id, "Cancel",}
    if not data.from or data.from==data.to then
      choices={"thoocsprac-draw-self", "thoocsprac-discard-self", "Cancel",}
    end

    local choice = player.room:askToChoice(player, {
      choices = choices,
      skill_name = thoocsprac.name,
      prompt = "#thoocsprac-choose:",
    })
    if choice ~= "Cancel" then
      local tos
      if table.contains({"thoocsprac-draw-self", "thoocsprac-discard-self"}, choice ) then
          tos = {player}
      else
        to ={to}
      end
      event:setCostData(self, {choice = choice, tos=tos})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local to=event:getCostData(self).tos[1]
    local room=player.room
    if event:getCostData(self).choice=="thoocsprac-draw-self" then
    local n=player.maxHp-player:getHandcardNum()
    if n>0 then
        room:addSkill("extraUse")        
        room:addSkill("bypass_times")
        player:drawCards(n, thoocsprac.name, nil, {"@@thoocsprac-inhand",1,"extraUse-inhand",1,"bypass_times-inhand",1})
      end
    elseif event:getCostData(self).choice=="thoocsprac-draw:"..to.id then
      local n=to.maxHp-to:getHandcardNum()
      if n>0 then
        room:addSkill("extraUse")        
        room:addSkill("bypass_times")
        to:drawCards(n, thoocsprac.name, nil, {"@@thoocsprac-inhand",1,"extraUse-inhand",1,"bypass_times-inhand",1})
      end
    elseif  event:getCostData(self).choice=="thoocsprac-discard-self" then
      local n=player:getHandcardNum()-player.hp
      if n>0 then
        player.room:askToDiscard(player, {
          min_num = n,
          max_num = n,
          include_equip = false,
          skill_name = thoocsprac.name,
          prompt = "#thoocsprac-todiscard"..n,
          cancelable = false,
          skip = false,
        })
      end
    elseif  event:getCostData(self).choice=="thoocsprac-discard:"..to.id then
      local n=to:getHandcardNum()-to.hp
      if n>0 then
        player.room:askToDiscard(to, {
          min_num = n,
          max_num = n,
          include_equip = false,
          skill_name = thoocsprac.name,
          prompt = "#thoocsprac-todiscard"..n,
          cancelable = false,
          skip = false,
        })
      end
    end
  end
}

thoocsprac:addEffect(fk.Damaged, spec)
thoocsprac:addEffect(fk.Damage, spec)


return thoocsprac
