local hseekdziac = fk.CreateSkill {
  name = "hseekdziac",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

Fk:loadTranslationTable{
  ["hseekdziac"] = "鬩牆",
  [":hseekdziac"] = "主旹,伱弃置1紅牌指定2其它脚色發動:所選脚色賭鬥,贏者交予伱1牌,未贏者流失1",
  
  ["#hseekdziac-active"] = "鬩牆 弃1紅牌指定2其它脚色",
  ["#hseekdziac-give"] = "鬩牆 選擇牌交予%src",

  ["$hseekdziac1"] = "我欲行夏禹旧事，为天下人。",

}
hseekdziac:addEffect("active", {
  anim_type = "offensive",
  prompt = "#hseekdziac-active",
  max_phase_use_time = 1,
  card_num = 1,
  target_num = 2,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 
	and not player:prohibitDiscard(Fk:getCardById(to_select))
	-- and not player:prohibitResponse(Fk:getCardById(to_select))
	and Fk:getCardById(to_select).color==Card.Red
  end,
  target_filter = function(self, player, to_select, selected)
    -- if #selected < 2 and to_select ~= player  then  --and to_select:isMale()
    --   if #selected == 0 then
    --     return true
    --   else
    --     return to_select:canUseTo(Fk:cloneCard("tous_tsiacs"), selected[1])
    --   end
    -- end
    return  #selected < 2 and to_select ~= player
  end,
  on_cost =function(self, player, data,extra_data)
   data.fromArea = table.contains(player:getCardIds("e", data.cards[1])) and Card.PlayerEquip or Card.PlayerHand
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    -- S.playCard(effect.cards,hseekdziac.name,player)
	if table.contains(player:getCardIds(effect.fromArea, data.cards[1]))  then
	room:throwCard(effect.cards,hseekdziac.name,player,player)
	end
    local exe =function(p,win)
      if p.dead then return end
      if not win then room:loseHp(p,1,hseekdziac.name)  --无源
      else
        local cards = room:askToCards(p, {
          min_num = 1,
          max_num = 1,
          include_equip = true,
          skill_name = hseekdziac.name,
          prompt = "#hseekdziac-give:"..player.id,
          cancelable = true,
        })
        if #cards == 1 then
          room:obtainCard(player, cards, false, fk.ReasonGive, p, hseekdziac.name)
        end
      end
    end

    local p1, p2 = effect.tos[1], effect.tos[2]
    local pindian = p1:pindian({p2}, hseekdziac.name)
    if pindian.results[p2].winner then

      if pindian.results[p2].winner == p1 then
        exe(p1,true)
        exe(p2)
      else
        exe(p1)
        exe(p2,true)
      end
    else
      exe(p1)
      exe(p2)
    end
  end,
})

return hseekdziac
