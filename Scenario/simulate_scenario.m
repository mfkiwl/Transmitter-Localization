function [rxPows, rxTimes, rxFreqs, txEstPosA, txEstVelA, txEstPosB] = simulate_scenario(N, scen, tx, rx)
%   SIMULATE_SCENARIO Estimates the transmitter's position and velocity
%
%       Builds the scenario and estimates the transmitter's position and 
%       velocity for the given scenario. 
%
%   Input:      N:          Double. Number of realizations for every step
%               scen:       Struct. Information of the scenario
%               tx:         Struct. Information of the transmitter
%               rx:         1xM struct. Information of the receivers            
%
%   Output:     rxPows:     numRx x1 vector. Received powers
%               rxTimes:    numRx x1 vector. Reception times
%               rxFreqs:    numRx x1 vector. Received frequencies
%               txEstPos:   Nx3 matrix. Estimated positions (X-Y-Z) for the
%                           different realizations.
%               txEstVel:   Nx3 matrix. Estimated velocities (X-Y-Z) for the
%                           different realizations.

    numRx       =   length(rx);
        
    txEstPosA    =   zeros(N, 3);
    txEstVelA    =   zeros(N, 3);
    
    txEstPosB    =   zeros(N, 3);
    
    rxPowsMat   =   zeros(numRx, N);
    rxTimesMat  =   zeros(numRx, N);
    rxFreqsMat  =   zeros(numRx, N);
    estDoasMat  =   zeros(numRx, N);
    for i = 1:N
        for r = 1:numRx
%         for r = 1:numRx
            [rxPowsMat(r, i), rxTimesMat(r, i), rxFreqsMat(r, i), estDoasMat(r, i)] = ...
                observables_generation(rx(r), tx, scen);
        end
    end
    
    for i = 1:N
        [txEstPosA(i, :), txEstVelA(i, :), ~, ~] = ...
            tdoa_fdoa_method(scen, rx, rxPowsMat(:,i), rxTimesMat(:,i), rxFreqsMat);
        
        txEstPosB(i, :) = rss_doa_method(scen, rx, rxPowsMat(:, i), estDoasMat(:, i));
    end
    
    rxPows      =   mean(rxPowsMat, 2);
    rxTimes     =   mean(rxTimesMat, 2);
    rxFreqs     =   mean(rxFreqsMat, 2);
end

