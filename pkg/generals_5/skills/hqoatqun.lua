local hqoatqun = fk.CreateSkill {
  name = "hqoatqun",
  tags = { Skill.Switch, Skill.Combo},
}
--龍鳳
Fk:loadTranslationTable{
  ["hqoatqun"] = "遏雲",
  [":hqoatqun"] = "記錄伱所用牌點數,需輪流發動.伱使用牌旹,若記錄爲遞{增/減}伱可發動,清除記錄,視爲伱對任一角色使用{桃/殺}",

  ["@hqoatqun"] = "遏雲",

  ["#hqoatqun-invoke"] = "遏雲：視爲使用%arg",


  ["$hqoatqun1"] = "胡未灭，家何为？",
  ["$hqoatqun2"] = "诸君且听，这雁门虎啸！"
}

hqoatqun:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hqoatqun.name) 
    and  data.extra_data and data.extra_data.combo_skill and data.extra_data.combo_skill[hqoatqun.name]
  end,
  on_cost = function (self, event, target, player, data)
    local room=player.room
    local name=player:getSwitchSkillState(hqoatqun.name)==fk.SwitchYang  and "nziuk" or "ssaet"
      local tos, cards = room:askToChooseCardsAndPlayers(player, {
        min_num = 1,
        max_num = 1,
        min_card_num = 0,
        max_card_num = 0,
        targets = room.alive_players,
        pattern = ".|.|.",
        skill_name = hqoatqun.name,
        prompt = "#hqoatqun-invoke:::"..name,
        cancelable = true,
        will_throw = true,
      })
    if #tos>0  then
        event:setCostData(self, {tos = tos})
        return true
    end
    end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local name= player:getSwitchSkillState(hqoatqun.name,true)==fk.SwitchYang  and "nziuk" or "ssaet"
    room:useVirtualCard(name, nil, player, event:getCostData(self).tos, hqoatqun.name, true)  --zzin souk
  end,
})

hqoatqun:addEffect(fk.AfterCardUseDeclared, {
  can_refresh = function (self, event, target, player, data)
    return target == player and player:hasSkill(hqoatqun.name, true)
  end,
  on_refresh = function (self, event, target, player, data)
    local room = player.room

    local number=data.card.number
    if number==0 then
      room:setPlayerMark(player,"@hqoatqun",0)
      return
    end

    local numbers=player:getTableMark("@hqoatqun") --質數?

    local ok=function()
        data.extra_data = data.extra_data or {}
        data.extra_data.combo_skill = data.extra_data.combo_skill or {}
        data.extra_data.combo_skill[hqoatqun.name] = true
    end

    local n = #numbers
    if n==0 then
      numbers={number}
    else
      if numbers[n]==number 
      or (player:getSwitchSkillState(hqoatqun.name)==fk.SwitchYang  and numbers[n]<number)
      or (player:getSwitchSkillState(hqoatqun.name)==fk.SwitchYin  and numbers[n]>number) then
        if  n>2  then
          numbers={numbers[n-1],numbers[n],number}
        else
          table.insert(numbers,number)
        end
      else
        numbers={number}
      end

    end
    if #numbers>2 then
      ok()
    end
    room:setPlayerMark(player,"@hqoatqun",numbers)
  end,
})

return hqoatqun
