local hqximhquoh = fk.CreateSkill {
  name = "hqximhquoh",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["hqximhquoh"] = "飲羽",
  [":hqximhquoh"] = "➀恆續,伱攻程(0級)基值爲5➁伱起動｢殺｣指定唯一目幖後必發,若:(伱至目幖距離)=(伱攻程),目幖不可響應此牌;(此牌點數)与(目幖體力值)可整除,此牌對目幖傷害基數+1｡若皆有,此殺无視目幖防具;皆不滿足,伱褈鑄手牌",
  -- [":hqximhquoh"] = "➀恆續,伱基礎攻程(无視武器)爲0➁伱起動殺指定目幖後必發,若x≤y,目幖不可響應此牌.若x≥y,此殺對目幖傷害基數+1(x爲伱至目幖距離,y爲伱攻程)",
}
--應爲幾級fix
local S = require "packages/szyihhsoohssaet/szyih_guos" 


hqximhquoh:addEffect(fk.TargetSpecified, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from == player 
    and player:hasSkill(hqximhquoh.name) 
    and data.card.trueName == "ssaet"
	and data:isOnlyTarget(data.to)
     -- and player:distanceTo(data.to) <= player:getAttackRange()
  end,
  on_use = function(self, event, target, player, data)
    -- player:broadcastSkillInvoke(hqximhquoh.name)
    -- player.room:notifySkillInvoked(player, hqximhquoh.name, "defensive")
    local n=0
    if player:distanceTo(data.to) == player:getAttackRange() then
      data.disresponsive = true
      n=1
    end
    -- if player:getHandcardNum() == data.to.hp then
    if data.card.number %data.to.hp==0 or data.to.hp %data.card.number==0 then
      data.additionalDamage =(data.additionalDamage or 0) +1
      n=n+1
    end
    if n==2 then
      data.extra_data =data.extra_data or {}
      data.extra_data.ignore_Armor_to=data.extra_data.ignore_Armor_to or {}
      table.insertIfNeed(data.extra_data.ignore_Armor_to, data.to)
      -- player.room:addPlayerMark(data.to, "@@MarkArmorNullified-turn",1)
      -- player.room:addPlayerMark(data.to, MarkEnum.UncompulsoryInvalidity .. "-turn")
  	elseif n ==0 then
	  	player.room:recastCard(player:getCardIds("h"),player,hqximhquoh.naem)
    end
  end,
})




hqximhquoh:addEffect("atkrange", {
  virtual_weapon_func = function (self, player)  --final_func  --virtual_weapon_func
    if player:hasSkill(hqximhquoh.name) and not S.hasEquip(player,Card.SubtypeWeapon) then  --覆蓋武器?
      return 5
    end
  end
})

return hqximhquoh
