function bool = isOdd(number)
% isOdd � una funzione che verifica se il numero in input � DISPARI.
% Restituisce TRUE se � DISPARI. (altrimenti � PARI)

bool = mod(number, 2) == 1;

end