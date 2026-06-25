local tszjevqhqoan = fk.CreateSkill {
  name = "tszjevqhqoan",
}

Fk:loadTranslationTable{
  ["tszjevqhqoan"] = "招安",
  [":tszjevqhqoan"] = "主動.選擇1其它角色A与1項發動➀對1角色(除伱与A)使用1殺➁交与伱1殺或武器牌.若A執行,其抽2,否則其本轉不可使用打出基本牌",

  ["#tszjevqhqoan-active"] = "招安.選擇1項發動",
  ["#tszjevqhqoan-ssaet"] = "用殺",
  ["#tszjevqhqoan-ssaet-subTargets"] = "選擇殺目幖",
  ["#tszjevqhqoan-ssaet-ask"] = "招安 對 %src 使用殺",
  ["#tszjevqhqoan-give"] = "交牌",

  ["@@tszjevqhqoan-turn"] = "招安",
}
tszjevqhqoan:addEffect("active", {
  anim_type = "support",
  prompt = "#tszjevqhqoan-active",
  target_num = 1,
  card_num=0,
  max_phase_use_time=1,
  target_filter = function(self, player, to_select, selected)
    return #selected == 0 and to_select ~= player
  end,
  interaction = function(self, player)
    local choices={"#tszjevqhqoan-give","#tszjevqhqoan-ssaet"}
    -- local choice = player.room:askToChoice(player, {
    --   choices = choices,
    --   skill_name = khiochhsaas.name,
    --   prompt = "#tszjevqhqoan-choose",
    -- })
        return UI.ComboBox {
      choices = choices
    }
  end,
  on_use = function(self, room, effect)
    local target = effect.tos[1]
    local player = effect.from
    local isdone = false
    choice=self.interaction.data
    --1
    if choice == "#tszjevqhqoan-give" then
        card = room:askToCards(target,{
        min_num=0,
        max_num=1,
        include_equip=true,
        pattern = "ssaet|.|.;.|.|.|.|.|weapon",
        })
        if #card~=0 then
-- function MoveEventWrappers:moveCardTo(card, to_place, target, reason, skill_name, special_name, visible, proposer, moveMark, visiblePlayers)

        room:moveCardTo(card, Player.Hand, player, fk.ReasonGive, tszjevqhqoan.name, nil, false, target)
        isdone=true
        end
    else 
        local targets = table.filter(room.alive_players,function(p)
            return p~=player and p~=target
            end)
        if #targets ==0 then
        room:setPlayerMark(target, "@@tszjevqhqoan-turn",1)
        return
        end    
        subTargets = room:askToChoosePlayers(player,{ 
            min_num = 1,
            max_num = 1,
            targets = targets,
            prompt = "#tszjevqhqoan-ssaet-subTargets",
        })
        local use = room:askToUseCard(target, { 
          skill_name = "ssaet", 
          pattern = "ssaet", 
          prompt = "#tszjevqhqoan-ssaet-ask:" .. subTargets[1].id,
          cancelable = true, 
          extra_data = {
            must_targets = table.map(subTargets, Util.IdMapper),
            bypass_times = true,
        },
         })
        if use then
            use.extraUse = true
            isdone=true
            room:useCard(use)
        end
    end
    --2
    if isdone==true then
        target:drawCards(2,tszjevqhqoan.name)
    else 
        room:setPlayerMark(target, "@@tszjevqhqoan-turn",1)
    end
  end,
})

tszjevqhqoan:addEffect("prohibit", {  --不能使用打出同色牌 元版不能 轉化後牌不能 轉化歬牌不能 --肰則牌名殺?
  prohibit_use = function(self, player, card)
    if player:getMark("@@tszjevqhqoan-turn")~=0 and card.type==Card.TypeBasic then
      local subcards = card:isVirtual() and card.subcards or {card.id}
      return #subcards > 0
    end
  end,
  prohibit_response = function(self, player, card)
    if player:getMark("@@tszjevqhqoan-turn")~=0 and card.type==Card.TypeBasic then
      local subcards = card:isVirtual() and card.subcards or {card.id}
      return #subcards > 0
    end
  end,
})

return tszjevqhqoan
