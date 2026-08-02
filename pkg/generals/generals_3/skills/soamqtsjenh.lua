local soamqtsjenh = fk.CreateSkill {
  name = "soamqtsjenh",
  tags={Skill.Limited}
}
Fk:loadTranslationTable{
  ["soamqtsjenh"] = "三剪",
  [":soamqtsjenh"] = "局限1｡應動｡伱對其它脚色致傷後,伱可發動.伱減1體力上限,對全體脚色至受傷脚色距離爲1者相同傷害.",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

soamqtsjenh:addEffect(fk.Damage, {
  can_trigger = function(self, event, target, player, data)
    return data.from == player and data.to~=data.from and player:hasSkill(soamqtsjenh.name)
    and player:usedSkillTimes(soamqtsjenh.name, Player.HistoryGame)==0
    --and data.card and data.card.trueName=="ssaet"
  -- on_cost  = function(self, event, target, player, data)
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    room:changeMaxHp(player, -1)
    local n = data.damage

    local param={
    from=data.from,
    to=data.to,
    damage=n,
    card=data.card,
    chain=data.chain,
    damageType=data.damageType,
    skillName=data.skillName,
    beginnerOfTheDamage=data.beginnerOfTheDamage,
    by_user=false,
    chain_table=data.chain_table,
    isVirtualDMG=data.isVirtualDMG,  --??
    -- dealtRecorderId=data.dealtRecorderId,  --??
    extra_data = data.extra_data or {},
    }

    local tos=table.filter(player.room.alive_players, function(p)
      return p:compareDistance(data.to, 1, "==")
    end)

    room:sortByAction(tos)
    for _, p in ipairs(tos) do
      local t=table.simpleClone(param)  --😓️
      t.to=p
      room:damage(t)
    end
  end,
})
return soamqtsjenh
