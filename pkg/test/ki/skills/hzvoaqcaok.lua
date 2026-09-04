local hzvoaqcaok = fk.CreateSkill{
  name = "hzvoaqcaok",
  tags={Skill.Compulsory},
}

Fk:loadTranslationTable{
  ["hzvoaqcaok"] = "龢樂",  --獨奏 合奏 閒奏
  [":hzvoaqcaok"] = "伱起動或演練牌旹必發,若此牌伱上一起動或演練牌之點數絕對差(无牌視爲0點){極叶/較叶/較不叶/極不叶}伱{抽2/抽1/選擇褈鑄1手牌或得1空/全體腳色弃1手牌}<br/>(點數差屬于{0,12/5,7/3,4,8,9/1,2,6,10,11})",  --
--,此技能1轉失效
  ["#hzvoaqcaok-recast"] = "龢樂：  褈鑄1手牌 或得1空",
  ["#hzvoaqcaok-discard"] = "龢樂： %src發出極不龢叶音 弃1",

}


local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec ={
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(hzvoaqcaok.name)
  end,
  on_use = function(self, event, target, player, data)
    local n=math.abs(player:getMark("@hzvoaqcaok") - data.card.number)%13

    if table.contains({0,12},n) then
      player:drawCards(2)
    elseif table.contains({7,5},n) then
      player:drawCards(1)

    elseif table.contains({4,9,3,8},n) then
      local room=player.room
      local cards = room:askToCards(player, {
        min_num = 0,
        max_num = 1,
        skill_name = hzvoaqcaok.name,
        -- pattern = ".",
        include_equip=false,
        prompt = "#hzvoaqcaok-recast",
        cancelable = true,
      })
      if #cards>0 then
        room:recastCard(cards, player, hzvoaqcaok.name)
      else
        room:moveCards({
          ids = S.getKhouc( 1),
          to = player,
          toArea = Card.PlayerHand,
          moveReason = fk.ReasonJustMove,
          proposer = player,
          skill_name = hzvoaqcaok.name,
          moveVisible = true,
        })
      end
    elseif table.contains({10,2,6,11,1},n) then
      local room=player.room
      for _, p in ipairs(room.alive_players) do
          room:askToDiscard(p, {
            min_num = 1,
            max_num = 1,
            include_equip = false,
            skill_name = hzvoaqcaok.name,
            prompt = "#hzvoaqcaok-discard:"..player.id,
            cancelable = false,
            skip = false,
          })
      end
      -- player.room:invalidateSkill(player, kximqthoac.name,"-turn")
    end
  end,
  late_refresh=true,
  can_refresh = function(self, event, target, player, data)
    return target==player and player:hasSkill(hzvoaqcaok.name,true)
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:setPlayerMark(player,"@hzvoaqcaok",data.card.number)
  end,
}

hzvoaqcaok:addEffect(fk.CardUsing, spec)
hzvoaqcaok:addEffect(fk.CardResponding, spec)

return hzvoaqcaok
