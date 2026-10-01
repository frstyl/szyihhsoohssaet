local koohtszhye = fk.CreateSkill {
  name = "koohtszhye",
}

Fk:loadTranslationTable{
  ["koohtszhye"] = "鼔吹",
  [":koohtszhye"] = "應動｡伱攻程內腳色致傷旹,伱可投出1牌A發動,伱占卜,若占卜牌与A爲 紅与進攻牌 紅与非進攻牌 黑与進攻牌 黑与非進攻牌,,",

  ["#koohtszhye1-invoke"] = "鼔吹：%src 對 %dest 致傷 伱投出1牌發動 令此傷害+1或-1",
  -- ["#koohtszhye2-invoke"] = "鼔吹：%dest 受到傷害，你可以弃置一张牌进行判定，令此傷害+1或-1",
  ["#koohtszhye1-choice"] = "鼔吹：令 %src 對 %dest 傷害+1或-1",
  -- ["#koohtszhye2-choice"] = "鼔吹：你可以令 %dest 受到的傷害+1或-1",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

local spec = {
  on_cost = function(self, event, target, player, data)
    local room = player.room

    local card = S.askToPlayCard(player, {
      min_num = 1,
      max_num = 1,
      include_equip = true,
      skill_name = koohtszhye.name,
      cancelable = true,
      prompt =  "#koohtszhye1-invoke:"..data.from.id..":"..data.to.id,
      skip = true,
    })
    if #card > 0 then
      event:setCostData(self, {tos = {target}, cards = card})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local card = Fk:getCardById(event:getCostData(self).cards[1])
    S.playCard(card, koohtszhye.name, player, player)
    if player.dead then return false end

    local judge = {
      who = player,
      reason = koohtszhye.name,
      pattern = "^nocolor",
    }
    room:judge(judge)
    if judge.card.color== Card.Red and not data.from.dead then
      if S.isAttackCard(card) then
        data.from:drawCards(1,koohtszhye.name)
      else
        if not data.to:isNude() then
            room:throwCard(room:tableRandomPick(data.to:getCardIds("h"),1), koohtszhye.name, data.to, data.to)
        end
      end
    elseif judge.card.color== Card.Black then
      S.changeDamage({damageData=data,
      num= S.isAttackCard(card) and 1 or -1,
      skillName=koohtszhye.name})
    end
    -- if judge:matchPattern() and not player.dead then

    --   local choice = room:askToChoice(player, {
    --     choices = {"+1", "-1", "Cancel"},
    --     skill_name = koohtszhye.name,
    --     prompt =  "#koohtszhye1-choice:"..target.id..":"..data.to.id,
    --   })

    --   S.changeDamage({damageData=data,
    --   num=choice == "+1" and 1 or -1,
    --   skillName=koohtszhye.name})
    -- end

  end,
}

koohtszhye:addEffect(fk.DamageInflicted, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(koohtszhye.name) 
    and (player:inMyAttackRange(data.from) or player== data.from)
    and not player:isNude()
  end,
  on_cost = spec.on_cost,
  on_use = spec.on_use,
})

return koohtszhye
