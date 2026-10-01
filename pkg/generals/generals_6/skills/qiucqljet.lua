local qiucqljet = fk.CreateSkill {
  name = "qiucqljet",
}

Fk:loadTranslationTable{
["qiucqljet"] = "雄烈",
[":qiucqljet"] = "伱起動殺指定目幖後伱可發動.伱与其同旹投出0至多手牌,若伱較其:手牌數差非正,此殺對其傷害基數+1;投出牌數差非負,其隨機弃置其手牌區1閃且不可抵消此殺｡",  --謀奕猜拳眞行

["#qiucqljet-invoke"] = "雄烈 是否對%src 發動",
["#qiucqljet-discard"] = "雄烈 投出手牌",
-- ["#qiucqljetResult"] = "雄烈: %from 于 %to 手牌數 %arg",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

qiucqljet:addEffect(fk.TargetConfirmed, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from ==player and player:hasSkill(qiucqljet.name) and data.card.trueName == "ssaet" 
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = qiucqljet.name,
      prompt = "#qiucqljet-invoke:"..data.to.id,
    }) 
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local to =data.to
    local param={
      players = { player, to },
      min_num = 0,
      max_num = 999,
      cancelable = false,
      skill_name = qiucqljet.name,
      prompt = "#qiucqljet-discard",
      -- will_throw = true,
      pattern=".",
    }

    local pattern=table.filter( player:getCardIds("h"),function(id) return  not player:prohibitResponse(Fk:getCardById(id)) end )
    table.insertTable(pattern, table.filter( to:getCardIds("h"),function(id) return  not to:prohibitResponse(Fk:getCardById(id)) end ))
    local result = room:askToJointCards(player, param)


    -- local result =  S.askToChooseCardExclusively(player, param, fk.ReasonResponse)
    local moves = {}
    local dis={}
    local card_ids={}
    for _, p in ipairs({ player, to }) do
      local cards = result[p] or {}
      dis[p]=#cards 
      moves[p]={card_ids=cards, skillName=qiucqljet.name,from=p}
      table.insertTable(card_ids,cards)
        -- table.insert(moves, {
        --   ids = cards,
        --   from = p,
        --   toArea = Card.DiscardPile,
        --   moveReason = fk.ReasonResponse,
        --   proposer = p,
        --   skillName = qiucqljet.name,
        -- })
    end
    -- room:moveCards(table.unpack(moves))
    -- S.playCardSimultaneously(moves)
    room:moveCardTo(card_ids, Card.DiscardPile, nil, fk.ReasonResponse)
    if to.dead then return end

    local n = player:getHandcardNum()-to:getHandcardNum()

    -- room:sendLog{
    --     type = "#qiucqljetResult",
    --     from = player.id,
    --     to = {to.id},
    --     arg = n<0 and "較小" or (n==0 and "等同" or ("較大") ),
    -- }
    if n<=0 then
        data.additionalDamage = (data.additionalDamage or 0) + 1
    end


    if dis[player]-dis[to] >= 0 then
        local cards = table.filter(to:getCardIds("h"), function (id)
        local card = Fk:getCardById(id)
          return card.trueName == "szjemh" and not to:prohibitUse(card)
      end)
      if #cards==0 then return end
        room:throwCard(room:tableRandomPick(cards,1), qiucqljet.name, to, to)
    end

  end,
})

return qiucqljet
