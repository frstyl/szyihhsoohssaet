local hzeethzoac = fk.CreateSkill {
  name = "hzeethzoac",
}

Fk:loadTranslationTable{
  ["hzeethzoac"] = "頡頏",
  [":hzeethzoac"] = "伱起動殺指定目幖後,伱可發動｡伱与目幖同旹選擇1項:此殺對目幖➀傷害基數+1(不疊加)➁不可響應",

  ["addDamage"] = "加傷",
  ["disresponsive"] = "不可響應",
}

hzeethzoac:addEffect(fk.TargetSpecified, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from  == player and player:hasSkill(hzeethzoac.name) and
      data.card.trueName == "ssaet" 
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local tos = {data.to,player}
    local params = {
      players = tos,
      choices = {"addDamage","disresponsive"},
      prompt = "hzeethzoac-choose",
      skillName = hzeethzoac.name,
      send_log = true,
    }
   
    local req = room:askToJointChoice(player,params)
    local addDamage=false
    local disresponsive=false
    for _, p in ipairs(tos) do
      -- room:sendLog{
      --   type = "#Choice",
      --   from = p.id,
      --   arg = req[p],
      --   toast = true,
      -- }
      if req[p]=="disresponsive" then
      disresponsive = true
      else
      additionalDamage = true
      end
    end

    if disresponsive then data.disresponsive = true end
    if addDamage then 
    data.additionalDamage = (data.additionalDamage or 0) + 1
    end
  end,
})

return hzeethzoac
