local siuqmiuk = fk.CreateSkill {
  name = "siuqmiuk",
}

Fk:loadTranslationTable{
  ["siuqmiuk"] = "修睦",
  [":siuqmiuk"] = "伱受其它脚色致傷後,其它脚色受伱致傷後,若對方存活,伱可發動,伱与其各抽1,展示之,若同色,受傷者回1。",  --獲得殺?

  ["@siuqmiuk-turn"] = "修睦",

  ["$siuqmiuk1"] = "百步之內,取汝性命",
  ["$siuqmiuk2"] = "著我玄天混元修睦",
  ["$siuqmiuk3"] = "修睦破空",
}


siuqmiuk:addEffect(fk.Damaged, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)  --每个player 緟數ids? 
    return player:hasSkill(siuqmiuk.name) and data.from and data.from~=data.to
    and ((player==target  and not data.from.dead)
    or (player==data.from   and not data.to.dead)
  )

  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local to = player==data.from and data.to or data.from
    if room:askToSkillInvoke(player, {
      skill_name = siuqmiuk.name,
      prompt = "#siuqmiuk-invoke::"..to.id,
    }) then
      -- event:setCostData(self, {tos = {data.to}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local c1=player:drawCards(1,siuqmiuk.name)
    local c2= data.from:drawCards(1,siuqmiuk.name)
    if player.dead then return end
        player:showCards(result[player])
        p:showCards(result[p])

        if result[player][1] and result[p][1] then
          if Fk:getCardById(result[player][1] ).compareColorWith(Fk:getCardById(result[p][1] )) then
            room:recover{
              who = data.to,
              num = 1,
              recoverBy = player,
              skillName = theevqdoat.name,
            }
          end
        end

end,})


return siuqmiuk
