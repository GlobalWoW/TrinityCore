/*
 * Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Cell.h"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "ulduar.h"

/* #TODO: Achievements
          Storm Cloud (Shaman ability)
          Destroying of Toasty Fires
*/

enum HodirYells
{
    SAY_AGGRO                                   = 0,
    SAY_SLAY                                    = 1,
    SAY_FLASH_FREEZE                            = 2,
    SAY_STALACTITE                              = 3,
    SAY_DEATH                                   = 4,
    SAY_BERSERK                                 = 5,
    SAY_HARD_MODE_FAILED                        = 6,

    EMOTE_FREEZE                                = 7,
    EMOTE_BLOW                                  = 8
};

enum HodirSpells
{
    // Hodir
    SPELL_FROZEN_BLOWS                           = 62478,
    SPELL_FLASH_FREEZE                           = 61968,
    SPELL_FLASH_FREEZE_VISUAL                    = 62148,
    SPELL_BITING_COLD                            = 62038,
    SPELL_BITING_COLD_TRIGGERED                  = 62039, // Needed for Achievement Getting Cold In Here
    SPELL_BITING_COLD_DAMAGE                     = 62188,
    SPELL_FREEZE                                 = 62469,
    SPELL_ICICLE                                 = 62234,
    SPELL_ICICLE_SNOWDRIFT                       = 62462,
    SPELL_BLOCK_OF_ICE                           = 61969, // Player + Helper
    SPELL_SUMMON_FLASH_FREEZE_HELPER             = 61989, // Helper
    SPELL_SUMMON_BLOCK_OF_ICE                    = 61970, // Player + Helper
    SPELL_FLASH_FREEZE_HELPER                    = 61990, // Helper
    SPELL_FLASH_FREEZE_KILL                      = 62226,
    SPELL_ICICLE_FALL                            = 69428,
    SPELL_FALL_DAMAGE                            = 62236,
    SPELL_FALL_SNOWDRIFT                         = 62460,
    SPELL_BERSERK                                = 47008,
    SPELL_ICE_SHARD                              = 62457,
    SPELL_ICE_SHARD_HIT                          = 65370,

    // Credit
    SPELL_KILL_CREDIT                            = 64899,

    // Druids
    SPELL_WRATH                                  = 62793,
    SPELL_STARLIGHT                              = 62807,
    AURA_MOONKIN                                 = 24907,

    // Shamans
    SPELL_LAVA_BURST                             = 61924,
    SPELL_STORM_CLOUD                            = 65123,
    SPELL_STORM_POWER_10                         = 63711,
    SPELL_STORM_POWER_25                         = 65134,

    // Mages
    SPELL_FIREBALL                               = 61909,
    SPELL_CONJURE_FIRE                           = 62823,
    SPELL_MELT_ICE                               = 64528,
    SPELL_SINGED                                 = 62821,

    // Priests
    SPELL_SMITE                                  = 61923,
    SPELL_GREATER_HEAL                           = 62809,
    SPELL_DISPEL_MAGIC                           = 63499
};

#define SPELL_STORM_POWER RAID_MODE(SPELL_STORM_POWER_10, SPELL_STORM_POWER_25)

enum HodirNPC
{
    NPC_ICE_BLOCK                                = 32938,
    NPC_FLASH_FREEZE                             = 32926,
    NPC_SNOWPACKED_ICICLE                        = 33174,
    NPC_ICICLE                                   = 33169,
    NPC_ICICLE_SNOWDRIFT                         = 33173,
    NPC_TOASTY_FIRE                              = 33342
};

enum HodirGameObjects
{
    GO_TOASTY_FIRE                               = 194300,
    GO_SNOWDRIFT                                 = 194173
};

enum HodirEvents
{
    // Hodir
    EVENT_FREEZE                                = 1,
    EVENT_FLASH_FREEZE                          = 2,
    EVENT_FLASH_FREEZE_EFFECT                   = 3,
    EVENT_ICICLE                                = 4,
    EVENT_BLOWS                                 = 5,
    EVENT_RARE_CACHE                            = 6,
    EVENT_BERSERK                               = 7,

    // priest
    EVENT_HEAL                                  = 8,
    EVENT_DISPEL_MAGIC                          = 9,

    // shaman
    EVENT_STORM_CLOUD                           = 10,

    // Druid
    EVENT_STARLIGHT                             = 11,

    // Mage
    EVENT_CONJURE_FIRE                          = 12,
    EVENT_MELT_ICE                              = 13,
};

enum HodirActions
{
    ACTION_I_HAVE_THE_COOLEST_FRIENDS           = 1,
    ACTION_CHEESE_THE_FREEZE                    = 2
};

#define ACHIEVEMENT_CHEESE_THE_FREEZE            RAID_MODE<uint8>(2961, 2962)
#define ACHIEVEMENT_GETTING_COLD_IN_HERE         RAID_MODE<uint32>(2967, 2968)
#define ACHIEVEMENT_THIS_CACHE_WAS_RARE          RAID_MODE<uint8>(3182, 3184)
#define ACHIEVEMENT_COOLEST_FRIENDS              RAID_MODE<uint8>(2963, 2965)
#define ACHIEVEMENT_STAYING_BUFFED_ALL_WINTER    RAID_MODE<uint8>(2969, 2970) // 10223, 10240, 10241 - 10229, 10238, 10239
#define FRIENDS_COUNT                            RAID_MODE<uint8>(4, 8)

Position const SummonPositions[8] =
{
    { 1983.75f, -243.36f, 432.767f, 1.57f }, // Field Medic Penny    &&  Battle-Priest Eliza
    { 1999.90f, -230.49f, 432.767f, 1.57f }, // Eivi Nightfeather    &&  Tor Greycloud
    { 2010.06f, -243.45f, 432.767f, 1.57f }, // Elementalist Mahfuun &&  Spiritwalker Tara
    { 2021.12f, -236.65f, 432.767f, 1.57f }, // Missy Flamecuffs     &&  Amira Blazeweaver
    { 2028.10f, -244.66f, 432.767f, 1.57f }, // Field Medic Jessi    &&  Battle-Priest Gina
    { 2014.18f, -232.80f, 432.767f, 1.57f }, // Ellie Nightfeather   &&  Kar Greycloud
    { 1992.90f, -237.54f, 432.767f, 1.57f }, // Elementalist Avuun   &&  Spiritwalker Yona
    { 1976.60f, -233.53f, 432.767f, 1.57f }, // Sissy Flamecuffs     &&  Veesha Blazeweaver
};

uint32 const Entry[8] =
{
    NPC_FIELD_MEDIC_PENNY,
    NPC_EIVI_NIGHTFEATHER,
    NPC_ELEMENTALIST_MAHFUUN,
    NPC_MISSY_FLAMECUFFS,
    NPC_FIELD_MEDIC_JESSI,
    NPC_ELLIE_NIGHTFEATHER,
    NPC_ELEMENTALIST_AVUUN,
    NPC_SISSY_FLAMECUFFS
};

class npc_flash_freeze : public CreatureScript
{
    public:
        npc_flash_freeze() : CreatureScript("npc_flash_freeze") {}

        struct npc_flash_freezeAI : public ScriptedAI
        {
            npc_flash_freezeAI(Creature* creature) : ScriptedAI(creature), _instance(me->GetInstanceScript())
            {
                me->SetDisplayId(me->GetCreatureTemplate()->Modelid2);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED | UNIT_FLAG_PACIFIED);
            }            

            void Reset()
            {
                _targetGUID = 0;
                _checkDespawnTimer = 1*IN_MILLISECONDS;
            }

            void UpdateAI(uint32 diff)
            {
                if ((me->getVictim() && me->getVictim()->GetGUID() != _targetGUID) || (_instance && _instance->GetBossState(BOSS_HODIR) != IN_PROGRESS))
                    me->DespawnOrUnsummon();

                if (!UpdateVictim() || me->getVictim()->HasAura(SPELL_BLOCK_OF_ICE) || me->getVictim()->HasAura(SPELL_FLASH_FREEZE_HELPER))
                    return;

                if (_checkDespawnTimer <= diff)
                {
                    if (Unit* target = ObjectAccessor::GetUnit(*me, _targetGUID))
                        if (!target->isAlive())
                            me->DisappearAndDie();
                    _checkDespawnTimer = 2.5*IN_MILLISECONDS;
                }
                else
                    _checkDespawnTimer -= diff;
            }

            void IsSummonedBy(Unit* summoner)
            {
                _targetGUID = summoner->GetGUID();
                me->SetInCombatWith(summoner);
                me->AddThreat(summoner, 250.0f);

                if (Unit* target = ObjectAccessor::GetUnit(*me, _targetGUID))
                {
                    // Freeze only players and helper npcs
                    bool freeze = false;

                    if (target->GetTypeId() == TYPEID_PLAYER)
                        freeze = true;

                    if (target->GetTypeId() == TYPEID_UNIT)
                        for (uint8 n = 0; n < FRIENDS_COUNT; ++n)
                            if (target->GetEntry() == Entry[n])
                            {
                                freeze = true;
                                break;
                            }

                    if (!freeze)
                        return;

                    DoCast(target, SPELL_BLOCK_OF_ICE, true);
                    // Prevents to have Ice Block on other place than target is
                    me->NearTeleportTo(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), target->GetOrientation());
                    if (target->GetTypeId() == TYPEID_PLAYER)
                        if (Creature* Hodir = ObjectAccessor::GetCreature(*me, _instance ? _instance->GetData64(BOSS_HODIR) : 0))
                            Hodir->AI()->DoAction(ACTION_CHEESE_THE_FREEZE);
                }
            }

            private:
                InstanceScript* _instance;
                uint64 _targetGUID;
                uint32 _checkDespawnTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_flash_freezeAI(creature);
        }
};

class npc_ice_block : public CreatureScript
{
    public:
        npc_ice_block() : CreatureScript("npc_ice_block") {}

        struct npc_ice_blockAI : public ScriptedAI
        {
            npc_ice_blockAI(Creature* creature) : ScriptedAI(creature)
            {
                _instance = me->GetInstanceScript();
                me->SetDisplayId(me->GetCreatureTemplate()->Modelid2);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED | UNIT_FLAG_PACIFIED);
                _targetGUID = 0;
            }            

            void IsSummonedBy(Unit* summoner)
            {
                _targetGUID = summoner->GetGUID();
                summoner->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_STUNNED | UNIT_FLAG_PACIFIED);
                me->SetInCombatWith(summoner);
                me->AddThreat(summoner, 250.0f);
                summoner->AddThreat(me, 250.0f);
                if (Creature* target = ObjectAccessor::GetCreature(*me, _targetGUID))
                {
                    DoCast(target, SPELL_FLASH_FREEZE_HELPER, true);
                    // Prevents to have Ice Block on other place than target is
                    me->NearTeleportTo(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), target->GetOrientation());
                }
            }

            void DamageTaken(Unit* who, uint32& /*damage*/)
            {
                if (Creature* Helper = ObjectAccessor::GetCreature(*me, _targetGUID))
                {
                    Helper->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_STUNNED | UNIT_FLAG_PACIFIED);

                    if (Creature* Hodir = ObjectAccessor::GetCreature(*me, _instance ? _instance->GetData64(BOSS_HODIR) : 0))
                    {
                        if (!Hodir->isInCombat())
                        {
                            Hodir->SetReactState(REACT_AGGRESSIVE);
                            Hodir->AI()->DoZoneInCombat();
                            Hodir->AI()->AttackStart(who);
                        }

                        Helper->AI()->AttackStart(Hodir);
                    }
                }
            }

            void UpdateAI(uint32 const /*diff*/)
            {
                if (_instance && _instance->GetBossState(BOSS_HODIR) == DONE)
                    me->DespawnOrUnsummon();
            }

            private:
                InstanceScript* _instance;
                uint64 _targetGUID;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_ice_blockAI(creature);
        }
};

class boss_hodir : public CreatureScript
{
    public:
        boss_hodir() : CreatureScript("boss_hodir") {}

        struct boss_hodirAI : public BossAI
        {
            boss_hodirAI(Creature* creature) : BossAI(creature, BOSS_HODIR)
            {
                me->SetReactState(REACT_DEFENSIVE);
                _gotEncounterFinished = false;
            }            

            void Reset()
            {
                _Reset();
                me->SetReactState(REACT_DEFENSIVE);
                _gotEncounterFinished = _gotEncounterFinished || (instance->GetBossState(BOSS_HODIR) == DONE);
                instance->HandleGameObject(instance->GetData64(GO_HODIR_IN_DOOR_STONE), true);

                // Note: NPC translation alliance -> horde is performed by OnCreatureCreate (instance-script)
                for (uint8 n = 0; n < FRIENDS_COUNT; ++n)
                    if (Creature* FrozenHelper = me->SummonCreature(Entry[n], SummonPositions[n], TEMPSUMMON_MANUAL_DESPAWN))
                        FrozenHelper->CastSpell(FrozenHelper, SPELL_SUMMON_FLASH_FREEZE_HELPER, true);
            }

            void EnterCombat(Unit* /*who*/)
            {
                _EnterCombat();
                Talk(SAY_AGGRO);
                DoCast(me, SPELL_BITING_COLD, true);

                _gettingColdInHereTimer = 2*IN_MILLISECONDS;
                _gettingColdInHere = true;
                _cheeseTheFreeze = true;
                _iHaveTheCoolestFriends = true;
                _iCouldSayThatThisCacheWasRare = true;
                instance->HandleGameObject(instance->GetData64(GO_HODIR_IN_DOOR_STONE), false);

                events.ScheduleEvent(EVENT_ICICLE, 2*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_FREEZE, 25*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_BLOWS, urand(60*IN_MILLISECONDS, 65*IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_FLASH_FREEZE, 45*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_RARE_CACHE, 3*MINUTE*IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_BERSERK, 8*MINUTE*IN_MILLISECONDS);
            }

            void KilledUnit(Unit* /*who*/)
            {
                if (!urand(0,5))
                    Talk(SAY_SLAY);
            }

            void DamageTaken(Unit* /*who*/, uint32& damage)
            {
                if (damage >= me->GetHealth())
                {
                    damage = 0;
                    if (_gotEncounterFinished)
                        return;

                    _gotEncounterFinished = true;
                    Talk(SAY_DEATH);
                    if (_iCouldSayThatThisCacheWasRare)
                        instance->SetData(DATA_HODIR_RARE_CACHE, 1);

                    if (_gettingColdInHere)
                        instance->DoCompleteAchievement(ACHIEVEMENT_GETTING_COLD_IN_HERE);

                    me->RemoveAllAuras();
                    me->RemoveAllAttackers();
                    me->AttackStop();
                    me->SetReactState(REACT_PASSIVE);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
                    me->InterruptNonMeleeSpells(true);
                    me->StopMoving();
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MoveIdle();
                    me->SetControlled(true, UNIT_STATE_STUNNED);
                    me->CombatStop(true);

                    me->setFaction(FACTION_FRIENDLY);
                    me->DespawnOrUnsummon(10*IN_MILLISECONDS);

                    // Kill Credit
                    DoCastAOE(SPELL_KILL_CREDIT);

                    _JustDied();
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (_gettingColdInHere)
                {
                    if (_gettingColdInHereTimer <= diff)
                    {
                        std::list<HostileReference*> ThreatList = me->getThreatManager().getThreatList();
                        for (std::list<HostileReference*>::const_iterator itr = ThreatList.begin(); itr != ThreatList.end(); ++itr)
                            if (Unit* target = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid()))
                                if (Aura* BitingColdAura = target->GetAura(SPELL_BITING_COLD_TRIGGERED))
                                    if ((target->GetTypeId() == TYPEID_PLAYER) && (BitingColdAura->GetStackAmount() > 2))
                                        _gettingColdInHere = false;
                        _gettingColdInHereTimer = 2*IN_MILLISECONDS;
                    }
                    else
                        _gettingColdInHereTimer -= diff;
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_FREEZE:
                            DoCastAOE(SPELL_FREEZE);
                            events.ScheduleEvent(EVENT_FREEZE, urand(30*IN_MILLISECONDS, 45*IN_MILLISECONDS));
                            return;
                        case EVENT_ICICLE:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                                DoCast(target, SPELL_ICICLE);
                            events.ScheduleEvent(EVENT_ICICLE, RAID_MODE(5.5*IN_MILLISECONDS, 3.5*IN_MILLISECONDS));
                            return;
                        case EVENT_FLASH_FREEZE:
                            Talk(SAY_FLASH_FREEZE);
                            Talk(EMOTE_FREEZE);
                            for (uint8 n = 0; n < RAID_MODE(2, 3); ++n)
                                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                                    target->CastSpell(target, SPELL_ICICLE_SNOWDRIFT, true);
                            DoCast(SPELL_FLASH_FREEZE);
                            events.ScheduleEvent(EVENT_FLASH_FREEZE_EFFECT, 0.5*IN_MILLISECONDS);
                            return;
                        case EVENT_FLASH_FREEZE_EFFECT:
                        {
                            std::list<Creature*> IcicleSnowdriftList;
                            GetCreatureListWithEntryInGrid(IcicleSnowdriftList, me, NPC_SNOWPACKED_ICICLE, 100.0f);
                            for (std::list<Creature*>::iterator itr = IcicleSnowdriftList.begin(); itr != IcicleSnowdriftList.end(); ++itr)
                                (*itr)->CastSpell(me, SPELL_FLASH_FREEZE_VISUAL, true);
                            FlashFreeze();
                            events.CancelEvent(EVENT_FLASH_FREEZE_EFFECT);
                            events.ScheduleEvent(EVENT_FLASH_FREEZE, urand(25*IN_MILLISECONDS, 35*IN_MILLISECONDS));
                            return;
                        }
                        case EVENT_BLOWS:
                            Talk(SAY_STALACTITE);
                            Talk(EMOTE_BLOW);
                            DoCast(me, SPELL_FROZEN_BLOWS);
                            events.ScheduleEvent(EVENT_BLOWS, urand(60*IN_MILLISECONDS, 65*IN_MILLISECONDS));
                            return;
                        case EVENT_RARE_CACHE:
                            Talk(SAY_HARD_MODE_FAILED);
                            _iCouldSayThatThisCacheWasRare = false;
                            instance->SetData(DATA_HODIR_RARE_CACHE, 0);
                            events.CancelEvent(EVENT_RARE_CACHE);
                            return;
                        case EVENT_BERSERK:
                            Talk(SAY_BERSERK);
                            DoCast(me, SPELL_BERSERK, true);
                            events.CancelEvent(EVENT_BERSERK);
                            return;
                        default:
                            return;
                    }
                }

                DoMeleeAttackIfReady();
            }

            void DoAction(int32 action)
            {
                switch (action)
                {
                    case ACTION_I_HAVE_THE_COOLEST_FRIENDS:
                        _iHaveTheCoolestFriends = false;
                        break;
                    case ACTION_CHEESE_THE_FREEZE:
                        _cheeseTheFreeze = false;
                        break;
                    default:
                        break;
                }
            }

            void FlashFreeze()
            {
                std::list<Unit*> TargetList;
                Trinity::AnyUnfriendlyUnitInObjectRangeCheck checker(me, me, 100.0f);
                Trinity::UnitListSearcher<Trinity::AnyUnfriendlyUnitInObjectRangeCheck> searcher(me, TargetList, checker);
                me->VisitNearbyObject(100.0f, searcher);
                for (std::list<Unit*>::iterator itr = TargetList.begin(); itr != TargetList.end(); ++itr)
                {
                    Unit* target = *itr;
                    if (!target || !target->isAlive() || GetClosestCreatureWithEntry(target, NPC_SNOWPACKED_ICICLE, 5.0f))
                        continue;

                    if (target->HasAura(SPELL_FLASH_FREEZE_HELPER) || target->HasAura(SPELL_BLOCK_OF_ICE))
                    {
                        me->CastSpell(target, SPELL_FLASH_FREEZE_KILL, true);
                        continue;
                    }

                    target->CastSpell(target, SPELL_SUMMON_BLOCK_OF_ICE, true);
                }
            }

            private:
                uint32 _gettingColdInHereTimer;
                bool _gettingColdInHere;
                bool _cheeseTheFreeze;
                bool _iHaveTheCoolestFriends;
                bool _iCouldSayThatThisCacheWasRare;
                bool _gotEncounterFinished;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetUlduarAI<boss_hodirAI>(creature);
        };
};

class npc_icicle : public CreatureScript
{
    public:
        npc_icicle() : CreatureScript("npc_icicle") {}

        struct npc_icicleAI : public ScriptedAI
        {
            npc_icicleAI(Creature* creature) : ScriptedAI(creature)
            {
                me->SetDisplayId(me->GetCreatureTemplate()->Modelid1);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_PACIFIED | UNIT_FLAG_NOT_SELECTABLE);
                me->SetReactState(REACT_PASSIVE);
            }           

            void Reset()
            {
                _icicleTimer = 2.5*IN_MILLISECONDS;
            }

            void UpdateAI(uint32 diff)
            {
                if (_icicleTimer <= diff)
                {
                    if (me->GetEntry() == NPC_ICICLE_SNOWDRIFT)
                    {
                        DoCast(me, SPELL_FALL_SNOWDRIFT);
                        DoCast(me, SPELL_ICICLE_FALL);
                    }
                    else if (me->GetEntry() == NPC_ICICLE)
                    {
                        DoCast(me, SPELL_ICICLE_FALL);
                        DoCast(me, SPELL_FALL_DAMAGE, true);
                    }
                    _icicleTimer = 10*IN_MILLISECONDS;
                }
                else
                    _icicleTimer -= diff;
            }

            private:
                uint32 _icicleTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetUlduarAI<npc_icicleAI>(creature);
        };
};

class npc_snowpacked_icicle : public CreatureScript
{
    public:
        npc_snowpacked_icicle() : CreatureScript("npc_snowpacked_icicle") {}

        struct npc_snowpacked_icicleAI : public ScriptedAI
        {
            npc_snowpacked_icicleAI(Creature* creature) : ScriptedAI(creature)
            {
                me->SetDisplayId(me->GetCreatureTemplate()->Modelid2);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_PACIFIED);
                me->SetReactState(REACT_PASSIVE);
            }

            void Reset()
            {
                _despawnTimer = 12*IN_MILLISECONDS;
            }

            void UpdateAI(uint32 diff)
            {
                if (_despawnTimer <= diff)
                {
                    if (GameObject* Snowdrift = me->FindNearestGameObject(GO_SNOWDRIFT, 2.0f))
                        me->RemoveGameObject(Snowdrift, true);
                    me->DespawnOrUnsummon();
                }
                else
                    _despawnTimer -= diff;
            }

            private:
                uint32 _despawnTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetUlduarAI<npc_snowpacked_icicleAI>(creature);
        };
};

class npc_hodir_priest : public CreatureScript
{
    public:
        npc_hodir_priest() : CreatureScript("npc_hodir_priest") {}

        struct npc_hodir_priestAI : public ScriptedAI
        {
            npc_hodir_priestAI(Creature* creature) : ScriptedAI(creature), _instance(me->GetInstanceScript()) {}

            void Reset()
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_HEAL, urand(4*IN_MILLISECONDS, 8*IN_MILLISECONDS));
                _events.ScheduleEvent(EVENT_DISPEL_MAGIC, urand(15*IN_MILLISECONDS, 20*IN_MILLISECONDS));
            }

            void AttackStart(Unit* who)
            {
                AttackStartCaster(who, 20.0f);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim() || me->HasUnitState(UNIT_STATE_STUNNED) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED))
                    return;

                _events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                if (HealthBelowPct(30))
                    DoCast(me, SPELL_GREATER_HEAL);

                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_HEAL:
                            DoCastAOE(SPELL_GREATER_HEAL);
                            _events.ScheduleEvent(EVENT_HEAL, urand(7.5*IN_MILLISECONDS, 10*IN_MILLISECONDS));
                            return;
                        case EVENT_DISPEL_MAGIC:
                        {
                            std::list<Unit*> allies;
                            Trinity::AnyFriendlyUnitInObjectRangeCheck checker(me, me, 30.0f);
                            Trinity::UnitListSearcher<Trinity::AnyFriendlyUnitInObjectRangeCheck> searcher(me, allies, checker);
                            me->VisitNearbyObject(30.0f, searcher);
                            // TODO: Check if the below is intended: it will dispell freeze from every player
                            for (std::list<Unit*>::iterator itr = allies.begin(); itr != allies.end(); ++itr)
                                if ((*itr)->HasAura(SPELL_FREEZE))
                                    DoCast(*itr, SPELL_DISPEL_MAGIC, true);
                            _events.ScheduleEvent(EVENT_DISPEL_MAGIC, urand(15*IN_MILLISECONDS, 20*IN_MILLISECONDS));
                            return;
                        }
                        default:
                            break;
                    }
                }

                DoSpellAttackIfReady(SPELL_SMITE);
            }

            void JustDied(Unit* /*who*/)
            {
                if (Creature* Hodir = ObjectAccessor::GetCreature(*me, _instance ? _instance->GetData64(BOSS_HODIR) : 0))
                    Hodir->AI()->DoAction(ACTION_I_HAVE_THE_COOLEST_FRIENDS);
            }

            private:
                InstanceScript* _instance;
                EventMap _events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetUlduarAI<npc_hodir_priestAI>(creature);
        };
};

class npc_hodir_shaman : public CreatureScript
{
    public:
        npc_hodir_shaman() : CreatureScript("npc_hodir_shaman") {}

        struct npc_hodir_shamanAI : public ScriptedAI
        {
            npc_hodir_shamanAI(Creature* creature) : ScriptedAI(creature), _instance(me->GetInstanceScript()) {}

            void Reset()
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_STORM_CLOUD, urand(10*IN_MILLISECONDS, 12.5*IN_MILLISECONDS));
            }

            void AttackStart(Unit* who)
            {
                AttackStartCaster(who, 20.0f);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim() || me->HasUnitState(UNIT_STATE_STUNNED) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED))
                    return;

                _events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_STORM_CLOUD:
                            {
                                std::list<Unit*> allies;
                                Trinity::AnyFriendlyUnitInObjectRangeCheck checker(me, me, 30.0f);
                                Trinity::UnitListSearcher<Trinity::AnyFriendlyUnitInObjectRangeCheck> searcher(me, allies, checker);
                                me->VisitNearbyWorldObject(30.0f, searcher);
                                if (!allies.empty())
                                {
                                    std::list<Unit*>::iterator iter = allies.begin();
                                    DoCast((*iter), SPELL_STORM_CLOUD, true);
                                    _events.ScheduleEvent(EVENT_STORM_CLOUD, urand(15*IN_MILLISECONDS, 20*IN_MILLISECONDS));
                                }
                                else
                                    _events.ScheduleEvent(EVENT_STORM_CLOUD, urand(2*IN_MILLISECONDS, 3*IN_MILLISECONDS)); // No target found, check again in a short period of time
                            
                            }
                            break;
                        default:
                            break;
                    }
                }

                DoSpellAttackIfReady(SPELL_LAVA_BURST);
            }

            void JustDied(Unit* /*who*/)
            {
                if (Creature* Hodir = ObjectAccessor::GetCreature(*me, _instance ? _instance->GetData64(BOSS_HODIR) : 0))
                    Hodir->AI()->DoAction(ACTION_I_HAVE_THE_COOLEST_FRIENDS);
            }

            private:
                InstanceScript* _instance;
                EventMap _events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetUlduarAI<npc_hodir_shamanAI>(creature);
        };
};

class npc_hodir_druid : public CreatureScript
{
    public:
        npc_hodir_druid() : CreatureScript("npc_hodir_druid") {}

        struct npc_hodir_druidAI : public ScriptedAI
        {
            npc_hodir_druidAI(Creature* creature) : ScriptedAI(creature), _instance(me->GetInstanceScript()) {}

            void Reset()
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_STARLIGHT, urand(15*IN_MILLISECONDS, 17.5*IN_MILLISECONDS));
            }

            void AttackStart(Unit* who)
            {
                AttackStartCaster(who, 20.0f);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim() || me->HasUnitState(UNIT_STATE_STUNNED) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED))
                    return;

                _events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_STARLIGHT:
                            // This was somehow senseless - the spell persists ~1 min, thus refreshing it every half a minute is ... curious.
                            DoCast(me, SPELL_STARLIGHT, true);
                            _events.ScheduleEvent(EVENT_STARLIGHT, urand(25*IN_MILLISECONDS, 35*IN_MILLISECONDS));
                            break;
                        default:
                            break;
                    }
                }

                if (!me->HasAura(AURA_MOONKIN))
                    me->AddAura(AURA_MOONKIN, me);

                DoSpellAttackIfReady(SPELL_WRATH);
            }

            void JustDied(Unit* /*who*/)
            {
                if (Creature* Hodir = ObjectAccessor::GetCreature(*me, _instance ? _instance->GetData64(BOSS_HODIR) : 0))
                    Hodir->AI()->DoAction(ACTION_I_HAVE_THE_COOLEST_FRIENDS);
            }

            private:
                InstanceScript* _instance;
                EventMap _events;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetUlduarAI<npc_hodir_druidAI>(creature);
        };
};

class npc_hodir_mage : public CreatureScript
{
    public:
        npc_hodir_mage() : CreatureScript("npc_hodir_mage") {}

        struct npc_hodir_mageAI : public ScriptedAI
        {
            npc_hodir_mageAI(Creature* creature) : ScriptedAI(creature), _summons(me)
            {
                _instance = me->GetInstanceScript();
            }

            void Reset()
            {
                _events.Reset();
                _summons.DespawnAll();
                _events.ScheduleEvent(EVENT_CONJURE_FIRE, urand(10*IN_MILLISECONDS, 12.5*IN_MILLISECONDS));
                _events.ScheduleEvent(EVENT_MELT_ICE, 5*IN_MILLISECONDS);
            }

            void AttackStart(Unit* who)
            {
                AttackStartCaster(who, 20.0f);
            }

            void JustSummoned(Creature* summoned)
            {
                if (summoned->GetEntry() == NPC_TOASTY_FIRE)
                    _summons.Summon(summoned);
            }

            void SummonedCreatureDespawn(Creature* summoned)
            {
                if (summoned->GetEntry() == NPC_TOASTY_FIRE)
                    _summons.Despawn(summoned);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim() || me->HasUnitState(UNIT_STATE_STUNNED) || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_STUNNED))
                    return;

                _events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_CONJURE_FIRE:
                            if (_summons.size() >= RAID_MODE<uint64>(2, 4))
                                break;
                            // The fire is gets positioned at a random coordinate.
                            DoCast(me, SPELL_CONJURE_FIRE, true);
                            _events.ScheduleEvent(EVENT_CONJURE_FIRE, urand(15*IN_MILLISECONDS, 20*IN_MILLISECONDS));
                            return;
                        case EVENT_MELT_ICE:
                            if (Creature* FlashFreeze = me->FindNearestCreature(NPC_FLASH_FREEZE, 50.0f, true))
                                DoCast(FlashFreeze, SPELL_MELT_ICE, true);
                            _events.ScheduleEvent(EVENT_MELT_ICE, urand(10*IN_MILLISECONDS, 15*IN_MILLISECONDS));
                            return;
                        default:
                            return;
                    }
                }

                DoSpellAttackIfReady(SPELL_FIREBALL);
            }

            void JustDied(Unit* /*who*/)
            {
                  if (Creature* Hodir = ObjectAccessor::GetCreature(*me, _instance ? _instance->GetData64(BOSS_HODIR) : 0))
                    Hodir->AI()->DoAction(ACTION_I_HAVE_THE_COOLEST_FRIENDS);
            }

            private:
                InstanceScript* _instance;
                EventMap _events;
                SummonList _summons;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetUlduarAI<npc_hodir_mageAI>(creature);
        };
};

class npc_toasty_fire : public CreatureScript
{
    public:
        npc_toasty_fire() : CreatureScript("npc_toasty_fire") {}

        struct npc_toasty_fireAI : public ScriptedAI
        {
            npc_toasty_fireAI(Creature* creature) : ScriptedAI(creature)
            {
                me->SetDisplayId(me->GetCreatureTemplate()->Modelid2);
            }

            void Reset()
            {
                DoCast(me, SPELL_SINGED, true);
            }

            void SpellHit(Unit* /*who*/, const SpellInfo* spell)
            {
                if (spell->Id == SPELL_BLOCK_OF_ICE || spell->Id == SPELL_ICE_SHARD || spell->Id == SPELL_ICE_SHARD_HIT)
                {
                    if (GameObject* ToastyFire = me->FindNearestGameObject(GO_TOASTY_FIRE, 4.0f))
                        me->RemoveGameObject(ToastyFire, true);
                    me->DespawnOrUnsummon();
                }
            }

            // Just for the case
            void JustDied(Unit* /*victim*/)
            {
                if (GameObject* fire = me->FindNearestGameObject(GO_TOASTY_FIRE, 4.0f))
                    me->RemoveGameObject(fire, true);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetUlduarAI<npc_toasty_fireAI>(creature);
        };
};

class spell_biting_cold : public SpellScriptLoader
{
    public:
        spell_biting_cold() : SpellScriptLoader("spell_biting_cold") {}

        class spell_biting_cold_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_biting_cold_AuraScript);

            void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
            {
                Unit* target = GetTarget();
                bool found = false;

                for (TargetList::iterator itr = listOfTargets.begin(); itr != listOfTargets.end(); ++itr)
                {
                    if (itr->first != target->GetGUID())
                        return;

                    if (itr->second >= 4)
                    {
                        target->CastSpell(target, SPELL_BITING_COLD_TRIGGERED, true);
                        itr->second = 1;
                    }
                    else
                    {
                        if (target->isMoving())
                            itr->second = 1;
                        else
                            itr->second++;
                    }

                    found = true;
                    break;
                }

                if (!found)
                    listOfTargets.push_back(std::make_pair(target->GetGUID(), 1));
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_biting_cold_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }

            private:
                typedef std::list< std::pair<uint64, uint8> > TargetList;
                TargetList listOfTargets;
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_biting_cold_AuraScript();
        }
};

class spell_biting_cold_dot : public SpellScriptLoader
{
    public:
        spell_biting_cold_dot() : SpellScriptLoader("spell_biting_cold_dot") {}

        class spell_biting_cold_dot_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_biting_cold_dot_AuraScript);

            void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
            {
                Unit* caster = GetCaster();
                if (!caster)
                    return;

                int32 damage = int32(200 * pow(2.0f, GetStackAmount()));
                caster->CastCustomSpell(caster, SPELL_BITING_COLD_DAMAGE, &damage, NULL, NULL, true);

                if (caster->isMoving())
                    caster->RemoveAuraFromStack(SPELL_BITING_COLD_TRIGGERED);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_biting_cold_dot_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_biting_cold_dot_AuraScript();
        }
};

class achievement_staying_buffed_all_winter : public AchievementCriteriaScript
{
   public:
       achievement_staying_buffed_all_winter(const char* name) : AchievementCriteriaScript(name) {}

       bool OnCheck(Player* player, Unit* /*target*/)
       {
           if (player->HasAura(SPELL_SINGED) && player->HasAura(SPELL_STARLIGHT) && ( player->HasAura(SPELL_STORM_POWER_10) || player->HasAura(SPELL_STORM_POWER_25)))
               return true;

           return false;
       }
};

void AddSC_boss_hodir()
{
    new boss_hodir();
    new npc_icicle();
    new npc_snowpacked_icicle();
    new npc_hodir_priest();
    new npc_hodir_shaman();
    new npc_hodir_druid();
    new npc_hodir_mage();
    new npc_toasty_fire();
    new npc_ice_block();
    new npc_flash_freeze();

    new spell_biting_cold();
    new spell_biting_cold_dot();

    new achievement_staying_buffed_all_winter("achievement_staying_buffed_all_winter");
    new achievement_staying_buffed_all_winter("achievement_staying_buffed_all_winter_25");
}

#undef SPELL_STORM_POWER
