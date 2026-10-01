local mvoaqtoav = fk.CreateSkill({
  name = "mvoaqtoav",
})
Fk:loadTranslationTable{
  ["mvoaqtoav"] = "磨刀",
  [":mvoaqtoav"] = "伱補段終旹,伱可選擇1至x牌發動,褈鑄爲｢殺｣(x爲伱攻程)", 

  ["#mvoaqtoav-invoke"] = "磨刀  投出牌 印獲得等量｢殺｣",
  ["#mvoaqtoav-choose"] = "磨刀  選擇發動目幖",

  ["$mvoaqtoav1"] = "吾大軍援糧何在",
}
local S = require "packages/szyihhsoohssaet/szyih_guos"

mvoaqtoav:addEffect(fk.EventPhaseEnd, {
  anim_type = "drawcard",

  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(mvoaqtoav.name) 
    and target==player and player.phase==Player.Draw
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local cards = room:askToCards(player, {
		  min_num = 1,
		  max_num = player:getAttackRange(),
		  include_equip = true,
		  skill_name = mvoaqtoav.name,
		  cancelable = true,
      pattern = ".",
      prompt = "#mvoaqtoav-invoke",
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
    -- S.playCard(cards, mvoaqtoav.name,player)
    -- room:moveCards({
      -- ids = S.getKhouc(#cards,"ssaet"),
      -- to = player,
      -- toArea = Card.PlayerHand,
      -- moveReason = fk.ReasonJustMove,
      -- proposer = player,
      -- skillName = mvoaqtoav.name,
      -- moveVisible = true,
    -- })
  end,
})


return mvoaqtoav
