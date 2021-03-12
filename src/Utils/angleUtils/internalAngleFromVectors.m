function angle = internalAngleFromVectors(vect1, vect2)
% Si basa sul teorema del coseno. Il risultato � in gradi. 
% La funzione prende come input due vettori vect1 e vect2 e restituisce un
% angolo in gradi. I vettori devono essere ottenuti considerando lo stesso
% centro: 
%                x vect1
%               /
%              /    angle
%             /      
%    centro  o - - - - x vect2
%
% L'angolo risultante � sempre quello interno a due vettori (cio� quello 
% pi� piccolo) e mai quello esterno.

angle = acosd((dot(vect1, vect2))/(norm(vect1)*norm(vect2)));

end