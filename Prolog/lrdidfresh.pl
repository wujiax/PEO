%Agreement process
told(s,didu,mtc,htc,tstc).
told(tc,xdidu,ms,hs).
told(s,hack_tc)

%Initialization assumption
bel(tc,fresh(alpha)).
poss(tc,alpha,au,bu,tstc,idu,pwu,xu1).
bel(s,fresh(beta)).
poss(s,beta,bs,as,idu,sk,bidu).
told(tc,ms).
poss(tc,(pwu,bu)).
poss(tc,(alpha,pwu,bu)).
poss(tc,h(idu,bu)).
bel(tc,fresh((alpha,pwu,bu))).
:- dynamic bel/2.

poss(A,X):-
	told(A,X).%P1
poss(A,scmul(X,Y)):-
	poss(A,X),poss(A,Y).%P2	
poss(A,sum(X,Y)):-
	poss(A,X),poss(A,Y).%P2
poss(A,h(X)):-
	poss(A,X).%P4
bel(A,fresh((X,pwu,bu))):-
	bel(A,fresh(X)),poss(A,(pwu,bu)).%F1
bel(A,fresh(scmul(ms,X))):-
	bel(A,fresh(X)).%F1
bel(A,fresh(sum(X,h(idu,bu)))):-
	bel(A,fresh(X)).%F1
bel(A,fresh(h(X))):-
	bel(A,fresh(X)),poss(A,X).%F10

%bel(tc,fresh(h(scmul(ms,sum((alpha,pwu,bu),h(idu,bu)))))).
