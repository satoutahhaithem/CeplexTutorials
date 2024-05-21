// Define sets
int conference_sessions = ...; // Define according to actual number
int slots = ...;
int length_of_paper_range = ...;
int NbrGrps = ...;

range Sessions = 1..conference_sessions;
range Slots = 1..slots;
range PaperRange = 1..length_of_paper_range;
range Groups = 1..NbrGrps; // Adjust according to the actual number of working groups

// Parameters
int papers_range[PaperRange] = ...;
int np[Sessions] = ...;
int npMax[Slots] = ...;
int max_parallel_sessions = ...;

// Define session groups as sets of groups
{int} session_groups[Sessions] = [
    {1}, {2}, {3}, {}, {}, {}, {6}, {7}, {7, 8}, {10}, {8}, {8, 11}, {5, 8}, 
    {3, 8}, {7}, {13}, {13}, {14}, {}, {8}, {16}, {16}, {20}, {17}, {13}, 
    {}, {9}, {11}, {11, 12}, {9}, {6, 19}, {}, {}, {18}, {10}, {5}, {16}, 
    {4, 5}, {8, 12}, {7, 15}
];

// Decision Variables
dvar boolean x[Sessions][Slots][PaperRange];
dvar boolean y[Sessions][Sessions][Slots][Groups];
dvar boolean z[Sessions][Slots];

// Intermediate Variables
dvar int session_allocated[Sessions][Slots];

// Objective Function: Minimize working-group conflicts
dexpr int num_conflicts = sum(s1 in Sessions, s2 in Sessions: s1 < s2, c in Slots, g in Groups: g in session_groups[s1] && g in session_groups[s2])
    y[s1][s2][c][g];

minimize num_conflicts;

// Constraints
subject to {
    // At most one amount of papers chosen for a (session, slot) pair
    forall(s in Sessions, c in Slots)
        sum(l in PaperRange) x[s][c][l] <= 1;

    // Subdivision of a session into slots covers all the papers in the session
    forall(s in Sessions)
        sum(c in Slots, l in PaperRange) papers_range[l] * x[s][c][l] == np[s];

    // Session allocation indicator
    forall(s in Sessions, c in Slots)
        session_allocated[s][c] == (sum(l in PaperRange) x[s][c][l] >= 1);

    // Equivalence transformation for session-slot (z variable)
    forall(s in Sessions, c in Slots)
        z[s][c] == (sum(l in PaperRange) x[s][c][l] >= 1);

    // Two sessions associated with the same group and allocated to the same slot generate a conflict
    forall(s1 in Sessions, s2 in Sessions: s1 < s2, c in Slots, g in Groups: g in session_groups[s1] && g in session_groups[s2])
        y[s1][s2][c][g] == ((session_allocated[s1][c] + session_allocated[s2][c]) == 2);
}
