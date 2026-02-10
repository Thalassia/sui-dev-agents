/// A simple DAO governance module with proposal and voting
module starter_dao::dao {
    use std::string::{String};
    use sui::table::{Self, Table};
    use sui::vec_map::{Self, VecMap};

    // ====== Error Codes ======
    const ENotMember: u64 = 0;
    const EAlreadyVoted: u64 = 1;
    const EProposalNotFound: u64 = 2;
    const EProposalNotApproved: u64 = 3;
    const EProposalAlreadyExecuted: u64 = 4;
    const EInsufficientVotes: u64 = 5;

    // ====== Structs ======

    /// Main DAO object
    public struct DAO has key {
        id: UID,
        name: String,
        proposals: Table<u64, Proposal>,
        next_proposal_id: u64,
        members: VecMap<address, u64>, // member -> voting power
        approval_threshold: u64, // percentage (0-100)
    }

    /// Governance proposal
    public struct Proposal has store {
        id: u64,
        proposer: address,
        description: String,
        votes_for: u64,
        votes_against: u64,
        voters: VecMap<address, bool>, // voter -> vote choice
        executed: bool,
        created_epoch: u64,
    }

    /// Membership token
    public struct MemberToken has key, store {
        id: UID,
        dao_id: ID,
        voting_power: u64,
    }

    // ====== Public Functions ======

    /// Create a new DAO
    public fun create_dao(
        name: String,
        approval_threshold: u64,
        ctx: &mut TxContext
    ) {
        assert!(approval_threshold <= 100, EInsufficientVotes);

        let dao = DAO {
            id: object::new(ctx),
            name,
            proposals: table::new(ctx),
            next_proposal_id: 0,
            members: vec_map::empty(),
            approval_threshold,
        };
        transfer::share_object(dao);
    }

    /// Add a member to the DAO
    public fun add_member(
        dao: &mut DAO,
        member: address,
        voting_power: u64,
        ctx: &mut TxContext
    ) {
        vec_map::insert(&mut dao.members, member, voting_power);

        let token = MemberToken {
            id: object::new(ctx),
            dao_id: object::id(dao),
            voting_power,
        };
        transfer::transfer(token, member);
    }

    /// Create a new proposal
    public fun create_proposal(
        dao: &mut DAO,
        description: String,
        ctx: &mut TxContext
    ) {
        let sender = ctx.sender();
        assert!(vec_map::contains(&dao.members, &sender), ENotMember);

        let proposal = Proposal {
            id: dao.next_proposal_id,
            proposer: sender,
            description,
            votes_for: 0,
            votes_against: 0,
            voters: vec_map::empty(),
            executed: false,
            created_epoch: ctx.epoch(),
        };

        table::add(&mut dao.proposals, dao.next_proposal_id, proposal);
        dao.next_proposal_id = dao.next_proposal_id + 1;
    }

    /// Vote on a proposal
    public fun vote(
        dao: &mut DAO,
        proposal_id: u64,
        approve: bool,
        ctx: &mut TxContext
    ) {
        let sender = ctx.sender();
        assert!(vec_map::contains(&dao.members, &sender), ENotMember);
        assert!(table::contains(&dao.proposals, proposal_id), EProposalNotFound);

        let proposal = table::borrow_mut(&mut dao.proposals, proposal_id);
        assert!(!vec_map::contains(&proposal.voters, &sender), EAlreadyVoted);
        assert!(!proposal.executed, EProposalAlreadyExecuted);

        let voting_power = *vec_map::get(&dao.members, &sender);

        if (approve) {
            proposal.votes_for = proposal.votes_for + voting_power;
        } else {
            proposal.votes_against = proposal.votes_against + voting_power;
        };

        vec_map::insert(&mut proposal.voters, sender, approve);
    }

    /// Execute a proposal if it has enough votes
    public fun execute_proposal(
        dao: &mut DAO,
        proposal_id: u64,
        _ctx: &mut TxContext
    ) {
        assert!(table::contains(&dao.proposals, proposal_id), EProposalNotFound);

        let proposal = table::borrow_mut(&mut dao.proposals, proposal_id);
        assert!(!proposal.executed, EProposalAlreadyExecuted);

        let total_votes = proposal.votes_for + proposal.votes_against;
        let approval_rate = if (total_votes > 0) {
            (proposal.votes_for * 100) / total_votes
        } else {
            0
        };

        assert!(approval_rate >= dao.approval_threshold, EProposalNotApproved);

        proposal.executed = true;
        // In a real DAO, you would execute the actual action here
    }

    // ====== View Functions ======

    public fun get_proposal_status(dao: &DAO, proposal_id: u64): (u64, u64, bool) {
        let proposal = table::borrow(&dao.proposals, proposal_id);
        (proposal.votes_for, proposal.votes_against, proposal.executed)
    }

    public fun is_member(dao: &DAO, addr: address): bool {
        vec_map::contains(&dao.members, &addr)
    }

    public fun get_voting_power(dao: &DAO, addr: address): u64 {
        if (vec_map::contains(&dao.members, &addr)) {
            *vec_map::get(&dao.members, &addr)
        } else {
            0
        }
    }
}
