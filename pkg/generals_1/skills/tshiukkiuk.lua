


local tshiukkiuk= fk.CreateSkill({
  name = "tshiukkiuk",
})

Fk:loadTranslationTable{
["tshiukkiuk"] = "蹴鞠",
[":tshiukkiuk"] = "當伱受傷旹,伱可發動.伱判定,若判定牌爲黑,伱可打出1手牌,將傷害轉予1其它角色",

["#tshiukkiuk-discard"] = "蹴鞠 打出1手牌 轉迻傷害",

["$tshiukkiuk1"] = "有此絕技休想傷我",

}

local S = require "packages/szyihhsoohssaet/szyih_guos"

tshiukkiuk:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
	can_trigger = function(self, event, target, player, data)
		return target == player  and player:hasSkill(tshiukkiuk.name)
	end,
	on_use = function(self, event, target, player, data)  --jujkeir
    local room = player.room
    local room = player.room
    local judgeData = {
      who = player,
      reason = tshiukkiuk.name,
      pattern = ".|.|black",
    }
    room:judge(judgeData)
    if   judgeData.card.color~=Card.Black then  return end

    local tos, cards = player.room:askToChooseCardsAndPlayers(player,{
        min_num = 1,
        max_num = 1,
        min_card_num = 1,
        max_card_num = 1,
        targets = player.room:getOtherPlayers(player,false),
        pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
          return not player:prohibitResponse(Fk:getCardById(id))
        end
        ) }),
        skill_name = tshiukkiuk.name,
        prompt = "#tshiukkiuk-discard",
        cancelable = true,
        will_throw=true,
        -- expand_pile = ids,
    })
    if #cards > 0 and #tos>0 then
      S.playCard(player,cards,tshiukkiuk.name)
      if not tos[1].dead then
        data.to=tos[1]
        target = tos[1]
        -- room.logic:trigger(fk.DamageInflicted, tos[1], data)
      -- data.prevented=true
        return true
      end
 
    end
     -- room:damage{
      --   from = data.from,
      --   to = to,
      --   damage = n,
      --   damageType = data.damageType,
      --   skillName = data.skillName,
      --   chain = data.chain,
      --   card = data.card,
      -- }

  end,
})

return tshiukkiuk

