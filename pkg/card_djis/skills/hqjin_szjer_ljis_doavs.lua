local cardSkill = fk.CreateSkill {
  name = "hqjin_szjer_ljis_doavs_skill",
}
Fk:loadTranslationTable{
  -- ["hqjin_szjer_ljis_doavs_skill"] = "因勢利導",
  ["#hqjin_szjer_ljis_doavs_skill"] = "當1角色受屬性傷害旹,對其下家或下家使用.傳導傷害",
  ["#hqjin_szjer_ljis_doavs_use"] = " %src 受屬性傷害 是否使用因勢利導",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#hqjin_szjer_ljis_doavs_skill",
  target_num = 1,
  -- can_use = Util.FalseFunc, --沒用
  -- can_use = function(self, player, card, extra_data)  --響應
  --   return extra_data 
  -- end,
  can_use = Util.FalseFunc,
  -- mod_target_filter = function(self, player, to_select, selected, card)  --由response定
  --   return to_select ~= player 
  -- end,
  mod_target_filter = Util.TrueFunc,  --chain
  target_filter = Util.CardTargetFilter,
  -- mod_target_filter = Util.TrueFunc,
  -- about_to_effect = function(self,room,effect)
  --   return not ( extra_data and  extra_data.hqjin_szjer_ljis_doavs)
  -- end,
  -- on_use = function(self, room, use)
  --   if not use.extra_data then
  --     return true
  --   end
  -- end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if not effect.extra_data or not effect.extra_data.hqjin_szjer_ljis_doavs then 
      return
    end
    ---@field public from? ServerPlayer @ 伤害来源
    ---@field public to ServerPlayer @ 伤害目标
    ---@field public damage integer @ 伤害值
    ---@field public card? Card @ 造成伤害的牌
    ---@field public chain? boolean @ 伤害是否是铁索传导的伤害
    ---@field public damageType? DamageType @ 伤害属性
    ---@field public skillName? string @ 造成本次伤害的技能名
    ---@field public beginnerOfTheDamage? boolean @ 是否是本次铁索传导的起点
    ---@field public by_user? boolean @ 是否由卡牌直接生效造成的伤害
    ---@field public chain_table? ServerPlayer[] @ 处于连环状态的角色表
    ---@field public isVirtualDMG? boolean @ 是否是虚拟伤害
    ---@field public dealtRecorderId integer? @ “实际造成的伤害”中对应的事件ID
    ---@field public prevented boolean? @ 伤害是否被防止
    local damage={}
    damage.from=effect.extra_data.hqjin_szjer_ljis_doavs.from
    damage.to=effect.to
    damage.damage=effect.extra_data.hqjin_szjer_ljis_doavs.damage
    damage.card=effect.extra_data.hqjin_szjer_ljis_doavs.card
    damage.chain=effect.extra_data.hqjin_szjer_ljis_doavs.chain
    damage.damageType=effect.extra_data.hqjin_szjer_ljis_doavs.damageType
    damage.skillName=effect.extra_data.hqjin_szjer_ljis_doavs.skillName
    damage.beginnerOfTheDamage=effect.extra_data.hqjin_szjer_ljis_doavs.beginnerOfTheDamage
    damage.by_user=false
    damage.chain_table=effect.extra_data.hqjin_szjer_ljis_doavs.chain_table
    damage.isVirtualDMG=effect.extra_data.hqjin_szjer_ljis_doavs.isVirtualDMG  --??
    -- damage.dealtRecorderId=effect.extra_data.hqjin_szjer_ljis_doavs.dealtRecorderId  --??
    damage.extra_data = effect.extra_data.hqjin_szjer_ljis_doavs.extra_data or {}
    damage.extra_data.hqjin_szjer_ljis_doavs= effect.extra_data.hqjin_szjer_ljis_doavs
    damage.event_data= effect.extra_data.hqjin_szjer_ljis_doavs.event_data
    room:damage(damage)
    -- damage.prevented=effect.extra_data.hqjin_szjer_ljis_doavs.prevented  --??

    -- if not (effect.extra_data and  effect.extra_data.hqjin_szjer_ljis_doavs) then 
    --   effect.from:drawCards(1,cardSkill.name)
    -- return end

    -- local damage= effect.extra_data.hqjin_szjer_ljis_doavs.damage

    -- damage.to = effect.to  -- 爲何不統一用id
    -- damage.chain=true
    -- if damage.card then
    --   damage.card=Fk:getCardById(damage.card) 
    -- end

    -- if effect.extra_data.hqjin_szjer_ljis_doavs.direction then
    --   damage.extra_data=damage.extra_data or {}
    --   damage.extra_data.hqjin_szjer_ljis_doavs={}
    --   damage.extra_data.hqjin_szjer_ljis_doavs.direction=effect.extra_data.hqjin_szjer_ljis_doavs.direction
    -- end
    -- -- if damage.direction==1 then 
    -- --   effect.from:drawCards(1, cardSkill.name)
    -- -- end
    -- room:damage(damage)

  end,
})

cardSkill:addEffect(fk.Damaged, {
  priority = 0,  --  -999?  在傷害事件後 DamageFinished?
  global = true,
  can_trigger = function(self, event, target, player, data)
    if   target==player  --同旹 止問1次
    and Fk:canChain(data.damageType)   
    and not data.prevented
    -- and  --同旹 止問1次
    -- and not 
    then
      local players=S.getHolders({"hqjin_szjer_ljis_doavs"})
      -- local players=player.room.alive_players
      if  #players > 0  then
        event:setCostData(self,{players=players})
        return  true
      end
    end
  end,
  on_trigger = function(self, event, target, player, data)
    -- data.extra_data.hqjin_szjer_ljis_doavs.chain_table  = data.extra_data.hqjin_szjer_ljis_doavs.chain_table or {data.to.id}

    local room = player.room
    local targets ={}
    local direction 
    if data.extra_data and data.extra_data.hqjin_szjer_ljis_doavs and data.extra_data.hqjin_szjer_ljis_doavs.direction then
      direction = data.extra_data.hqjin_szjer_ljis_doavs.direction

      targets ={S.getNextOne(data.to,direction)}

    else
      targets={S.getNextOne(data.to,1), S.getNextOne(data.to,-1)}
    end
    targets=table.map(targets, Util.IdMapper)

    if #targets==0 then return end

    local params={  --旣視感--askToUseRealCard active  非askForUse 无旹機 can_use有效
      pattern = "hqjin_szjer_ljis_doavs",
      skill_name = "hqjin_szjer_ljis_doavs",  --提示
      prompt = "#hqjin_szjer_ljis_doavs_use:"..target.id,
      cancelable = true,
      -- skip = true,
      -- event_data = data,
      extra_data = {
        exclusive_targets = targets,  --此中選 --又用Id矣  --不能多選目幖?
        -- bypass_distances = true,  --渻?
        -- bypass_times = true,
        -- extraUse = true,
      }
    }
    
    local use = room:askToNullification(event:getCostData(self).players, params)  --選上家再選下家?

    if not use then return end

    if direction==nil then
      direction = use.tos[1]==S.getNextOne(data.to) and 1 or -1
    end
    use.extra_data = use.extra_data  or {}  --爲何要再寫
    use.extra_data.hqjin_szjer_ljis_doavs=data
    use.extra_data.hqjin_szjer_ljis_doavs.direction=direction
    use.responseToEvent=data
      -- use.extra_data.hqjin_szjer_ljis_doavs.damage={}
      -- use.extra_data.hqjin_szjer_ljis_doavs.damage.to = data.to.id  -- 爲何不統一用id
      -- use.extra_data.hqjin_szjer_ljis_doavs.damage.damage = data.damage  --num
      -- use.extra_data.hqjin_szjer_ljis_doavs.damage.damageType = data.damageType  --num
      -- use.extra_data.hqjin_szjer_ljis_doavs.damage.skillName = data.skillName  --?str
      -- use.extra_data.hqjin_szjer_ljis_doavs.damage.chain = data.chain  --bool
      -- use.extra_data.hqjin_szjer_ljis_doavs.damage.card = data.card and data.card.id   or nil  --doac


      -- local use_result=
      room:useCard(use)
      -- data.extra_data=      data.extra_data or {}
      -- data.extra_data.hqjin_szjer_ljis_doavs=true  --止1次


  end,
})

return cardSkill

