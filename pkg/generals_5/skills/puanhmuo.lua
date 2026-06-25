local puanhmuo = fk.CreateSkill {
  name = "puanhmuo",
}

Fk:loadTranslationTable {
  ["puanhmuo"] = "反誣",
  [":puanhmuo"] = "伱對一其它角色A所用牌被抵消旹,伱可預弃1牌發動.視爲A弃置伱此牌,肰後伱對A使虛擬用｢无中生有｣",

  ["#puanhmuo-invoke"] = "反誣 預弃1牌 視爲對%src使用无中生有",

  ["$puanhmuo1"] = "是叔叔輕薄了我",
}


puanhmuo:addEffect(fk.CardEffectCancelledOut, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(puanhmuo.name) and data.to~=player
  end,
  on_cost = function(self, event, target, player, data)
    local cards = player.room:askToDiscard(player, {
        min_num = 1,
        max_num = 1,
        include_equip = true,
        skill_name = puanhmuo.name,
        cancelable = true,
        prompt = "#puanhmuo-invoke:"..data.to.id,
        skip = true,
      })
      if #cards == 1 then
        event:setCostData(self, {tos = {data.to}, cards = cards})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:throwCard(event:getCostData(self).cards, puanhmuo.name, player, data.to)
    room:useVirtualCard("muo_ttiuc_ssaac_qiuh", nil, player, {data.to}, puanhmuo.name, true)  --??檢測合理?
end,
})



return puanhmuo