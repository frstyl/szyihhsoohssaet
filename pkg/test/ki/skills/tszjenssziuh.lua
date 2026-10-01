local tszjenssziuh = fk.CreateSkill{
  name = "tszjenssziuh",
}

Fk:loadTranslationTable{
  ["tszjenssziuh"] = "戰守",
  [":tszjenssziuh"] = "應動｡一腳色A成爲傷害牌目幖旹,若(詢問旹)其在其攻程內,伱可与起動者A賭鬥發動｡若賭鬥牌皆爲:進攻牌,B加入起動目幖;非進攻牌,起動對A无效",

  ["#tszjenssziuh-invoke"] = "戰守： %src 是否發動",

  ["$tszjenssziuh1"] = "吾已埋下伏兵，敌兵一来，管教他瓮中捉鳖。",
  ["$tszjenssziuh2"] = "我已设下重重圈套，就等敌军入彀矣。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tszjenssziuh:addEffect(fk.TargetConfirmed, {
  anim_type = "defensive",
  can_trigger= function(self, event, target, player, data)
    return data.to and data.from and data.from~=player and player:hasSkill(tszjenssziuh.name)
    and data.card.is_damage_card
    and (player:inMyAttackRange(data.to) or data.to==player)
    and player:canPindian(data.from)
  end,
  on_cost = function(self, event, target, player, data)
    if player.room:askToSkillInvoke(player,{skill_name="tszjenssziuh",prompt="#tszjenssziuh-invoke:"..data.to.id..":"..data.from.id}) then
      event:setCostData(self,{tos={data.from}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = data.from
    local pindian = player:pindian({to}, tszjenssziuh.name)
    local c2= pindian.results[to].toCard 
    local c1=  pindian.fromCard
    if not c1 or not c2 then return end
    if   S.isAttackCard(c1)   and S.isAttackCard(c2)  then --c1.is_damage_card and c2.is_damage_card
      table.insert(data.use.tos,data.from)
    elseif not S.isAttackCard(c1)   and not S.isAttackCard(c2)  then
      data:setNullified(data.to)
    end

  end,
})


return tszjenssziuh
