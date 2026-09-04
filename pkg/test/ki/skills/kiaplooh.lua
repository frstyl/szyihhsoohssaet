
local kiaplooh = fk.CreateSkill {
  name = "kiaplooh",
}

Fk:loadTranslationTable{
["kiaplooh"] = "劫擄",
[":kiaplooh"] = "伱起動「殺」指定目幖A後,伱可發動.A選擇0至多數量牌迻除,伱選擇➀伱取得A所迻除牌➁此殺對A傷害基數+x,抵消所需閃數+x,且此殺結算後,A迻回所迻除牌.(x爲A牌數)",

["#kiaplooh-invoke"] = "劫擄 %src 發動",
["#kiaplooh-ask"] = "劫擄 交予 %src 牌",

["kiaplooh-cards"] = "獲牌",
["kiaplooh-ssaet"] = "增傷",

["$kiaplooh"] = "劫擄",

["$kiaplooh1"] = "來一个,殺一个.來一對,殺一雙",
["$kiaplooh2"] = "絳霞影裏,卷一道凍地仌霜",
}

kiaplooh:addEffect(fk.TargetConfirmed, {
  can_trigger = function(self, event, target, player, data)
    return  data.from == player and player:hasSkill(kiaplooh.name) and data.card.trueName=="ssaet"
  end,
  on_cost = function(self, event, target, player, data)
    if player.room:askToSkillInvoke(player, {
      skill_name = kiaplooh.name,
      prompt = "#kiaplooh-invoke:"..data.to.id,
    }) then
      event:setCostData(self,{tos={data.to}})
      return true
    end
  end,
  on_use= function(self, event, target, player, data)
    local room=player.room
    local to=data.to
    local cards = room:askToCards(to, {
      min_num = 0,
      max_num = 999,
      include_equip = true,
      skill_name = kiaplooh.name,
      pattern = ".",
      prompt = "#kiaplooh-ask:"..player.id,
      cancelable = true,
    })
    local choice=""
    if #cards>0 then
      to:addToPile("$kiaplooh", cards, false, kiaplooh.name)
    end

    if to.dead or player.dead then return end
      choice = room:askToChoice(player, {
        choices = {"kiaplooh-cards","kiaplooh-ssaet"},
        skill_name = kiaplooh.name,
      })
    if choice=="kiaplooh-cards"  then
      if  #cards>0 then
      room:obtainCard(player, cards, false, fk.ReasonPrey, player, kiaplooh.name)
      end
    else
      local n =#to:getCardIds("he")
      data:setResponseTimes(data:getResponseTimes(to)+n, to)
      data.additionalDamage =(data.additionalDamage or 0) +n

      if #cards>0 then
        room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true):addCleaner(function()
            if not to.dead then
              room:obtainCard(to, cards, false,fk.ReasonPrey, to, kiaplooh.name)
            end
        end)
      end

    end
  end,
})

return kiaplooh

