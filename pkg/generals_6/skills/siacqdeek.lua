

local siacqdeek= fk.CreateSkill({
  name = "siacqdeek",
})

Fk:loadTranslationTable{
["siacqdeek"] = "相敵",
[":siacqdeek"] = "每局限x次,x初始爲1,伱受傷後或伱轉始旹x加1(失去此技能x清零).一名角色回合開始旹伱可發動動,伱觀看牌堆頂3牌,獲得其1.",
["@siacqdeek"] = "相敵 ",
["#siacqdeek-choose"] = "相敵 ",

["#siacqdeek-invoke"] = "相敵 %src 轉始 是否發動 ",
}


siacqdeek:addEffect(fk.TurnStart,{
	anim_type = "control",
  times = function(self, player)
    return player:getMark("@siacqdeek")
  end,
	can_trigger = function(self, event, target, player, data)
		return player:hasSkill(siacqdeek.name) and player:getMark("@siacqdeek")>0
	end,
	on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = siacqdeek.name,
      prompt = "#siacqdeek-invoke:"..target.id,
    }) 
  end,
	on_use = function(self, event, target, player, data)
      player.room:removePlayerMark(player,"@siacqdeek",1)  --算發動 得幖記不算發動
      local room = player.room
    -- local cards = room:getNCards(3)  --觀星 心戰
      -- local cards = {}
      local cards = room:getNCards(3)
      local get = room:askToArrangeCards(player, {
      skill_name = siacqdeek.name,
      card_map = {cards, "Top", "toObtain"},
      prompt = "#siacqdeek-choose",
      free_arrange = false,
      box_size = 0,
      max_limit = {3, 3},
      min_limit = {2, 1},
      -- pattern = ".|.|.",
    })[2]
    -- if #get > 0 then  --必拿 默認第3??
    room:moveCardTo(get, Player.Hand, player, fk.ReasonJustMove, siacqdeek.name, nil, true, player)

    -- end
    end,
})

local addmark = {
    can_refresh = function(self, event, target, player, data)
    return  target==player and player:hasSkill(siacqdeek.name)
  end,
  on_refresh = function(self, event, target, player, data)
        player.room:addPlayerMark(player,"@siacqdeek",1)
  end,
}


siacqdeek:addEffect(fk.TurnStart,addmark) 

siacqdeek:addEffect(fk.Damaged,addmark)

siacqdeek:addAcquireEffect(function (self, player)
    player.room:setPlayerMark(player,"@siacqdeek",1) 
end)

siacqdeek:addLoseEffect (function (self, player)
    player.room:setPlayerMark(player,"@siacqdeek",0) 
end)


return siacqdeek
