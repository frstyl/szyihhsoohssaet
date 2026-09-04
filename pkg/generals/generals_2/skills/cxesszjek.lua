local cxesszjek = fk.CreateSkill{
  name = "cxesszjek",
}

Fk:loadTranslationTable{
  ["cxesszjek"] = "義釋",
  [":cxesszjek"] = "伱起動牌指定目幖旹(每次起動限1次),伱可迻除此目幖發動｡伱弃置目幖區域1牌并伱抽1",

  -- ["#cxesszjek-choose"] = "義釋 選擇目幖",
  ["#cxesszjek-invoke"] = "義釋 迻除目幖 %src",

  ["$cxesszjek1"] = "事不宐遲,兄弟快走",
}

cxesszjek:addEffect(fk.TargetConfirming, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from == player and player:hasSkill(cxesszjek.name) 
    -- and #data.tos>0
    and not (data.extra_data and data.extra_data.cxesszjek)
  end,
  -- on_cost = function(self, event, target, player, data)
  --   local room = player.room
  --   local to = room:askToChoosePlayers(player, {
  --     min_num = 1,
  --     max_num = 1,
  --     targets = data.tos,
  --     skill_name = cxesszjek.name,
  --     prompt = "#cxesszjek-choose",
  --     cancelable = true,
  --   })
  --   if #to > 0 then
  --     event:setCostData(self, {tos = to})
  --     return true
  --   end
  -- end,
  on_cost = function(self, event, target, player, data)
    local room = player.room

    if room:askToSkillInvoke(player, { skill_name = cxesszjek.name ,prompt="#cxesszjek-invoke:"..data.to.id}) then
      event:setCostData(self, {tos = {data.to}})
      return true
    end
  end,
    on_use = function(self, event, target, player, data)
    local room = player.room
    local to=event:getCostData(self).tos[1]
    data.extra_data=data.extra_data or {}
    data.extra_data.cxesszjek=player.id
    -- data:removeTarget(to)
    data:cancelTarget(to)
    if to:isAllNude() then  return end
    local cid = room:askToChooseCard(player, { target = to, flag = "hej", skill_name = cxesszjek.name })
    -- to:showCards({cid})
    room:throwCard({cid}, cxesszjek.name, to, player)
    if player.dead then return end
    player:drawCards(1,cxesszjek.name)
  end,
})



return cxesszjek
