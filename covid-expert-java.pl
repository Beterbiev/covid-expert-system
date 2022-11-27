:- use_module(library(jpl)).

iniciar :-
interface2.
	
sintoma(Paciente, fiebre) :- 
comprobar(Paciente," fiebre (s/n) ?").
sintoma(Paciente, tos) :- 
comprobar(Paciente," tos (s/n) ?").
sintoma(Paciente, dificultad_respirar) :- 
comprobar(Paciente," dificultad para respirar (s/n) ?").
sintoma(Paciente,fatiga) :- 
comprobar(Paciente," fatiga (s/n) ?").
sintoma(Paciente, dolor_muscular) :- 
comprobar(Paciente," dolores musculares (s/n) ?").
sintoma(Paciente, dolor_cabeza) :- 
comprobar(Paciente," dolor de cabeza (s/n) ?").
sintoma(Paciente, perdida_olfato) :- 
comprobar(Paciente," perdida reciente del olfato o el gusto (s/n) ?").
sintoma(Paciente, dolor_garganta) :- 
comprobar(Paciente," dolor de garganta (s/n) ?").
sintoma(Paciente, congestion) :- 
comprobar(Paciente," congestion o moqueo (s/n) ?").
sintoma(Paciente, nauseas) :- 
comprobar(Paciente," nauseas o vomito (s/n) ?").
sintoma(Paciente, diarrea) :- 
comprobar(Paciente," diarrea (s/n) ?").
	
diagnostico(Paciente, covid) :-
sintoma(Paciente, fiebre),
sintoma(Paciente, tos),
sintoma(Paciente, dificultad_respirar),
sintoma(Paciente, dolor_muscular),
sintoma(Paciente, perdida_olfato),
sintoma(Paciente, dolor_garganta),
sintoma(Paciente, congestion),
sintoma(Paciente, fatiga).

diagnostico(_,". pero no se logro diagnosticar la enfermedad").

response(Reply) :-
read(Reply),
write(Reply),nl.
	
preguntar(Paciente, Pregunta) :-
write(Paciente),write(', tienes'),write( Pregunta),
interface(', tienes',Paciente, Pregunta),nl.

:- dynamic si/1, no/1.		
	
comprobar(P,S) :-
   (si(S) -> true ;
    (no(S) -> fail ;
     preguntar(P,S))).
	 
undo :- retract(si(_)),fail. 
undo :- retract(no(_)),fail.
undo.

pt(Paciente):- 
		diagnostico(Paciente,Enfermedad),
		interface3(Paciente,', probablemente tengas ',Enfermedad,'.'),
        write(Paciente),write(', probablemente tengas '),write(Enfermedad),write('.'),undo,end.

end :-
		nl,
		write('end.'),nl.

interface(X,Y,Z) :-
	atom_concat(Y,X, FAtom),
	atom_concat(FAtom,Z,FinalAtom),
	jpl_new('javax.swing.JFrame', ['COVID-19'], F),
	jpl_new('javax.swing.JLabel',['Sistema experto'],LBL),
	jpl_new('javax.swing.JPanel',[],Pan),
	jpl_call(Pan,add,[LBL],_),
	jpl_call(F,add,[Pan],_),
	jpl_call(F, setLocation, [400,300], _),
	jpl_call(F, setSize, [400,300], _),
	jpl_call(F, setVisible, [@(true)], _),
	jpl_call(F, toFront, [], _),
	jpl_call('javax.swing.JOptionPane', showInputDialog, [F,FinalAtom], N),
	jpl_call(F, dispose, [], _), 
	write(N),nl,
	( (N == si ; N == s) -> assert(si(Z)) ; 
	assert(no(Z)), fail).
	   		
interface2 :-
	jpl_new('javax.swing.JFrame', ['COVID-19'], F),
	jpl_new('javax.swing.JLabel',['Sistema experto'],LBL),
	jpl_new('javax.swing.JPanel',[],Pan),
	jpl_call(Pan,add,[LBL],_),
	jpl_call(F,add,[Pan],_),
	jpl_call(F, setLocation, [400,300], _),
	jpl_call(F, setSize, [400,300], _),
	jpl_call(F, setVisible, [@(true)], _),
	jpl_call(F, toFront, [], _),
	jpl_call('javax.swing.JOptionPane', showInputDialog, [F,'Cual es tu nombre? '], N),
	jpl_call(F, dispose, [], _), 
	(	N == @(null)
		->	write('Operacion cancelada.'),interface3('Operacion cancelada.','','',''),end,fail
		;	write("Cual es tu nombre? "),write(N),nl,pt(N)
	).
	
	
interface3(P,W1,D,W2) :-
	atom_concat(P,W1, A),
	atom_concat(A,D,B),
	atom_concat(B,W2,W3),
	jpl_new('javax.swing.JFrame', ['COVID-19'], F),
	jpl_new('javax.swing.JLabel',['Sistema experto'],LBL),
	jpl_new('javax.swing.JPanel',[],Pan),
	jpl_call(Pan,add,[LBL],_),
	jpl_call(F,add,[Pan],_),
	jpl_call(F, setLocation, [400,300], _),
	jpl_call(F, setSize, [400,300], _),
	jpl_call(F, setVisible, [@(true)], _),
	jpl_call(F, toFront, [], _),
	jpl_call('javax.swing.JOptionPane', showMessageDialog, [F,W3], N),
	jpl_call(F, dispose, [], _), 
	(	N == @(void)
		->	write('')
		;	write("")
	).
	