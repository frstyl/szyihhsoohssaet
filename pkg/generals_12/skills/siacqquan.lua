local siacqquan = fk.CreateSkill({
  name = "siacqquan",
})

Fk:loadTranslationTable{
  ["siacqquan"] = "相援",
  [":siacqquan"] = "一脚色A失去全部手牌後,伱可發動｡除A外脚色可各選1牌,將所選同旹交与伱,伱交予A等量手牌",

  ["#siacqquan-choose"] = "相援 選擇目幖",
  ["#siacqquan-give"] = "相援 交与 %src 1牌",
  ["#siacqquan-giveTo"] = "相援 交与 %src %arg 牌",

  ["$siacqquan1"] = "人人爲公,天下大同",
  ["$siacqquan2"] = "有福同享,有難同當",
}
siacqquan:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(siacqquan.name) then return end
    
    if event:getCostData(self) and event:getCostData(self).khouc then
      return #event:getCostData(self).khouc > #event:getCostData(self).choosed
    else
      local khouc={}
        for _, p in ipairs(player.room.alive_players) do
          if p:isKongcheng() then  --同旹迻動是否可能多次迻動中途空城 本就空城是否可能觸發 #
            for _, move in ipairs(data) do
              if move.from == p then
                for _, info in ipairs(move.moveInfo) do
                  if info.fromArea == Card.PlayerHand then
                    table.insertIfNeed(khouc,p)
                    goto continue
                  end
                end
              end
            end
            ::continue::
          end
        end
      if #khouc>0 then
        event:setCostData(self,{khouc=khouc,choosed={}})
        return true
      end
    end

  end,
  trigger_times = function(self, event, target, player, data)
    return 999
  end,
  on_cost = function(self, event, target, player, data)
    local dat= event:getCostData(self)
    local tobe = table.filter(dat.khouc, function(p)
    return not table.contains(dat.choosed,p) end
    )
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = tobe,
      skill_name = siacqquan.name,
      prompt = "#siacqquan-choose",
      cancelable = true,
    })
    if #tos>0 then
      table.insert(dat.choosed,tos[1])
      event:setCostData(self,{khouc=dat.khouc,choosed=dat.choosed,tos=tos})
      return true
    else
      event:setCostData(self,{khouc=dat.khouc,choosed={}})
    end
  end,
  on_use = function(self, event, target, player, data)
    local to =event:getCostData(self).tos[1]
    local room=player.room
    local targets=table.filter(room.alive_players,function(p)
    return  p~=to and not p:isKongcheng()
    end)
    local result = room:askToJointCards(player, {  --包含自己?
      players = targets,
      min_num = 1,
      max_num = 1,
      cancelable = true,
      skill_name = siacqquan.name,
      prompt = "#siacqquan-give:" .. to.id,
    })
    local moveInfos = {}
    local n = 0
    for _, p in ipairs(targets) do
      n= n + #result[p]
      table.insert(moveInfos, {
        ids = result[p],
        from = p,
        to = player,  --
        toArea = Card.PlayerHand,
        moveReason = fk.ReasonGive,
        proposer = p,
        skillName = siacqquan.name,
      })
    end
    room:moveCards(table.unpack(moveInfos))
    -- if to==player then return end
    if n==0 then return end
    local cards = room:askToCards(player, {
      min_num = n,
      max_num = n,
      include_equip = false,
      prompt = "#siacqquan-giveTo:" .. to.id.."::"..n,
      skill_name = siacqquan.name,
      cancelable = false,
    })
    if #cards>0 then 
      room:moveCardTo(cards, Player.Hand, to, fk.ReasonGive, siacqquan.name, nil, false, player.id)
    end
  end,
})

return siacqquan
