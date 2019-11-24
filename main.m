%**************************************************************************
% MODAL ANALYSIS OF LINEAR ORR-SOMMERFELD OPERATOR FOR BOUNDARY LAYERS
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%
% Code Written by:  UTSAV JAIN
% Last Modified:    NOVEMBER 2019
% Course:           ME59700
% Instructor:       DR. CARLO SCALO
%
% Assumptions:
% ~~~~~~~~~~~~
% -- The gradients in the stream-wise direction are 0
% -- Only the base velocity only has a gradient in the span-wise direction
% -- Incompressible flow with constant density
% -- beta (wave number in z direction) assumed to be 0
% 
%**************************************************************************

% Clearing screens, variables and figures...
clc; clearvars; close all; warning('off'); format long G;

%--------------------------------------------------------------------------
% TESTING POLYNOMIAL BASES...
%--------------------------------------------------------------------------

% Laguerre Polynomial...
laguerrePol = makeLaguerrePol(5,-5:0.01:30);

% Laguerre Function...
laguerreFunc = makeLaguerreFunc(laguerrePol,-5:0.01:30);

% Transformed Laguerre Function...
transLaguerreFunc = makeTransformedLaguerreFunc(laguerreFunc);

% Plotting polynomial basis...
figure; 
    subplot(1,2,1); 
        plotLaguerrePol(laguerrePol,-5:0.01:30);
    subplot(1,2,2); 
        plotLaguerreFunc(laguerreFunc,-5:0.01:30);
figure; 
    subplot(1,2,1); 
        plotLaguerreFunc(laguerreFunc,-5:0.01:30);
    subplot(1,2,2); 
        plotLaguerreFuncTrans(transLaguerreFunc,-5:0.01:30);

% Clearing variables...
clearvars laguerrePol laguerreFunc transLaguerreFunc;

%--------------------------------------------------------------------------
% ORR-SOMMERFELD OPERATOR...
%--------------------------------------------------------------------------

% Orr-Sommerfeld Input...
order          = 63;    % degree of freedom...
scalF          = 1.0;   % scaling factor for gauss quadrature...
k              = 2.0;   % spatial wave number...
Re             = 1.0;   % Reynolds Number...

% Laguerre-Gauss Quadrature Nodes...
laguerreGQNodes = makeLaguerreGQNodes(order);

% Scaling the Laguerre-Gauss Quadrature Nodes...
laguerreGQNodes(:,1) = laguerreGQNodes(:,1) ./ scalF;

% Laguerre Polynomials and derivatives...
laguerrePol = makeLaguerrePol(order,laguerreGQNodes);
[laguerrePol1,laguerrePol2] = makeLaguerrePolDerivs(laguerrePol);

% Laguerre Function and derivatives...
laguerreFunc = makeLaguerreFunc(laguerrePol,laguerreGQNodes);
[laguerreFunc1,laguerreFunc2] = makeLaguerreFuncDerivs(...
    laguerrePol,laguerrePol1,laguerrePol2,laguerreGQNodes);

% Laguerre Gauss Quadrature Weights...
laguerreGQWeights = makeLaguerreGQWeights(order,laguerreFunc);

% Transformed Laguerre Functions and derivatives...
transLaguerreFunc = makeTransformedLaguerreFunc(laguerreFunc);
[transLaguerreFunc1,transLaguerreFunc2] = ...
    makeTransLaguerreDeriv(laguerreFunc1,laguerreFunc2);

% Linear Base Velocity Profile...
linearBaseVelocity = makeLinearBaseVelocity(laguerreGQNodes);

% Parabolic Base Velocity Profile...
parabolicBaseVelocity = makeParabolicBaseVelocity(laguerreGQNodes);

% Blasius Base Velocity Profile...
% -- blasiusBaseVelocity = makeBlasiusBaseVelocity(laguerreGQNodes);

% Plotting Laguerre Gauss Quadrature...
plotLaguerreGaussQuadrature([8;16;24]);

% Orr-Sommerfeld Operator (linear base profile)...
orrSommerfeldOperator(k,linearBaseVelocity,zeros(order+1,1));

% Orr-Sommerfeld Operator (parabolic base profile)...
orrSommerfeldOperator(k,parabolicBaseVelocity,-2*ones(order+1,1));

% Orr-Sommerfeld Operator (Blasius base profile)...
% -- orrSommerfeldOperator(k,blasiusBaseVelocity);

%% PROBLEMS:
% -- Checking the derivation...
% -- Scaling of the polynomial to get more points in the BL...
