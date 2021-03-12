function angle = atan2d_norm(Y, X)
% atan2d_norm � una funzione che calcola l'angolo (in gradi) a partire dalle
% coordinate x e y, esattamente come farebbe atan2d. La differenza � che la
% funzione � "normalizzata" al contesto che stiamo studiando, cio� quello
% delle immagini, in cui il sistema di riferimento ha le y positive verso
% il basso e le x positive verso destra. Infine, in caso di risultato
% negativo, viene effettuata una somma di 360 per portarla nel range [0,
% 360]. 
% Infine � importante affinch� la funzione lavori correttamente, che si dia
% come input ad Y la differenza sull'asse X e come input ad X la differenza
% sull'asse Y. Il problema � dato sempre dal contesto in cui stiamo
% lavorando, che inverte l'orientamento dell'asse Y.

angle = atan2d(Y, X) + 90;

if angle < 0
    angle = angle + 360;
end

end