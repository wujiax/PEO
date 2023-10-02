%Agreement process
told(s,didu,mtc,htc,tstc).
told(tc,xdidu,ms,hs).
told(s,hack_tc).

:- dynamic bel/2.
:- dynamic poss/2.

%Initialization assumption
poss(tc,sum(a,h(idu,bu))).
told(tc,mt).
told(tc,xdidu).
bel(tc,fresh(sk)).%goal1
told(tc,h((x0u,didu,sk,tstc))).
bel(tc,share(tc,idu,s)).
poss(tc,alpha,au,bu,tstc,idu,pwu,xu1).
told(tc,mt).
poss(tc,(pwu,bu)).
poss(tc,(alpha,pwu,bu)).
poss(tc,h(idu,bu)).

%Rules
poss(A,X):-
	told(A,X).%P1
poss(A,scmul(X,Y)):-
	poss(A,X),poss(A,Y).%P2	
poss(A,sum(X,Y)):-
	poss(A,X),poss(A,Y).%P2
poss(A,h(X)):-
	poss(A,X).%P4	
prov1 :-%Prove that tc owns the session key
	poss(tc,h(scmul(mt,sum((alpha,pwu,bu),h(idu,bu))))),
	asserta(poss(tc,sk)).

poss(A,xor(X,Y)):-
 	poss(A,X),poss(A,Y).%P2P4
prov2:-%Prove that tc owns didu
	poss(tc,xor(xdidu,sk)),
	asserta(poss(tc,(idu,(x0u,didu,sk,tstc)))).

bel(A,fresh(idu,(x0u,didu,X,tstc))):-
	bel(A,fresh(X)),poss(A,(idu,(x0u,didu,X,tstc))).%F1

bel_e(A,said(B,(X,Y))):-
	told(A,h(Y)),
	poss(A,(X,Y)),
	bel(A,share(A,X,B)),
	bel(A,fresh(X,Y)).%I3
	
bel_I7(tc,said(s,(sk,(x0u,didu,idu,tstc)))):-%exchange
	bel_e(tc,said(s,(idu,(x0u,didu,sk,tstc)))).

bel(A,fresh(X,Y)):-
	bel(A,fresh(X)),
	poss(A,Y).%F1

bel(A,said(B,X)):-
	bel_I7(A,said(B,(X,(x0u,didu,idu,tstc)))).%I7

bel(A,poss(B,X)):-
	bel(A,said(B,X)),
	bel(A,fresh(X)).%4：I6

%Goal3:bel(tc,poss(s,sk)).


