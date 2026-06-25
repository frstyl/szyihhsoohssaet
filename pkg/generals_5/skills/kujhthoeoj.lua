local kujhthoeoj = fk.CreateSkill{
  name = "kujhthoeoj",
}

Fk:loadTranslationTable{
  ["kujhthoeoj"] = "鬼胎",
  [":kujhthoeoj"] = "一其他角色使用桃酒生效歬旹,若目幖不爲伱且伱已損,伱可弃1紅桃牌發動.此牌轉迻于伱",

  ["#kujhthoeoj-invoke"] = "鬼胎 %src 對%dest 使用%arg 將生效 伱可弃1紅桃牌發動.此牌轉迻于伱",

  ["$kujhthoeoj1"] = "客官昰是毒酒不能欱",
}
--BeforeCardEffect TargetSpecifying
kujhthoeoj:addEffect(fk.BeforeCardEffect, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return (data.card.trueName=="nziuk" or data.card.trueName=="tsiuh") and player:hasSkill(kujhthoeoj.name)
    and  data.to~=player 
    and ( data.use and data.use.from~=player)       --鬼 延時牌无data.use
    and not player:isNude()
    and player:isWounded()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local cards = room:askToDiscard(player, {
		  min_num = 1,
		  max_num = 1,
		  include_equip = true,
		  skill_name = kujhthoeoj.name,
		  cancelable = true,
      pattern = ".|.|heart",
      prompt = "#kujhthoeoj-invoke:" .. data.use.from.id .. ":"..data.to.id..":" .. data.card:toLogString(),
		  skip = true,
		})
    if #cards ~= 0 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:throwCard(event:getCostData(self).cards, kujhthoeoj.name, player, player)
    data.to=player
  end,
})



return kujhthoeoj
