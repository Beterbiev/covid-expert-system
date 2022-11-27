iniciar :-
write('Cual es tu nombre?'),
read(Paciente),
diagnostico(Paciente, Enfermedad),
write(Paciente),write(', probablemente tengas '),write(Enfermedad),write('.'),undo,end.

iniciar :-
write('No se logro diagnosticar la enfermendad'),nl.

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

preguntar(Paciente, Pregunta) :-
	write(Paciente),write(', tienes'),write( Pregunta),
	read(Respuesta),
	( (Respuesta == si ; Respuesta == s)
      ->
       assert(si( Pregunta)) ;
       assert(no( Pregunta)), fail).
	
:- dynamic si/1,no/1.		
	
comprobar(P,S) :-
   (si(S) -> true ;
    (no(S) -> fail ;
     preguntar(P,S))).
	 
undo :- retract(si(_)),fail. 
undo :- retract(no(_)),fail.
undo.

diagnostico(Paciente, covid) :-
sintoma(Paciente, fiebre),
sintoma(Paciente, tos),
sintoma(Paciente, dificultad_respirar),
sintoma(Paciente, fatiga).

end :-
nl,
write('end.'),nl.

response(Reply) :-
read(Reply),
write(Reply),nl.