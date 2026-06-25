local hseekdziac = fk.CreateSkill {
  name = "hseekdziac",
}

Fk:loadTranslationTable{
  ["hseekdziac"] = "鬩牆",
  [":hseekdziac"] = "主旹,伱預弃1紅牌指定2其它角色發動:所選角色拼點,贏者交予伱1牌,未贏者流失1體力",
  
  ["#hseekdziac-active"] = "鬩牆 弃1紅牌指定2其它角色",
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
    return #selected == 0 and not player:prohibitDiscard(to_select) and Fk:getCardById(to_select).color==Card.Red
  end,
  target_filter = function(self, player, to_select, selected)
    -- if #selected < 2 and to_select ~= player  then  --and to_select:isMale()
    --   if #selected == 0 then
    --     return true
    --   else
    --     return to_select:canUseTo(Fk:cloneCard("duel"), selected[1])
    --   end
    -- end
    return  #selected < 2 and to_select ~= player
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    room:throwCard(effect.cards, hseekdziac.name, player, player)

    local exe =function(p,win)
      if p.dead then return end
      if not win then room:loseHp(p,1,hseekdziac.name)
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
