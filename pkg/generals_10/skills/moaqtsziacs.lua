local moaqtsziacs = fk.CreateSkill({
  name = "moaqtsziacs",
  tags={Skill.Compulsory}
})

Fk:loadTranslationTable{
  ["moaqtsziacs"] = "魔障",
  [":moaqtsziacs"] = "鎖定.伱末段始旹,必發:伱判定,若爲♦️♥️伱令伱弃1手牌,回1;若爲♠️♣️伱抽1,予己1傷",

  ["#moaqtsziacs-choose"] = "魔障：你可以令一名角色进行判定",

  ["$moaqtsziacs1"] = "五雷天心緣何不驪",  --无色
  -- ["$moaqtsziacs2"] = "飛沙一起,眞假莫辨",
}
moaqtsziacs:addEffect(fk.EventPhaseStart, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(moaqtsziacs.name)  and data.phase==Player.Finish
  end,

  on_use = function(self, event, target, player, data)
    local room = player.room

    local judge = {
      who = player,
      reason = moaqtsziacs.name,
      pattern = ".|.|diamond,heart",  --除无色
    }
    room:judge(judge)
    if table.contains({Card.Diamond,Card.Heart},judge.card.suit) then
      room:askToDiscard( player, {
              min_num = 1,
              max_num = 1,
              skill_name = skillName,
              include_equip = false,
              cancelable = false,
            })
      room:recover{
        who = player,
        num = 1,
        recoverBy = player,
        skillName = moaqtsziacs.name,
      }
    elseif table.contains({Card.Spade,Card.Club},judge.card.suit) then
      player:drawCards(1,moaqtsziacs.name)
      room:damage{
        from = player,
        to = player,
        damage = 1,
        skillName = moaqtsziacs.name,
      }
    end
  end,
})


return moaqtsziacs
