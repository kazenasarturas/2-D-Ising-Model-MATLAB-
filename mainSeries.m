% Author: Arturas Kazenas
clc
clear all


numSpinsPerDim = 2^6;               % Size of array (specified by one dimention)
probSpinUp = 0.5;                   
J = 1;                              % Exchange constant

% Temperatures to sample
numTemps = 2^6;                     % Temperature range (from 0 to numTemps)
kTc = 2*J / log(1+sqrt(2));         % Curie temperature
kT = linspace(0, 2*kTc, numTemps);  % Temperature increment size

% Preallocate to store results
Emean = zeros(size(kT));
Mmean = zeros(size(kT));

tic % Start process timer

for tempIndex = 1 : numTemps
    spin = initSpins(numSpinsPerDim, probSpinUp);   % Initialising spins of array
    spin = metropolis(spin, kT(tempIndex), J);      % Flipping spins using metropolis algorithm
    Emean(tempIndex) = energyIsing(spin, J);        % Calculating average energy level of array
    Mmean(tempIndex) = magnetizationIsing(spin);    % Calculating average magnetic potention of array
    
    
    drawnow;
    imagePlot(spin,numSpinsPerDim,tempIndex);               % Plot of spin orientation
    linePlot(kT, kTc, numTemps, Emean, Mmean, tempIndex);   % Plot of change in energy and magnetisation levels

end


toc % Stop process timer

timeElapsed = toc % Dsiplay elapsed time of process