local tszjipsziuh = fk.CreateSkill {
  name = "tszjipsziuh",
}

Fk:loadTranslationTable{
  ["tszjipsziuh"] = "執守",
  [":tszjipsziuh"] = "當伱進入瀕死旹,伱可預弃全部手牌(至少1)發動.伱回x抽y({x/y}爲所弃牌中{紅牌/黑牌}數)",

  -- ["#tszjipsziuh"] = "執守 隨機獲得1此花色坐騎牌",
  ["#tszjipsziuh-choose"] = "執守 選擇1坐騎牌",

  -- ["$tszjipsziuh1"] = "相得好馬,贈与良將",
}


tszjipsziuh:addEffect(fk.EnterDying, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(tszjipsziuh.name) 
    and not player:isKongcheng()
  end,
  on_use = function(self, event, target, player, data)
   local cards=player:getCardIds("h")
   local n=0
   local m=0
   for _,id in ipairs(cards) do 
    local c=Fk:getCardById(id).color
    if c==Card.Red then
      n=n+1
    elseif c==Card.Black then
      m=m+1
    end
   end
   if player.dead then return end
  local room=player.room
   room:throwCard(cards,tszjipsziuh.name,player,player)
   if player.dead then return end
    room:recover{
        who = player,
        num = n,
        card = nil,
        recoverBy = player,
        skillName = tszjipsziuh.name,
      }
   if player.dead then return end
    player:drawCards(m,tszjipsziuh.name)
end,
})

return tszjipsziuh
