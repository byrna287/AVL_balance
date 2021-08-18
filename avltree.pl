/* implementing an avl tree in prolog */

% Ailbhe Byrne
% 19424402
% I acknowledge the DCU academic integrity policy.

% binary tree: bt(Root, Left, Right).

bt(_, _, _).

% addnode: add X to T1 to get T2 (came from prolog notes)

addnode(X, nil, bt(X, nil, nil)) :- !.
addnode(X, bt(Y, L, R), bt(Y, L1, R)) :- X =< Y, addnode(X, L, L1), !.
addnode(X, bt(Y, L, R), bt(Y, L, R1)) :- X > Y, addnode(X, R, R1), !.

% insert: add X to AVL T1 to get AVL T2

insert(X, T1, T2) :- addnode(X, T1, T11), ll(T11), ll_rebalance(T11, T2), !.
insert(X, T1, T2) :- addnode(X, T1, T11), rr(T11), rr_rebalance(T11, T2), !.
insert(X, T1, T2) :- addnode(X, T1, T11), rl(T11), rl_rebalance(T11, T2), !.
insert(X, T1, T2) :- addnode(X, T1, T11), lr(T11), lr_rebalance(T11, T2), !.

insert(X, T1, T2) :- addnode(X, T1, T2).

% height: H is height of tree

height(nil, 0).
height(bt(_, nil, nil), 1).
height(bt(_, L, R), H) :-  height(L, HL), height(R, HR), MH is max(HL, HR), H is MH + 1, !.

% bfactor: B is balancing factor of tree

bfactor(bt(_, L, R), B) :- height(L, HL), height(R, HR), B is HL - HR, !.

% ll, rr, rl, lr: match each kind of tree imbalance

ll(bt(X, L, R)) :- bfactor(bt(X, L, R), 2), bfactor(L, 1).
ll(bt(X, L, R)) :- bfactor(bt(X, L, R), 2), bfactor(L, 2).

rr(bt(X, L, R)) :- bfactor(bt(X, L, R), -2), bfactor(R, -1).
rr(bt(X, L, R)) :- bfactor(bt(X, L, R), -2), bfactor(R, -2).

rl(bt(X, L, R)) :- bfactor(bt(X, L, R), -2), bfactor(R, 1).
rl(bt(X, L, R)) :- bfactor(bt(X, L, R), -2), bfactor(R, 2).

lr(bt(X, L, R)) :- bfactor(bt(X, L, R), 2), bfactor(L, -1).
lr(bt(X, L, R)) :- bfactor(bt(X, L, R), 2), bfactor(L, -2).

% rebalance tree after each kind of imbalance

ll_rebalance(bt(Root, bt(LRoot, bt(LLRoot, LLLeft, LLRight), LRight), Right), bt(LRoot, bt(LLRoot, LLLeft, LLRight), bt(Root, LRight, Right))).

rr_rebalance(bt(Root, Left, bt(RRoot, RLeft, bt(RRRoot, RRLeft, RRRight))), bt(RRoot, bt(Root, Left, RLeft), bt(RRRoot, RRLeft, RRRight))).

rl_rebalance(bt(Root, Left, bt(RRoot, bt(RLRoot, RLLeft, RLRight), RRight)), bt(RLRoot, bt(Root, Left, RLLeft), bt(RRoot, RLRight, RRight))).

lr_rebalance(bt(Root, bt(LRoot, LLeft, bt(LRRoot, LRLeft, LRRight)), Right), bt(LRRoot, bt(LRoot, LLeft, LRLeft), bt(Root, LRRight, Right))).

% display: print tree

printel(X, H) :- H3 is 3 * H, tab(H3), write(X), nl.

display(nil).
display(bt(X, L, R)) :- height(bt(X, L, R), H), display(L), printel(X, H), display(R), !.


% test cases
% an avl tree is unbalanced if the height difference between its children is more than 1

% bt(5, nil, nil)

% bt(5, bt(3, nil, nil), bt(9, nil, nil))

% ll case:   bt(5, bt(3, bt(2, bt(1, nil, nil), nil), bt(4, nil, nil)), bt(6, nil, nil))
% insert 1:  bt(5, bt(3, bt(2, nil, nil), bt(4, nil, nil)), bt(6, nil, nil))

% rr case:   bt(2, bt(1, nil, nil), bt(4, bt(3, nil, nil), bt(5, nil, bt(6, nil, nil))))
% insert 6:  bt(2, bt(1, nil, nil), bt(4, bt(3, nil, nil), bt(5, nil, nil)))

% rl case:   bt(2, bt(1, nil, nil), bt(5, bt(3, nil, bt(4, nil, nil)), bt(6, nil, nil)))
% insert 4:  bt(2, bt(1, nil, nil), bt(5, bt(3, nil, nil), bt(6, nil, nil)))

% lr case:   bt(5, bt(2, bt(1, nil, nil), bt(4, bt(3, nil, nil), nil)), bt(6, nil, nil))
% insert 3:  bt(5, bt(2, bt(1, nil, nil), bt(4, nil, nil)), bt(6, nil, nil))
