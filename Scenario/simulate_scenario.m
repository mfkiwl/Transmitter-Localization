function [rxPows, rxTimes, rxFreqs, txEstPosA, txEstVelA, txEstPosB, txEstPosC] = simulate_scenario(scen, tx, rx)
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
    global N;
    
    numRx       =   length(rx);
    nDim        =   2;
        
    txEstPosA    =   zeros(N, nDim);
    txEstVelA    =   zeros(N, nDim);
    
    txEstPosB    =   zeros(N, nDim);
    txEstPosC    =   zeros(N, nDim);
    
    rxPowsMat   =   zeros(numRx, N);
    rxTimesMat  =   zeros(numRx, N);
    rxFreqsMat  =   zeros(numRx, N);
    estDoasMat  =   zeros(numRx, N);
    for i = 1:N
        parfor r = 1:numRx
            [rxPowsMat(r, i), rxTimesMat(r, i), rxFreqsMat(r, i), estDoasMat(r, i)] = ...
                observables_generation(scen, rx(r), tx);
        end
    end
    
    for i = 1:N
        [txEstPosA(i, :), txEstVelA(i, :), ~, ~] = ...
            tdoa_fdoa_method(scen, rx, rxPowsMat(:,i), rxTimesMat(:,i), rxFreqsMat(:,i));
        
        [txEstPosC(i, :), ~] = tdoa_method(scen, rx, rxPowsMat(:, i), rxTimesMat(:, i));
        
        txEstPosB(i, :) = rss_doa_method(scen, rx, rxPowsMat(:, i), estDoasMat(:, i));
    end
    
    rxPows      =   rxPowsMat;
    rxTimes     =   rxTimesMat;
    rxFreqs     =   rxFreqsMat;
end

