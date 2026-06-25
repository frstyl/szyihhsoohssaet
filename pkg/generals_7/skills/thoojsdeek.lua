local thoojsdeek = fk.CreateSkill{
  name = "thoojsdeek",
}


Fk:loadTranslationTable{
  ["thoojsdeek"] = "退敵",
  [":thoojsdeek"] = "其它角色伏段終旹,伱可預弃1武器牌或流失1體力發動.其選擇弃1紅桃閃令伱回1或令伱選擇1項➀伱予其1傷➁伱弃其裝僃區全部牌➂伱令其本局攻程-1",

  ["#thoojsdeek-invoke"] = "退敵 1武器牌或流失1體力 對%src 發動",
  ["#thoojsdeek-discard"] = "退敵 弃紅桃閃",
  ["#thoojsdeek-choose"] = "退敵 選擇1項",

  ["@thoojsdeek"] = "攻程-",

  ["thoojsdeek-damage"] = "予其1傷",
  ["thoojsdeek-disequips"] = "弃其裝僃區全部牌",
  ["thoojsdeek-atkrange"] = "其攻程-1",

  ["thoojsdeek-invoke"] = "退敵 %src主段始 是否發動",
  ["$thoojsdeek1"] = "看吾退敵",
  ["$thoojsdeek2"] = "殺汝个措手不及",
}

thoojsdeek:addEffect(fk.EventPhaseEnd, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target ~= player and player:hasSkill(thoojsdeek.name) and target.phase == Player.Judge
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local yes, ret = room:askToUseActiveSkill(player, {
      skill_name = "discard_skill", 
      prompt = "#thoojsdeek-invoke:"..target.id, 
      cancelable = true, 
      extra_data = {
        num = 1,
        min_num = 0,
        include_equip = true,
        skillName = thoojsdeek.name,
        -- pattern = "ssaet|.|.;.|.|.|.|.|weapon",
        -- pattern = ".|.|diamond;.|.|.|.|.|weapon",
        pattern = ".|.|.|.|.|weapon",
      }, 
      no_indicate = false,
      skip=true,

    })
    if yes then 
      event:setCostData(self, {cards = ret.cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
   local cards=event:getCostData(self).cards
    if #cards==0 then
      room:loseHp(player,1,thoojsdeek.name)
    else
      room:throwCard(cards,thoojsdeek.name,player,player)
    end
    if  #room:askToDiscard(target, {
      min_num = 1,
      max_num = 1,
      include_equip = true,
      skill_name = thoojsdeek.name,
      prompt = "#thoojsdeek-discard",
      pattern = "szjemh|.|heart",
      cancelable = true,
      skip = false,
    })==1 
    then       
      room:recover{
        who = player,
        num = 1,
        recoverBy = target,
        skillName = thoojsdeek.name,
      }
      return 
    end    
    local choice = room:askToChoice(player, {
      choices = {"thoojsdeek-damage","thoojsdeek-disequips","thoojsdeek-atkrange"},
      skill_name = thoojsdeek.name,
      prompt = "#thoojsdeek-choose",
    })
    if choice == "thoojsdeek-damage" then
      room:damage{
        to = target,
        from=player,
        damage = 1,
        damageType = fk.NormalDamage,
        skillName = thoojsdeek.name,
      }    
    elseif choice == "thoojsdeek-disequips" then
      room:throwCard(target:getCardIds("e"), thoojsdeek.name, target,player)  --弃牌被𢧵?
    elseif choice == "thoojsdeek-atkrange"  then
      room:addPlayerMark(target,"@thoojsdeek",1)
    end
  end,
})

thoojsdeek:addEffect("atkrange", {
  correct_func = function(self, player)
    if player:getMark("@thoojsdeek") >0 then
      return   -player:getMark("@thoojsdeek")
    end
  end
})

-- thoojsdeek:addEffect(fk.TurnEnd, {
--   is_delay_effect=true,
--   can_refresh = function(self, event, target, player, data)
--     return player==target and target:getMark("@thoojsdeek")>0
--   end,
--   on_refresh = function(self, event, target, player, data)
--     player.room:setPlayerMark(target,"@thoojsdeek",0)
--   end,
-- })

return thoojsdeek
