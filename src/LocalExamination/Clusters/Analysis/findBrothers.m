function [brotherIndexes, connectingPixels] = findBrothers(clusterIndex, image, clusters, options)

% La funzione verifica se il cluster in esame, definito da clusterIndex �
% molto vicino ad altri cluster; la vicinanza � definita in termini di px.
% Se la distanza da un altro cluster � inferiore a
% Thresholds.NUM_PIXELS_BROTHERHOOD, allora si dice che i due cluster sono
% vicini tra di loro.
% Il clusterRank di cluster definisce il numero di exitDirections. Bastano
% clusterRank-1 exitDirections prive di cluster vicini per risolvere
% correttamente un cluster. Dunque se due rami d'uscita � verificata la
% vicinanza con un altro cluster, il cluster non pu� essere risolto senza
% ambiguit� e va unito con i clusters con cui � vicino.
%
%    ooo
%       oo                          cluster di rango 4,
%         x  ooooo                privo di cluster vicini
%          xx
%         x  ooo                   x   sono i px del cluster
%    ooooo      oo                 o   sono i trace points
%
%    ooo           oooo
%       oo        o                  cluster di rango 4,
%         x  oooxx   ooo        connesso ad un cluster di rango 3
%     C1   xx    xxoo              tramite 2 exit directions
%         x  ooox   C2
%    ooooo       o
%                 oo
%                   oo
% Nel secondo caso, i cluster vanno uniti, creando un nuovo cluster pi�
% grande. Si pu� dire che i due cluster C1 e C2 sono fratelli e che il
% nuovo cluster � la famiglia (riunita).


%%% CONTROLLO VICINANZA CON ALTRI CLUSTERS
% Vedo su ogni direzione se c'� un cluster a meno di
% Thresholds.NUM_PIXELS_BROTHERHOOD. 

% Cerco tutti i cluster collegati a quello in esame
[~, indexesCluster, pxDistances, associatedBPIndexes, ~] = findNearestClusters(clusterIndex, image, clusters, options);

% Filtro i cluster che sono pi� lontani della soglia definita
clusterRank = clusters(clusterIndex).clusterRank; 
nearFilter = true(clusterRank, 1);
for i = 1 : clusterRank
    if pxDistances(i) < Thresholds.NUM_PIXELS_BROTHERHOOD
        nearFilter(i) = false;
    end
end
indexesCluster(nearFilter) = [];
associatedBPIndexes(nearFilter,:) = [];

%%% RICERCA CLUSTER CONNESSI TRAMITE 2 RAMI
% Si dice che un cluster vicino � un brother valido, se � connesso al
% cluster in esame per almeno due rami (distando da esso meno della
% soglia).

% Trova i valori unici
uniqueClusterIndexes = unique(indexesCluster);
% Conta il numero di istanze di ognuno dei valori unici
numUniqueNumbers = length(uniqueClusterIndexes);
brotherCount = zeros(1, numUniqueNumbers);
for i = 1 : numUniqueNumbers
    brotherCount(i) = length(find(indexesCluster == uniqueClusterIndexes(i)));
end

% Trova i brothers ripetuti 2 volte 
brotherPositions = find(brotherCount >= 2);


%%% CONTROLLO FRATELLI E RICERCA PIXEL CONGIUNGENTI
% Se brotherPositions � vuoto, non ci sono fratelli validi; altrimenti
% bisogna aggiungere alla struttura connectingPixels, tutti i pixel che
% sussistono tra i fratelli trovati (cio� i TRACE POINT che li
% congiungono).
connectingPixels = [];
if ~isempty(brotherPositions)
    brotherIndexes = uniqueClusterIndexes(brotherPositions);
    
    % TROVO I PIXEL TRA I DUE CLUSTER FRATELLI
    numBrothers = length(brotherIndexes);
    for i = 1 : numBrothers
        brosFilter = (indexesCluster == brotherIndexes(i));
        brosAssociatedBPIndexes = associatedBPIndexes(brosFilter,:);
        [lengthBrosABPIndexes, ~] = size(brosAssociatedBPIndexes);
        
        anchorBP = clusters(clusterIndex).anchorBP;       
        exitDirections = clusters(clusterIndex).exitDirections;
        
        for j = 1 : lengthBrosABPIndexes
            currAnchorBP = anchorBP(brosAssociatedBPIndexes(j,1),:);
            exitDirection = exitDirections(brosAssociatedBPIndexes(j,1),:);
            currPixel = currAnchorBP + exitDirection;
            oppositeDirection = computeOppositeDirection(exitDirection);
    
            % TRACE FOLLOWING SULLA DIREZIONE CONGIUNGENTE
            while true
                [currPixel, direction, ~] = traceFollowing(image, clusters, options, currPixel, oppositeDirection);
                if isTheSameDirection(direction, Directions.NO_DIRECTION)
                    break;
                else
                    connectingPixels = [connectingPixels; currPixel];
                    currPixel = currPixel + direction;  
                    oppositeDirection = computeOppositeDirection(direction);
                end
            end
        end
    end
else
    brotherIndexes = [];
end


end