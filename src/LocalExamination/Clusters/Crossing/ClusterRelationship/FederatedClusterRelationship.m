classdef (Abstract) FederatedClusterRelationship < ClusterRelationship & handle & matlab.mixin.Heterogeneous
    % FEDERATED: si parla di "federazione" quando un insieme di cluster
    %            pi� semplici formano un cluster pi� complesso e pi�
    %            grande. Si ha quando molti cluster sono vicini e non
    %            possono essere studiarti indipendentemente l'uno
    %            dall'altro.
    %                   _   _ 
    %               /    \ /        C_1 e C_2 sono cluster molto vicini,
    %            --o      o             separati da pochi TRACE POINT.  
    %               \   _/ \_       Effettuare un'analisi indipendendente
    %             C_1    C_2        porterebbe a risultati inconcludenti.
    %%%%%
    properties
        % components: array di cluster ID; (definisce quali cluster
        %             compongono la federazione)
        components
        % federation: definisce il tipo di cluster della federazione (cio�
        %             del mega cluster formato dai cluster pi� piccoli); pu�
        %             essere un qualsiasi tipo di SingleClusterRelationship.
        federation
    end
    methods
        function obj = FederatedClusterRelationship()
            obj = obj@ClusterRelationship;
            obj.components = [];
            obj.federation = [];
        end
        function [obj, nextIndex] = crossCluster(obj, index, clusters)
            [obj, nextIndex] = crossCluster@ClusterRelationship(obj, index, clusters);
        end
    end
end