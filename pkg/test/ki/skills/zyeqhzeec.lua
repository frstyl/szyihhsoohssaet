local zyeqhzeec = fk.CreateSkill {
  name = "zyeqhzeec",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["zyeqhzeec"] = "隨形",
  [":zyeqhzeec"] = "若場上一裝僃无其它同子類牌,伱視爲裝僃之｡若場上有脚色手牌數冣多,伱可如手牌起動演練其手牌", --視爲有其它脚色坐騎技能
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 



zyeqhzeec:addEffect("atkrange", {
  virtual_weapon_func = function(self, player)
    if player:hasSkill(zyeqhzeec.name) then
      local t={}
      for _, p in ipairs(Fk:currentRoom().alive_players) do
        table.insertTableIfNeed(t,p:getEquipCards(Card.SubtypeWeapon))
        if #t>1 then return end
      end
      if t[1] then
      return  t[1].attack_range
      end
    end
  end,
})

zyeqhzeec:addEffect("filter", {
  skill_filter = function (self, player)
    if table.contains(player:getSkillNameList(), zyeqhzeec.name) and
      Fk.skills[zyeqhzeec.name]:isEffectable(player) 
    then
      local skills = {}
      -- local cards={
      --   [Card.SubtypeWeapon] ={},
      --   [Card.SubtypeArmor] ={},
      --   [Card.SubtypeDefensiveRide] ={},
      --   [Card.SubtypeOffensiveRide] ={},
      --   [Card.SubtypeTreasure] ={},
      -- }
      local cards={}
      for _, sub_type in ipairs({Card.SubtypeWeapon,Card.SubtypeArmor,Card.SubtypeDefensiveRide,Card.SubtypeOffensiveRide,Card.SubtypeTreasure,}) do
        local equip = nil
        for _, p in ipairs(Fk:currentRoom().alive_players) do
            for _, card in ipairs(p:getEquipCards(sub_type)) do
              if equip==nil then
                equip=card
              else
                equip=false
              end
            end
          if equip then table.insertIfNeed(cards,equip) end
        end
      end

      for _, card in ipairs(cards) do
        -- if #t==1 then
             table.insertTableIfNeed(skills, table.map(card:getEquipSkills(player), function (s)  --動態技能
                return s.name
              end))
        -- end
      end

      return skills
    end
  end,
  handly_cards = function (self, player)
  if player:hasSkill(zyeqhzeec.name) then
    local n=0
    local to =player
    for _, p in ipairs(Fk:currentRoom().alive_players) do
      local m = p:getHandcardNum()
      if m>n then
        n=m
        to=p
      end
    end
    if to ~=player then return to:getCardIds("h") end
  end
  end,
})
return zyeqhzeec
