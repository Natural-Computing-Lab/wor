function bool = isEven(number)
% isEven � una funzione che verifica se il numero in input � PARI.
% Restituisce TRUE se � PARI. (altrimenti � DISPARI)

bool = mod(number, 2) == 0;

end