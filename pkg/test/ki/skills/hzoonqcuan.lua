local hzoonqcuan = fk.CreateSkill {
  name = "hzoonqcuan",
  tags={Skill.Switch}
}

Fk:loadTranslationTable{
  ["hzoonqcuan"] = "渾元",
  [":hzoonqcuan"] = "伱攻程內脚色受傷旹,伱可發動.其占卜,伱可打出与占卜牌{異色/同色}牌令傷害值{-1/+1}",

  ["#hzoonqcuan-invoke"] = "渾元：%src 受傷,是否發動",

  ["#hzoonqcuan1-invoke"] = "渾元：你可打出黑牌令 %dest 所受傷+1",
  ["#hzoonqcuan2-invoke"] = "渾元：你可打出紅牌令 %dest 所受傷-1",
}

local spec = {

}


hzoonqcuan:addEffect(fk.DamageInflicted, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(hzoonqcuan.name)
    and (player:inMyAttackRange(target) or target==player)
    and not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room

    return room:askToSkillInvoke(player,{
      skill_name = buyi.name,
      prompt = "#hzoonqcuan-invoke::"..target.id,
    })

  end,
  on_use = function(self, event, target, player, data)
    local room = player.room


    local judge = {
      who = target,
      reason = hzoonqcuan.name,
      pattern = ".|.|^nosuit",
    }
    room:judge(judge)
    if not judge:matchPattern() or  player.dead then return end
    
    local switch=player:getSwitchSkillState(hzoonqcuan.name) == fk.SwitchYang 
    local prompt
    local pattern

    if switch then
      prompt = "#hzoonqcuan1-invoke:"..target.id.. ":" ..Card.Black
      pattern= '.|.|spade,club"'
    else
      prompt = "#hzoonqcuan2-invoke::"..target.id.. ":" .. Card.Red
      pattern = ".|.|heart,diamond"
    end
        local response = player.room:askToResponse(player,{ ---@type AskToUseCardParams
        skill_name = hzoonqcuan.name,
        pattern = pattern,
        prompt =prompt,
        cancelable = true,
		--   include_equip = true,
        -- event_data = effect  --hzoonqcuan
      })
      if not response then return end
      if switch then
    S.changeDamage({damageData=data,num=1,skillName=hzoonqcuan.name})
      else
    S.changeDamage({damageData=data,num=-1,skillName=hzoonqcuan.name})
      end
    -- end
  end,
})

return hzoonqcuan
