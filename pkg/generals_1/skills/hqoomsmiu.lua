Fk:loadTranslationTable{
  ["hqoomsmiu"] = "暗謀",
  [":hqoomsmiu"] = "任一角色判斷牌生效前,伱可選其一手牌發動.伱打出此牌,以此牌代替元判定牌。",

  ["#hqoomsmiu-ask"] = "是否发动 暗謀，打出%dest一张牌代替 其 %arg 判定",

  ["$hqoomsmiu1"] = "伱我如兄弟 我豈會諞伱",
  ["$hqoomsmiu2"] = "衙內吩咐 吾自當照辦",
}

local hqoomsmiu = fk.CreateSkill{
  name = "hqoomsmiu",
}

hqoomsmiu:addEffect(fk.AskForRetrial, {
  hqoomsmiu = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(hqoomsmiu.name) and not data.who:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local cards = room:askToChooseCards(player, { target = data.who, flag = "h", skill_name = hqoomsmiu.name,  min = 0, max = 1, })
    if #cards > 0 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local cid =event:getCostData(self).cards[1]
    if player:prohibitResponse(Fk:getCardById(cid)) then      return end
    player.room:changeJudge{
      card = Fk:getCardById(cid),
      player = player,
      data = data,
      skillName = hqoomsmiu.name,
      response = true,
    }
    if player.dead then return end
    player:drawCards(1,hqoomsmiu.name)
  end,
})

return hqoomsmiu
