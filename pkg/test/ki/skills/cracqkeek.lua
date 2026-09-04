local cracqkeek = fk.CreateSkill {
  name = "cracqkeek",
}

Fk:loadTranslationTable{
  ["cracqkeek"] = "迎擊",
  [":cracqkeek"] = "一其它脚色A起動｢殺｣旹,若伱在A攻程內,伱可打出1牌B發動｡伱獲得1空,若B爲:｢殺｣,伱无效此起動;｢閃｣,A可弃置1武器(武器欄中武器牌),不執行則作爲起動目幖(清除其它目幖);其它,伱取得起動牌(子牌)",

  ["#cracqkeek-invoke"] = "迎擊  %src起動 %arg, 伱可打出牌 ",
  ["#cracqkeek-discard"] = "迎擊 弃武器",

  ["$cracqkeek1"] = "吾乃兀顏統軍帳下先鋒",
  ["$cracqkeek2"] = "戰書已下開戰",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cracqkeek:addEffect(fk.CardUsing, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target~=player and  player:hasSkill(cracqkeek.name) and data.card.trueName=="ssaet"
    -- and data.from:inMyAttackRange(player)
    -- and not (data.extra_data and data.extra_data.nullified)
    end,
    on_cost = function(self, event, target, player, data)
      local cards=player.room:askToCards(player,{
			min_num=1,
			max_num=1,
			include_equip=true,
			pattern=".",
      prompt = "#cracqkeek-invoke:"..target.id.."::"..data.card:toLogString(),
			cancelable = true,
		})
      if #cards==1 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local card =Fk:getCardById(event:getCostData(self).cards[1])
    S.playCard(event:getCostData(self).cards,cracqkeek.name,player)

    if not player.dead then room:obtainCard(player, S.getKhouc(1), false, fk.ReasonJustMove, player, cracqkeek.name) end
      

    if card.trueName=="ssaet" then
      S.useNullify(data,player,cracqkeek.name)
    elseif card.trueName=="szjemh" then 

      local weapons=data.from:getEquipments(Card.SubtypeWeapon)
      -- weapons=table.filter(weapons,function(id)
      -- return Fk:getCardById(id).sub_type==Card.SubtypeWeapon  --??
      -- end)
      local discard=false
      if #weapons~=0 then 
        local cards= room:askToDiscard(data.from,{
            min_num=1,
            max_num=1,
            include_equip=true,
            pattern =tostring(Exppattern{ id =weapons  }),
            cancelable=true,
            prompt="#cracqkeek-discard",
            skip=true,
          })
        if #cards>0 then
          discard=true
          room:throwCard(cards, cracqkeek.name, data.from, data.from)
          return
        end
      end

      if not discard then
        -- table.insert(data.tos,data.from)
        data.tos={data.from}
      end
    else
      if player.dead then return end
      local cards = room:getSubcardsByRule(data.card, { Card.Processing })
      if #cards~=0 then room:obtainCard(player, cards, false, fk.ReasonPrey, player, cracqkeek.name) end
    end
 
  end,
})

return cracqkeek
