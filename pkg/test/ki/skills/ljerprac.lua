local ljerprac = fk.CreateSkill({
  name = "ljerprac",
})
Fk:loadTranslationTable{
  ["ljerprac"] = "礪兵",  --䘙生 養生
  [":ljerprac"] = "伱補段終旹,伱可選擇1至多牌發動,褈鑄爲｢殺｣", 

  ["#ljerprac-invoke"] = "礪兵  打出牌 印獲得等量｢殺｣",
  ["#ljerprac-choose"] = "礪兵  選擇發動目幖",

  ["$ljerprac1"] = "吾大軍援糧何在",
  -- ["$ljerprac2"] = "礪兵五十六縣皆爲我土",
}
local S = require "packages/szyihhsoohssaet/szyih_guos"

ljerprac:addEffect(fk.EventPhaseEnd, {
  anim_type = "drawcard",

  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(ljerprac.name) 
    and target==player and player.phase==Player.Draw
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local cards = room:askToCards(player, {
		  min_num = 1,
		  max_num = 4,
		  include_equip = true,
		  skill_name = ljerprac.name,
		  cancelable = true,
      pattern = ".",
      prompt = "#ljerprac-invoke",
		  skip = true,
		})
    if #cards ~= 0 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
	on_use = function(self, event, target, player, data)
    local room=player.room
	    local cards=event:getCostData(self).cards

	      room:moveCards({
        ids = cards,
        to = nil,
        toArea = Card.DiscardPile,
        moveReason = fk.ReasonRecast,
        proposer = player,
        skillName = bunqzjins.name,
        moveVisible = true,
      })
      if player.dead then return end
      S.printKhouc(plyayer,#cards,bunqzjins.name,"ssaet")
    -- S.playCard(cards, ljerprac.name,player)
    -- room:moveCards({
      -- ids = S.getKhouc(#cards,"ssaet"),
      -- to = player,
      -- toArea = Card.PlayerHand,
      -- moveReason = fk.ReasonJustMove,
      -- proposer = player,
      -- skillName = ljerprac.name,
      -- moveVisible = true,
    -- })
  end,
})


return ljerprac
