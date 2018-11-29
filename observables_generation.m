function [rxTime, rxFreq] = observables_generation(rxPos, rxVel, txPos, txVel, txTime, txFreq)
%   OBSERVABLES_GENERATION:     Calculation of the observables
%
%       Reception time and reception frequency generation from the given
%       positions and velocities of the transmitter and receiver. Gaussian
%       noise is added following the form N(0, CRB).
%
%   Input:      rxPos:  Receiver position
%               rxVel:  Receiver velocity
%               txPos:  Transmitter position
%               txVel:  Transmitter velocity
%               txTime: Tranmsission time
%               txFreq: Transmitted signal's frequency
%
%   Output:     rxTime: Reception time
%               rxFreq: Received signal frequency

    %- Parameters initialization
    c       =   299792458;              % Speed of light (m/s)
    
    %- Relative distance and velocity computation
    dRel    =   norm(txPos - rxPos);    % Distance between Tx and Rx
    % TODO:
    vRel    =   txVel;                  % Relative velocity of Tx to Rx 
    
    %- Actual propagation time and frequency drift computation
    tProp   =   dRel/c;                 % Propagation time
    fDop    =   txFreq * (vRel/c);      % Doppler frequency drift
    
    %- Noise computation
    tNoise  =   0;  % TODO
    fNoise  =   0;  % TODO
    
    %- Observables computation
    rxTime  =   txTime + tProp + tNoise; 
    rxFreq  =   txFreq + fDop + fNoise;

end

