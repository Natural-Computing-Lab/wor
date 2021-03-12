function gcRank = getGoodContinuityRank(goodContinuityValues)

% I valori di goodContinuityValues possono essere compresi tra 0 e 180. Un
% valore minore indica che la buona continuit� � ben rispettata. Inoltre,
% il primo valore deve avere un peso maggiore nella classificazione perch�
% indica la buona continuit� sul segmento che unisce due cluster e di
% conseguenza pi� � uniforme meglio �; poich� per� tratti sovrapposti
% possono creare ambiguit� e generare segmenti anche molto curvi, il peso
% dato al primo valore non deve essere molto pi� alto degli altri nella
% scelta.
% INTERVALLI
% 1. GC: alta
% 2. GC: media
% 3. GC: bassa
weight(1) = 0.25;
weight(2) = 0.375;
weight(3) = 0.375;
minGCValue = 0;
maxGCValue = 180*weight(1) + 180*weight(2) + 180*weight(3);

weightedSum = 0;
for i = 1 : length(goodContinuityValues)
     weightedSum = weightedSum + goodContinuityValues(i)*weight(i);  
end

gcRank = weightedSum;

