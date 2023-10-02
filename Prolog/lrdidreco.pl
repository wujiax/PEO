%Agreement process
told(s,didu,mtc,htc,tstc).
told(tc,xdidu,ms,hs).
told(s,hack_tc)

%Initialization assumption
bel(tc,reco(alpha)).
poss(tc,alpha,au,bu,tstc,idu,pwu,xu1).
told(tc,ms).
poss(tc,(pwu,bu)).
poss(tc,(alpha,pwu,bu)).
poss(tc,h(idu,bu)).
bel(tc,reco((alpha,pwu,bu))).
:- dynamic bel/2.

poss(A,X):-
	told(A,X).%P1
poss(A,scmul(X,Y)):-
	poss(A,X),poss(A,Y).%P2	
poss(A,sum(X,Y)):-
	poss(A,X),poss(A,Y).%P2
poss(A,h(X)):-
	poss(A,X).%P4
bel(A,reco((X,pwu,bu))):-
	bel(A,reco(X)),poss(A,(pwu,bu)).%R5
bel(A,reco(scmul(ms,X))):-
	bel(A,reco(X)).%R1
bel(A,reco(sum(X,h(idu,bu)))):-
	bel(A,reco(X)).%R1
bel(A,reco(h(X))):-
	bel(A,reco(X)),poss(A,X).%R5

%Goal:bel(tc,reco(h(scmul(ms,sum((alpha,pwu,bu),h(idu,bu)))))).
