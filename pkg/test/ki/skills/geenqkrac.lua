local hzeenqkrac = fk.CreateSkill {
  name = "hzeenqkrac",
}

Fk:loadTranslationTable{
  ["hzeenqkrac"] = "弦驚",
  [":hzeenqkrac"] = "伱起動殺指定目幖後,伱可聲明1花色發動｡目幖不可抵消此｢殺｣,可選擇弃置1至多張牌并流失1體力,伱展示目幖全部牌此｢殺｣對其傷害基數+x(x爲展示牌与伱所聲明同花者)｡",

  ["#hzeenqkrac-invoke"] = "弦驚 聲明1花色對 %dest 發動",
  ["#hzeenqkrac-discard"] = "弦驚：%src 聲明%arg，伱可以弃置牌",
}

hzeenqkrac:addEffect(fk.TargetSpecified, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from  == player and player:hasSkill(hzeenqkrac.name) and
      data.card.trueName == "ssaet" 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local choice = room:askToChoice(player, {
      choices = {"spade","club", "heart", "diamond","Cancel"},
      -- choices = {"red", "black", "Cancel"},
      skill_name = hzeenqkrac.name,
      prompt = "#hzeenqkrac-invoke::"..data.to.id,
    })
    if choice ~= "Cancel" then
      event:setCostData(self, {tos = {data.to}, choice = choice})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    data.unoffsetable = true
    local choice = event:getCostData(self).choice
    room:sendLog{
      type = "#Choice",
      from = player.id,
      arg = choice,
      toast = true,
    }
    local ids= room:askToDiscard(data.to, {
      min_num = 1,
      max_num = 999,
      include_equip = true,
      skill_name = hzeenqkrac.name,
      cancelable = true,
      prompt = "#hzeenqkrac-discard:"..player.id.."::"..choice,
      -- skip=true,
    })
    if player.dead or data.to.dead or data.to:isNude() then return end

    if #ids>0 then room:loseHp(data.to,1,hzeenqkrac.name) end
    if data.to.dead  then return end
    -- local id = room:askToChooseCard(player, {
    --   target = data.to,
    --   flag = "he",
    --   skill_name = hzeenqkrac.name
    -- })
    local cards=data.to:getCardIds("he")
    data.to:showCards(cards)
    local n = #table.filter(cards,function(id)
      return Fk:getCardById(id):getSuitString() == choice 
    end)
    if n>0 then
      data.additionalDamage = (data.additionalDamage or 0) + n
    end
  end,
})

return hzeenqkrac
