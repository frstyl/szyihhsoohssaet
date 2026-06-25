local bxensmracs = fk.CreateSkill {
  name = "bxensmracs",
}

Fk:loadTranslationTable{
  ["bxensmracs"] = "拚命",
  [":bxensmracs"] = "當一其他角色致傷後，(若其未陣亾)伱可發動，伱減1體上限,与其相同傷害.當其他角色受伱傷害進入瀕死,伱可發動,其死,肰後伱死(凶手爲該角色)",

  ["#bxensmracs-discard"] = "拚命 %src  你可以反擊",

  ["$bxensmracs1"] = "一生",
}

bxensmracs:addEffect(fk.Damage, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return target~=player and  player:hasSkill(bxensmracs.name) 
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:changeMaxHp(player,-1)
    local damage=data
    damage.from=player
    damage.to=target
    damage.skillName=bxensmracs.name
    room:damage(damage)
  end,
})


bxensmracs:addEffect(fk.EnterDying, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target~=player and player:hasSkill(bxensmracs.name) 
    and data.killer==player
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:killPlayer{
      who = target,
      killer = player,
    }
    room:killPlayer{
      who = player,
      killer = target,
    }
  end,
  })

return bxensmracs
