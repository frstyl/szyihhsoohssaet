local jioqqwins = fk.CreateSkill {
  name = "jioqqwins",
  tags = { Skill.Combo },
}

Fk:loadTranslationTable{
  ["jioqqwins"] = "餘韻",
  [":jioqqwins"] = "記彔伱所使用牌花色.伱使用牌旹,若記錄爲有3,伱可發動,清除記錄,伱自牌堆獲得記錄法含花色之牌各1",

  ["@jioqqwins"] = "餘韻",

  ["#jioqqwins-invoke"] = "餘韻：是否",
  ["#jioqqwins-prey"] = "餘韻：获得 %dest 一张手牌",

  ["$jioqqwins1"] = "胡未灭，家何为？",
  ["$jioqqwins2"] = "诸君且听，这雁门虎啸！"
}

jioqqwins:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(jioqqwins.name) 
    and  data.extra_data and data.extra_data.combo_skill and data.extra_data.combo_skill[jioqqwins.name]
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = jioqqwins.name,
      prompt = "#jioqqwins-invoke",
    })
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room


    local suits = {"heart", "diamond", "spade", "club"}
    for _, suitlog in ipairs(player:getTableMark("@jioqqwins")) do
      table.removeOne(suits,suitlog:split("_")[2])
    end

    room:setPlayerMark(player,"@jioqqwins",0)
    if #suits == 0 then return end
    local cards = {}
    for _, suit in ipairs(suits) do
      table.insertTable(cards, room:getCardsFromPileByRule(".|.|"..suit))
    end
    if #cards > 0 then
      room:moveCards({
        ids = cards,
        to = player,
        toArea = Card.PlayerHand,
        moveReason = fk.ReasonJustMove,
        proposer = player,
        skillName = jioqqwins.name,
      })
    end
  end,
})

jioqqwins:addEffect(fk.AfterCardUseDeclared, {
  can_refresh = function (self, event, target, player, data)
    return target == player and player:hasSkill(jioqqwins.name, true)
  end,
  on_refresh = function (self, event, target, player, data)
    local room = player.room
    local suits=player:getTableMark("@jioqqwins") --質數?

    local suit=data.card:getSuitString(true)
    local ok=function()
        data.extra_data = data.extra_data or {}
        data.extra_data.combo_skill = data.extra_data.combo_skill or {}
        data.extra_data.combo_skill[jioqqwins.name] = true
    end
    local temp={suit}
    local n = #suits
    if n>2 then
      n=2
    end

    if suit=="log_nosuit" then
      for i=n, 1,-1 do
        table.insert(temp,suits[i])
      end
      
    else
      for i=n, 1,-1 do
        if suits[i] ==suit then
            break
        else
          table.insert(temp,suits[i])
        end
      end
    end
    if #temp==3 then
      ok()
    end
    room:setPlayerMark(player,"@jioqqwins",temp)
  end,
})

return jioqqwins
