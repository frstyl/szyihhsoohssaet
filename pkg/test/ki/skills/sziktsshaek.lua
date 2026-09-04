local sziktsshaek = fk.CreateSkill {
  name = "sziktsshaek",
}

Fk:loadTranslationTable{
  ["sziktsshaek"] = "識策",
  [":sziktsshaek"] = "其它腳色A起動牌旹,伱可發動,A可与伱賭鬥,若其未執行或未贏,起動无效",

  ["#sziktsshaek-invoke"] = "識策 %dest 起動 %arg 伱可令其无效",
  ["#sziktsshaek-pindian"] = "識策 与%src賭鬥",

}
local S = require "packages/szyihhsoohssaet/szyih_guos"

sziktsshaek:addLoseEffect (function (self, player)
    player.room:setPlayerMark(player,"@sziktsshaek",0) 
end)

sziktsshaek:addEffect(fk.CardUsing, { --CardUseFinished
  can_trigger = function (self, event, target, player, data)
    return 
    data.from~=player
     and  player:hasSkill(sziktsshaek.name)
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player, { skill_name = sziktsshaek.name,
  prompt = "#sziktsshaek-invoke::" .. target.id .. ":" .. data.card:toLogString(),
})
  end,
  on_use = function (self, event, target, player, data)
    if not  data.from:canPindian(player) then     S.useNullify(data,player,sziktsshaek.name) return end

    local cards=player.room:askToCards( data.from,{
			min_num=1,
			max_num=1,
			include_equip=false,
			pattern=".",
      prompt = "#sziktsshaek-pindian:" .. player.id,
			cancelable = true,
		})
    if #cards==0 then return end
    local pindian = data.from:pindian({player}, sziktsshaek.name, Fk:getCardById(cards[1]))
    if pindian.results[player].winner~=data.from then
      S.useNullify(data,player,sziktsshaek.name) 
    end
    -- if not player.dead then
    --     room:damage({
    --     from = data.from,
    --     to = player,
    --     damage = 1,
    --     damageType = fk.NormalDamage,
    --     skillName = sziktsshaek.name,
    --   })
    -- end
  end,
})


return sziktsshaek
