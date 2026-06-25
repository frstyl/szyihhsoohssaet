local crakljin = fk.CreateSkill({
  name = "crakljin",
})

Fk:loadTranslationTable{
  ["crakljin"] = "逆鱗",
  [":crakljin"] = "當伱受到傷害後,伱可發動,伱亮出牌堆底1牌,若其爲:♠️2~9,伱予1角色3雷傷;黑{A/J/Q/K},伱弃1角色全部牌;其它,伱獲得此牌",  --damage skill 應有多个 --value1.85+1.23

  ["#crakljin-damage"] = "逆鱗：予1角色3雷傷",
  ["#crakljin-discard"] = "逆鱗：弃1角色牌",

  ["$crakljin1"] = "人有攖吾則必報之",
  ["$crakljin2"] = "讓伱也嘗嘗我之痛苦",
}
crakljin:addEffect(fk.Damaged, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(crakljin.name) 
  end,
  -- on_cost = function(self, event, target, player, data)
  --   local room = player.room
  --   local to = room:askToChoosePlayers(player, {
  --     min_num = 1,
  --     max_num = 1,
  --     targets = room:getOtherPlayers(player),
  --     skill_name = crakljin.name,
  --     prompt = "#crakljin-choose",
  --     cancelable = true,
  --   })
  --   if #to > 0 then
  --     event:setCostData(self, {tos = to})
  --     return true
  --   end
  -- end,
  on_use = function(self, event, target, player, data)
    local room = player.room

    local cards = room:getNCards(1, "bottom")
    -- to:showCards(cards)  --兩个showCards
    room:moveCards({
      ids = cards,
      toArea = Card.Processing,
      moveReason = fk.ReasonJustMove,
      skillName = crakljin.name,
      proposer = to,
    })
    local result=Fk:getCardById(cards[1])
    local get=true
    if result.suit == Card.Spade and result.number>1 and result.number <10 then
      get=false
        local to = room:askToChoosePlayers(player, {
          min_num = 1,
          max_num = 1,
          targets = room.alive_players,
          skill_name = crakljin.name,
          prompt = "#crakljin-damage",
          cancelable = true,
        })[1]
      room:damage{
        to = to,
        damage = 3,
        damageType = fk.ThunderDamage,
        skillName = crakljin.name, --crakljin --lightning_skill
      }
    end
    if  result  and (result.color==Card.Black) and
    (result.number==1 or result.number ==11 or result.number==12 or result.number==13) then
        get=false
        local to = room:askToChoosePlayers(player, {
          min_num = 1,
          max_num = 1,
          targets = room.alive_players,
          skill_name = crakljin.name,
          prompt = "#crakljin-discard",
          cancelable = true,
        })[1]
      -- to:throwAllCards("he", crakljin.name)--crakljin --hsoeojh_seevs_skill
      room:throwCard(to:getCardIds("he"), crakljin.name, to, player)
    end
    if get and not player.dead then
      room:obtainCard(player, cards, true, fk.ReasonPrey, player, crakljin.name)
    else
      room:moveCards({
        ids = cards,
        toArea = Card.DiscardPile,
        moveReason = fk.ReasonPutIntoDiscardPile,
        skillName = crakljin.name,
        proposer = nil,
      })
    end
  end,
})


return crakljin
