/*
 * Copyright (C) 2008-2013 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: Stormwind_City
SD%Complete: 100
SDComment: Quest support: 1640, 1447, 4185, 11223, 434.
SDCategory: Stormwind City
EndScriptData */

/* ContentData
npc_archmage_malin
npc_bartleby
npc_lady_katrana_prestor
npc_tyrion
npc_tyrion_spybot
npc_marzon_silent_blade
npc_lord_gregor_lescovar
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "Player.h"

/*######
## npc_archmage_malin
######*/

#define GOSSIP_ITEM_MALIN "Can you send me to Theramore? I have an urgent message for Lady Jaina from Highlord Bolvar."

class npc_archmage_malin : public CreatureScript
{
public:
    npc_archmage_malin() : CreatureScript("npc_archmage_malin") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF)
        {
            player->CLOSE_GOSSIP_MENU();
            creature->CastSpell(player, 42711, true);
        }

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(11223) == QUEST_STATUS_COMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_MALIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }
};

/*######
## npc_bartleby
######*/

enum eBartleby
{
    FACTION_ENEMY       = 168,
    QUEST_BEAT          = 1640
};

class npc_bartleby : public CreatureScript
{
public:
    npc_bartleby() : CreatureScript("npc_bartleby") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_BEAT)
        {
            creature->setFaction(FACTION_ENEMY);
            creature->AI()->AttackStart(player);
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_bartlebyAI(creature);
    }

    struct npc_bartlebyAI : public ScriptedAI
    {
        npc_bartlebyAI(Creature* creature) : ScriptedAI(creature)
        {
            m_uiNormalFaction = creature->getFaction();
        }

        uint32 m_uiNormalFaction;

        void Reset()
        {
            if (me->getFaction() != m_uiNormalFaction)
                me->setFaction(m_uiNormalFaction);
        }

        void AttackedBy(Unit* pAttacker)
        {
            if (me->getVictim())
                return;

            if (me->IsFriendlyTo(pAttacker))
                return;

            AttackStart(pAttacker);
        }

        void DamageTaken(Unit* pDoneBy, uint32 &uiDamage)
        {
            if (uiDamage > me->GetHealth() || me->HealthBelowPctDamaged(15, uiDamage))
            {
                //Take 0 damage
                uiDamage = 0;

                if (pDoneBy->GetTypeId() == TYPEID_PLAYER)
                    CAST_PLR(pDoneBy)->AreaExploredOrEventHappens(QUEST_BEAT);
                EnterEvadeMode();
            }
        }
    };
};

/*######
## npc_lady_katrana_prestor
######*/

#define GOSSIP_ITEM_KAT_1 "Pardon the intrusion, Lady Prestor, but Highlord Bolvar suggested that I seek your advice."
#define GOSSIP_ITEM_KAT_2 "My apologies, Lady Prestor."
#define GOSSIP_ITEM_KAT_3 "Begging your pardon, Lady Prestor. That was not my intent."
#define GOSSIP_ITEM_KAT_4 "Thank you for your time, Lady Prestor."

class npc_lady_katrana_prestor : public CreatureScript
{
public:
    npc_lady_katrana_prestor() : CreatureScript("npc_lady_katrana_prestor") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_KAT_2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(2694, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+1:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_KAT_3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                player->SEND_GOSSIP_MENU(2695, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_KAT_4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                player->SEND_GOSSIP_MENU(2696, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                player->CLOSE_GOSSIP_MENU();
                player->AreaExploredOrEventHappens(4185);
                break;
        }
        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->isQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(4185) == QUEST_STATUS_INCOMPLETE)
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_KAT_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

        player->SEND_GOSSIP_MENU(2693, creature->GetGUID());

        return true;
    }
};

/*######
## npc_lord_gregor_lescovar
######*/

enum eLordGregorLescovar
{
    SAY_GUARD_2    = 0,
    SAY_LESCOVAR_2 = 0,
    SAY_LESCOVAR_3 = 1,
    SAY_LESCOVAR_4 = 2,
    SAY_MARZON_1   = 0,
    SAY_MARZON_2   = 1,
    SAY_TYRION_2   = 1,

    NPC_STORMWIND_ROYAL = 1756,
    NPC_MARZON_BLADE    = 1755,
    NPC_TYRION          = 7766,

    QUEST_THE_ATTACK    = 434
};

class npc_lord_gregor_lescovar : public CreatureScript
{
public:
    npc_lord_gregor_lescovar() : CreatureScript("npc_lord_gregor_lescovar") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_lord_gregor_lescovarAI(creature);
    }

    struct npc_lord_gregor_lescovarAI : public npc_escortAI
    {
        npc_lord_gregor_lescovarAI(Creature* creature) : npc_escortAI(creature)
        {
            creature->RestoreFaction();
        }

        uint32 uiTimer;
        uint32 uiPhase;

        uint64 MarzonGUID;

        void Reset()
        {
            uiTimer = 0;
            uiPhase = 0;

            MarzonGUID = 0;
        }

        void EnterEvadeMode()
        {
            me->DisappearAndDie();

            if (Creature* pMarzon = Unit::GetCreature(*me, MarzonGUID))
            {
                if (pMarzon->isAlive())
                    pMarzon->DisappearAndDie();
            }
        }

        void EnterCombat(Unit* who)
        {
            if (Creature* pMarzon = Unit::GetCreature(*me, MarzonGUID))
            {
                if (pMarzon->isAlive() && !pMarzon->isInCombat())
                    pMarzon->AI()->AttackStart(who);
            }
        }

        void WaypointReached(uint32 waypointId)
        {
            switch (waypointId)
            {
                case 14:
                    SetEscortPaused(true);
                    Talk(SAY_LESCOVAR_2);
                    uiTimer = 3000;
                    uiPhase = 1;
                    break;
                case 16:
                    SetEscortPaused(true);
                    if (Creature* pMarzon = me->SummonCreature(NPC_MARZON_BLADE, -8411.360352f, 480.069733f, 123.760895f, 4.941504f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 1000))
                    {
                        pMarzon->GetMotionMaster()->MovePoint(0, -8408.000977f, 468.611450f, 123.759903f);
                        MarzonGUID = pMarzon->GetGUID();
                    }
                    uiTimer = 2000;
                    uiPhase = 4;
                    break;
            }
        }
        //TO-DO: We don't have movemaps, also we can't make 2 npcs walks to one point propperly (and we can not use escort ai, because they are 2 different spawns and with same entry), because of it we make them, disappear.
        void DoGuardsDisappearAndDie()
        {
            std::list<Creature*> GuardList;
            me->GetCreatureListWithEntryInGrid(GuardList, NPC_STORMWIND_ROYAL, 8.0f);
            if (!GuardList.empty())
            {
                for (std::list<Creature*>::const_iterator itr = GuardList.begin(); itr != GuardList.end(); ++itr)
                {
                    if (Creature* pGuard = *itr)
                        pGuard->DisappearAndDie();
                }
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (uiPhase)
            {
                if (uiTimer <= uiDiff)
                {
                    switch (uiPhase)
                    {
                        case 1:
                            if (Creature* pGuard = me->FindNearestCreature(NPC_STORMWIND_ROYAL, 8.0f, true))
                                pGuard->AI()->Talk(SAY_GUARD_2);
                            uiTimer = 3000;
                            uiPhase = 2;
                            break;
                        case 2:
                            DoGuardsDisappearAndDie();
                            uiTimer = 2000;
                            uiPhase = 3;
                            break;
                        case 3:
                            SetEscortPaused(false);
                            uiTimer = 0;
                            uiPhase = 0;
                            break;
                        case 4:
                            Talk(SAY_LESCOVAR_3);
                            uiTimer = 0;
                            uiPhase = 0;
                            break;
                        case 5:
                            if (Creature* pMarzon = Unit::GetCreature(*me, MarzonGUID))
                                pMarzon->AI()->Talk(SAY_MARZON_1);
                            uiTimer = 3000;
                            uiPhase = 6;
                            break;
                        case 6:
                            Talk(SAY_LESCOVAR_4);
                            if (Player* player = GetPlayerForEscort())
                                player->AreaExploredOrEventHappens(QUEST_THE_ATTACK);
                            uiTimer = 2000;
                            uiPhase = 7;
                            break;
                        case 7:
                            if (Creature* pTyrion = me->FindNearestCreature(NPC_TYRION, 20.0f, true))
                                pTyrion->AI()->Talk(SAY_TYRION_2);
                            if (Creature* pMarzon = Unit::GetCreature(*me, MarzonGUID))
                                pMarzon->setFaction(14);
                            me->setFaction(14);
                            uiTimer = 0;
                            uiPhase = 0;
                            break;
                    }
                } else uiTimer -= uiDiff;
            }
            npc_escortAI::UpdateAI(uiDiff);

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_marzon_silent_blade
######*/

class npc_marzon_silent_blade : public CreatureScript
{
public:
    npc_marzon_silent_blade() : CreatureScript("npc_marzon_silent_blade") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_marzon_silent_bladeAI(creature);
    }

    struct npc_marzon_silent_bladeAI : public ScriptedAI
    {
        npc_marzon_silent_bladeAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetWalk(true);
        }

        void Reset()
        {
            me->RestoreFaction();
        }

        void EnterCombat(Unit* who)
        {
            Talk(SAY_MARZON_2);

            if (me->isSummon())
            {
                if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                {
                    if (summoner->GetTypeId() == TYPEID_UNIT && summoner->isAlive() && !summoner->isInCombat())
                        summoner->ToCreature()->AI()->AttackStart(who);
                }
            }
        }

        void EnterEvadeMode()
        {
            me->DisappearAndDie();

            if (me->isSummon())
            {
                if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                {
                    if (summoner->GetTypeId() == TYPEID_UNIT && summoner->isAlive())
                        summoner->ToCreature()->DisappearAndDie();
                }
            }
        }

        void MovementInform(uint32 uiType, uint32 /*uiId*/)
        {
            if (uiType != POINT_MOTION_TYPE)
                return;

            if (me->isSummon())
            {
                Unit* summoner = me->ToTempSummon()->GetSummoner();
                if (summoner && summoner->GetTypeId() == TYPEID_UNIT && summoner->IsAIEnabled)
                {
                    npc_lord_gregor_lescovar::npc_lord_gregor_lescovarAI* ai =
                        CAST_AI(npc_lord_gregor_lescovar::npc_lord_gregor_lescovarAI, summoner->GetAI());
                    if (ai)
                    {
                        ai->uiTimer = 2000;
                        ai->uiPhase = 5;
                    }
                    //me->ChangeOrient(0.0f, summoner);
                }
            }
        }

        void UpdateAI(const uint32 /*diff*/)
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_tyrion_spybot
######*/

enum eTyrionSpybot
{
    SAY_QUEST_ACCEPT_ATTACK  = 0,
    SAY_SPYBOT_1             = 1,
    SAY_SPYBOT_2             = 2,
    SAY_SPYBOT_3             = 3,
    SAY_SPYBOT_4             = 4,
    SAY_TYRION_1             = 0,
    SAY_GUARD_1              = 1,
    SAY_LESCOVAR_1           = 3,

    NPC_PRIESTESS_TYRIONA    = 7779,
    NPC_LORD_GREGOR_LESCOVAR = 1754,
};

class npc_tyrion_spybot : public CreatureScript
{
public:
    npc_tyrion_spybot() : CreatureScript("npc_tyrion_spybot") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_tyrion_spybotAI(creature);
    }

    struct npc_tyrion_spybotAI : public npc_escortAI
    {
        npc_tyrion_spybotAI(Creature* creature) : npc_escortAI(creature) {}

        uint32 uiTimer;
        uint32 uiPhase;

        void Reset()
        {
            uiTimer = 0;
            uiPhase = 0;
        }

        void WaypointReached(uint32 waypointId)
        {
            switch (waypointId)
            {
                case 1:
                    SetEscortPaused(true);
                    uiTimer = 2000;
                    uiPhase = 1;
                    break;
                case 5:
                    SetEscortPaused(true);
                    Talk(SAY_SPYBOT_1);
                    uiTimer = 2000;
                    uiPhase = 5;
                    break;
                case 17:
                    SetEscortPaused(true);
                    Talk(SAY_SPYBOT_3);
                    uiTimer = 3000;
                    uiPhase = 8;
                    break;
            }
        }

        void UpdateAI(const uint32 uiDiff)
        {
            if (uiPhase)
            {
                if (uiTimer <= uiDiff)
                {
                    switch (uiPhase)
                    {
                        case 1:
                            Talk(SAY_QUEST_ACCEPT_ATTACK);
                            uiTimer = 3000;
                            uiPhase = 2;
                            break;
                        case 2:
                            if (Creature* pTyrion = me->FindNearestCreature(NPC_TYRION, 10.0f))
                                pTyrion->AI()->Talk(SAY_TYRION_1);
                            uiTimer = 3000;
                            uiPhase = 3;
                            break;
                        case 3:
                            me->UpdateEntry(NPC_PRIESTESS_TYRIONA, ALLIANCE);
                            uiTimer = 2000;
                            uiPhase = 4;
                            break;
                        case 4:
                           SetEscortPaused(false);
                           uiPhase = 0;
                           uiTimer = 0;
                           break;
                        case 5:
                            if (Creature* pGuard = me->FindNearestCreature(NPC_STORMWIND_ROYAL, 10.0f, true))
                                pGuard->AI()->Talk(SAY_GUARD_1);
                            uiTimer = 3000;
                            uiPhase = 6;
                            break;
                        case 6:
                            Talk(SAY_SPYBOT_2);
                            uiTimer = 3000;
                            uiPhase = 7;
                            break;
                        case 7:
                            SetEscortPaused(false);
                            uiTimer = 0;
                            uiPhase = 0;
                            break;
                        case 8:
                            if (Creature* pLescovar = me->FindNearestCreature(NPC_LORD_GREGOR_LESCOVAR, 10.0f))
                                pLescovar->AI()->Talk(SAY_LESCOVAR_1);
                            uiTimer = 3000;
                            uiPhase = 9;
                            break;
                        case 9:
                            Talk(SAY_SPYBOT_4);
                            uiTimer = 3000;
                            uiPhase = 10;
                            break;
                        case 10:
                            if (Creature* pLescovar = me->FindNearestCreature(NPC_LORD_GREGOR_LESCOVAR, 10.0f))
                            {
                                if (Player* player = GetPlayerForEscort())
                                {
                                    CAST_AI(npc_lord_gregor_lescovar::npc_lord_gregor_lescovarAI, pLescovar->AI())->Start(false, false, player->GetGUID());
                                    CAST_AI(npc_lord_gregor_lescovar::npc_lord_gregor_lescovarAI, pLescovar->AI())->SetMaxPlayerDistance(200.0f);
                                }
                            }
                            me->DisappearAndDie();
                            uiTimer = 0;
                            uiPhase = 0;
                            break;
                    }
                } else uiTimer -= uiDiff;
            }
            npc_escortAI::UpdateAI(uiDiff);

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_tyrion
######*/

enum eTyrion
{
    NPC_TYRION_SPYBOT = 8856
};

class npc_tyrion : public CreatureScript
{
public:
    npc_tyrion() : CreatureScript("npc_tyrion") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_THE_ATTACK)
        {
            if (Creature* pSpybot = creature->FindNearestCreature(NPC_TYRION_SPYBOT, 5.0f, true))
            {
                CAST_AI(npc_tyrion_spybot::npc_tyrion_spybotAI, pSpybot->AI())->Start(false, false, player->GetGUID());
                CAST_AI(npc_tyrion_spybot::npc_tyrion_spybotAI, pSpybot->AI())->SetMaxPlayerDistance(200.0f);
            }
            return true;
        }
        return false;
    }
};

/*#####
# npc_varian_wrynn
######*/

enum VarianWrynn
{
    SPELL_HEROIC_LEAP   = 59688, // triggers 59689
    SPELL_WHIRLWIND     = 41056, // triggers 41057

    NPC_GUARD           = 1756,  // this is the wrong guard, it says he summons lvl 75 ones, but I couldnt find them, nor a summon spell

    EVENT_HEROIC_LEAP   = 1,
    EVENT_WHIRLWIND     = 2,
    EVENT_SUMMON_GUARDS = 3,

    QUEST_DEFENDING_ALLIANCE = 60000,

    NOTIFY_COOLDOWN    = 600000,

    SCALING_5          = 73762,
    SCALING_10         = 73824,
    SCALING_15         = 73825,
    SCALING_20         = 73826,
    SCALING_25         = 73827,
    SCALING_30         = 73828,
};

Position const SummonPositions[8] =
{
    {-8420.907227f, 345.702606f, 120.885880f, 3.857443f},
    {-8416.868164f, 328.449921f, 120.885880f, 3.044561f},
    {-8416.940430f, 302.447968f, 120.885880f, 2.255229f}, // Battlemaster Room Entrance
    {-8442.036133f, 308.068848f, 120.885880f, 1.461977f},
    {-8457.666016f, 316.497223f, 120.885880f, 0.673437f},
    {-8476.543945f, 335.009003f, 120.885880f, 6.256822f}, // Room Right
    {-8435.253906f, 369.447723f, 120.885880f, 4.598405f}, // Room Left
    {-8492.133789f, 396.724426f, 108.385780f, 5.356319f}, // Ramp
};

class npc_varian_wrynn : public CreatureScript
{
public:
    npc_varian_wrynn() : CreatureScript("npc_varian_wrynn") { }

    struct npc_varian_wrynnAI : public ScriptedAI
    {
        npc_varian_wrynnAI(Creature* creature) : ScriptedAI(creature), Summons(me) { }

        EventMap events;
        SummonList Summons;

        bool defenderCredit;
        uint32 appliedScaling;
        uint32 rescaleTimer;
        uint32 notifyCooldown;

        void Reset()
        {
            defenderCredit = false;
            appliedScaling = 0;
            rescaleTimer = 5000;
            notifyCooldown = 0;

            me->m_CombatDistance = 100.0f; // he is often tanked in the rooms around him and as such should not reset too early.

            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_ATTACK_POWER, true);

            events.Reset();
            events.ScheduleEvent(EVENT_WHIRLWIND, urand(6000, 9000));
            events.ScheduleEvent(EVENT_HEROIC_LEAP, urand(15000, 25000));
            events.ScheduleEvent(EVENT_SUMMON_GUARDS, urand(30000, 45000));

            Summons.DespawnAll();
        }

        void EnterEvadeMode()
        {
            if (defenderCredit)
            {
                std::list<Player*> playerList;
                Trinity::AnyPlayerInObjectRangeCheck checker(me, me->GetMap()->GetVisibilityRange(), false);
                Trinity::PlayerListSearcher<Trinity::AnyPlayerInObjectRangeCheck> searcher(me, playerList, checker);
                me->VisitNearbyWorldObject(me->GetMap()->GetVisibilityRange(), searcher);
                sLog->outInfo(LOG_FILTER_TSCR, "PvP Boss %s (%d) was protected and Players in Range for Defender Credit are:", me->GetName(), me->GetEntry());
                for (std::list<Player*>::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr)
                {
                    Player* player = (*itr);
                    if (player->GetTeamId() != TEAM_ALLIANCE)
                        continue; // only same faction

                    if (!player->IsPvP())
                    {
                        sLog->outInfo(LOG_FILTER_TSCR, "[ ] %s (not flagged for PvP)", player->GetName());
                        continue; // Do not reward players who are not flagged for pvp ("no pain, no gain")
                    }

                    if (player->GetQuestStatus(QUEST_DEFENDING_ALLIANCE) == QUEST_STATUS_INCOMPLETE)
                    {
                        sLog->outInfo(LOG_FILTER_TSCR, "[x] %s (rewarded)", player->GetName());
                        player->CompleteQuest(QUEST_DEFENDING_ALLIANCE);
                    } else
                        sLog->outInfo(LOG_FILTER_TSCR, "[ ] %s (did not have quest %d at evade)", player->GetName(), QUEST_DEFENDING_ALLIANCE);
                }
            } else
                sLog->outInfo(LOG_FILTER_TSCR, "PvP Boss %s (%d) was protected but did not qualify for Defender Credit (Anti-Farm Rule)", me->GetName(), me->GetEntry());

            if (appliedScaling)
                if (me->HasAura(appliedScaling))
                    me->RemoveAura(appliedScaling);

            ScriptedAI::EnterEvadeMode();
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (notifyCooldown == 0)
            {
                sWorld->SendWorldText(11002, "|TInterface\\Icons\\achievement_leader_king_varian_wrynn.blp:24|t K�nig Varian Wrynn: Sturmwind wird angegriffen!", 0, 0);
                notifyCooldown = NOTIFY_COOLDOWN;
            }
            Talk(0);
            me->CallForHelp(40.0f); // only throne room
        }

        void HandleScaling()
        {
            // make the fight more attractive and less grinding when more players are around
            uint32 enemyCount = 0;
            ThreatContainer::StorageType const &threatList = me->getThreatManager().getThreatList();
            ThreatContainer::StorageType::const_iterator itr;
            for (itr = threatList.begin(); itr != threatList.end(); ++itr)
            {
                Unit* unit = (*itr)->getTarget();
                if (unit && unit->ToPlayer())
                    enemyCount++;
            }

            uint32 newScaling = 0;
            if (enemyCount >= 17)
                newScaling = SCALING_30;
            else if (enemyCount >= 15)
                newScaling = SCALING_25;
            else if (enemyCount >= 13)
                newScaling = SCALING_20;
            else if (enemyCount >= 10)
                newScaling = SCALING_15;
            else if (enemyCount >= 7)
                newScaling = SCALING_10;
            else if (enemyCount >= 5)
                newScaling = SCALING_5;

            if (newScaling == appliedScaling)
                return; // if current scaling equals new scaling stop here
            else
            {
                if (appliedScaling > 0 && me->HasAura(appliedScaling))
                    me->RemoveAura(appliedScaling);
                if (newScaling > 0)
                    me->AddAura(newScaling, me);
                appliedScaling = newScaling;
            }
        }

        void UpdateAI(const uint32 diff)
        {
            // World Notify Cooldown
            if (notifyCooldown >= diff)
                notifyCooldown -= diff;
            else
                notifyCooldown = 0;

            if (!UpdateVictim())
                return;

            // Defender Quest Credit
            if (!defenderCredit)
                if (me->getThreatManager().getThreatList().size() >= 5 && me->GetHealthPct() < 90.f) // Anti-Farming Conditions
                    defenderCredit = true;

            // Boss rescaling
            if (rescaleTimer <= diff)
            {
                HandleScaling();
                rescaleTimer = 10000;
            } else rescaleTimer -= diff;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_WHIRLWIND:
                        DoCastVictim(SPELL_WHIRLWIND);
                        events.ScheduleEvent(EVENT_WHIRLWIND, urand(10000, 15000));
                        break;
                    case EVENT_HEROIC_LEAP:
                        if (Unit* target = SelectTarget(SELECT_TARGET_FARTHEST, 0, 25.0f, true))
                            DoCast(target, SPELL_HEROIC_LEAP);
                        events.ScheduleEvent(EVENT_HEROIC_LEAP, urand(32000, 42000));
                        break;
                    case EVENT_SUMMON_GUARDS:
                        // this feels a bit custom, but sources say he (or the throne room) summons guards...so lets summon some guards
                        uint32 guardCount = 3;
                        for (uint32 iter = 0; iter < guardCount; ++iter)
                            Creature* summon = me->SummonCreature(NPC_GUARD, SummonPositions[urand(0,7)], TEMPSUMMON_CORPSE_DESPAWN);
                        events.ScheduleEvent(EVENT_SUMMON_GUARDS, urand(30000, 45000));
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void JustSummoned(Creature* summon)
        {
            Summons.Summon(summon);

            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 45.0f, true))
            {
                summon->GetMotionMaster()->MoveChase(target);
                summon->SetSpeed(MOVE_RUN, 1.2f);
                summon->Attack(target, true);
            }
        }

        void SummonedCreatureDespawn(Creature* summon)
        {
            Summons.Despawn(summon);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_varian_wrynnAI (creature);
    }

};

void AddSC_stormwind_city()
{
    new npc_archmage_malin();
    new npc_bartleby();
    new npc_lady_katrana_prestor();
    new npc_tyrion();
    new npc_tyrion_spybot();
    new npc_lord_gregor_lescovar();
    new npc_marzon_silent_blade();
    new npc_varian_wrynn();
}