function [rxTime, rxFreq] = observables_generation(rx, tx, scen)
%   OBSERVABLES_GENERATION:     Calculation of the observables
%
%       Reception time and reception frequency generation from the given
%       positions and velocities of the transmitter and receiver. Gaussian
%       noise is added following the form N(0, CRB).
%
%   Input:      rxPos:  3x1 vector. Receiver position
%               rxVel:  3x1 vector. Receiver velocity
%               txPos:  3x1 vector. Transmitter position
%               txVel:  3x1 vector. Transmitter velocity
%               txFreq: Double. Transmitted signal's frequency
%               SNR:    Double. Signal-to-Noise Ratio of the received signal
%               Ns:     Double. Number of samples
%
%   Output:     rxTime: Double. Reception time in seconds
%               rxFreq: Double. Received signal frequency in Hz

    %- Constants initialization
    c       =   physconst('LightSpeed');    % Speed of light [m/s]
    k       =   physconst('Boltzmann');     % Boltzmann constant [J/K]
    To      =   290;                        % Ambient temperature [K]
    v       =   c/scen.n;                   % Propagation speed
    
    %- Computation of range and relative velocity between Tx and Rx
    [range, radVel]   =   compute_range_and_rad_vel(rx, tx);
    
    %- Actual propagation time and frequency drift computation
    tProp   =   range/v;                 % Propagation time
    fDop    =   scen.freq * (radVel/v);  % Doppler frequency drift
    
    %- Observed frequency computation
    fNoise  =   compute_freq_noise(scen);
    rxFreq  =   scen.freq + fDop + fNoise;
    
    %- Received power and SNR computation
    rxPow   =   get_rx_power(scen, range);
    No      =   k * To * scen.bw * db2pow(scen.nFig);
    SNR     =   rxPow/No;
    
    %- Observed reception time compution
    tNoise  =   compute_time_noise(scen, rxFreq, SNR);
    rxTime  =   tProp + tNoise; 

end

