%**************************************************************************
% MODAL ANALYSIS OF LINEAR ORR-SOMMERFELD OPERATOR
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Code Written by:  UTSAV JAIN
% Last Modified:    DECEMBER 2019
%
% Assumptions:
% ~~~~~~~~~~~~
% -- The gradients in the stream-wise direction are neglected
% -- Only the base velocity only has a gradient in the span-wise direction
% -- Incompressible flow with constant density
% -- beta (wave number in z direction) assumed to be 0
% -- The code can only solve for boundary layer or channel flow
%
% Solution format:
% ~~~~~~~~~~~~~~~~
%**************************************************************************

% Clearing screens, variables and figures...
clc; clearvars; warning('off'); format long G;
checkPoly = 0;

%--------------------------------------------------------------------------
% TESTING POLYNOMIAL BASES...
%--------------------------------------------------------------------------
if(checkPoly == 1)
                                                     % Boundary Layer Bases
                                                     %---------------------
% Laguerre Polynomial...
laguerrePol = makeLaguerrePol(5,-5:0.01:30);
% Laguerre Function...
laguerreFunc = makeLaguerreFunc(laguerrePol,-5:0.01:30);
% Transformed Laguerre Function...
transLaguerreFunc = makeTransformedLaguerreFunc(laguerreFunc,-5:0.01:30,1);
% Plotting polynomial basis...
figure; 
    subplot(1,2,1); 
        plotLaguerrePol(laguerrePol(1,:,:),-5:0.01:30);
    subplot(1,2,2); 
        plotLaguerreFunc(laguerreFunc(1,:,:),-5:0.01:30);
figure; 
    subplot(1,2,1); 
        plotLaguerreFunc(laguerreFunc(1,:,:),-5:0.01:30);
    subplot(1,2,2); 
        plotLaguerreFuncTrans(transLaguerreFunc(1,:,:),-5:0.01:30);
                                                       % Channel Flow Bases
                                                       %-------------------
% Chebyshev polynomial...
chebyPol = makeChebyPol(5,-1:0.001:1);
% Transformed Chebyshev polynomials...
transChebyPol = makeTransChebyPol(chebyPol);
% Plotting polynomials basis...
plotChebyPol(chebyPol,transChebyPol,-1:0.001:1);

clearvars laguerrePol laguerreFunc transLaguerreFunc chebyPol;

end

%--------------------------------------------------------------------------
% ORR-SOMMERFELD OPERATOR...
%--------------------------------------------------------------------------
% Making case number matrix...
ReNum       = 5900;
waven       = 1.02; 
testCase    = 2;              %-- 1: Boundary Layer
                              %-- 2: Channel Flow
spatioTempo = 1;
order       = 351;            % degree of freedom...
scalF       = 001;            % scaling factor for gauss quadrature...
ivis        = 1;              % 0: inviscid flow 1: viscous flow...
cutColumns  = 0;

if( testCase == 1 )  
    
%--------------------------------------------------------------------------
% INCOMPRESSIBLE BOUNDARY LAYER... (using Laguerre basis) 
%--------------------------------------------------------------------------
linVel      = 1;
parVel      = 1;
blaVel      = 1;
polType     = 1;
                                                         % Gauss Quadrature
                                                         %-----------------
% Laguerre-Gauss Quadrature Nodes...
laguerreGQNodes = abs(makeLaguerreGQNodes(order));
% Plotting Laguerre Gauss Quadrature...
plotLaguerreGaussQuadrature([8;16;24]);
                                              % Orthonormal Basis Functions
                                              %----------------------------
% Laguerre Polynomials and derivatives...
laguerrePol = makeLaguerrePol(order,laguerreGQNodes);
laguerrePol = makeLaguerrePolDerivs(laguerrePol,laguerreGQNodes);
% Laguerre Function and derivatives...
laguerreFunc = makeLaguerreFunc(laguerrePol,laguerreGQNodes);
laguerreFunc = makeLaguerreFuncDerivs(laguerrePol,laguerreFunc,...
    laguerreGQNodes);
% Transformed Laguerre Functions and derivatives...
transLaguerreFunc = ...
    makeTransformedLaguerreFunc(laguerreFunc,laguerreGQNodes,polType);
transLaguerreFunc = makeTransLaguerreDeriv(laguerreFunc,...
    transLaguerreFunc,laguerreGQNodes,polType);
                                                       % Quadrature Weights
                                                       %-------------------
% Laguerre Gauss Quadrature Weights...
laguerreGQWeights = makeLaguerreGQWeights(order,laguerreFunc);  
                                            % Reducing order of polynomials
                                            %------------------------------
% Reducing order of matrices...
transLaguerreFunc = reduceOrderOfBasis (transLaguerreFunc,cutColumns);
                                                           % Scaling factor
                                                           %---------------                                       
% Scaling the Laguerre-Gauss Quadrature Nodes...
laguerreGQNodes(:,1) = laguerreGQNodes(:,1) ./ scalF;
                                                % BL Base Velocity Profiles
                                                %--------------------------
% Linear Base Velocity Profile...
if(linVel == 1)
linearBaseVelocity = makeLinearBaseVelocity(laguerreGQNodes);
end
% Parabolic Base Velocity Profile...
if(parVel == 1)
parabolicBaseVelocity = makeParabolicBaseVelocity(laguerreGQNodes);
end
% Blasius Base Velocity Profile...
if(blaVel == 1)
blasiusBaseVelocity = makeBlasiusBaseVelocity(laguerreGQNodes,0);
end
% Plotting Base Velocity Profiles...
plotBaseVelProfiles(laguerreGQNodes,3);

% Iterating over different test cases...
for iRe = 1 : size(ReNum,1)
    
for ik = 1 : size(waven,1)
    
% Print case number...
fprintf('Case %d out of %d!\n',(iRe-1)*size(ik,1)+ik,size(ReNum,1)*...
    size(waven,1));

% Orr-Sommerfeld Input...
k  = waven(ik,1);    % spatial wave number...
Re = ReNum(iRe,1);   % Reynolds Number...
                                                  % Orr-Sommerfeld Operator
                                                  %------------------------
% Orr-Sommerfeld Operator (linear base profile)...
if(linVel == 1)
linearSol(iRe,ik) = orrSommerfeldOperator ( k,Re,linearBaseVelocity,...
    laguerreGQWeights,transLaguerreFunc,ivis,polType,scalF,testCase,...
    spatioTempo);
end
% Orr-Sommerfeld Operator (parabolic base profile)...
if(parVel == 1)
parabolicSol(iRe,ik) = orrSommerfeldOperator ( k,Re,...
    parabolicBaseVelocity,laguerreGQWeights,transLaguerreFunc,ivis,...
    polType,scalF,testCase,spatioTempo);
end
% Orr-Sommerfeld Operator (Blasius base profile)...
if(blaVel == 1)
blasiusSol(iRe,ik) = orrSommerfeldOperator ( k,Re,...
    blasiusBaseVelocity,laguerreGQWeights,transLaguerreFunc,ivis,...
    polType,scalF,testCase,spatioTempo);
end
                                                      % Orr-Sommerfeld Post
                                                      %--------------------
plotEigenValues(linearSol(iRe,ik),parabolicSol(iRe,ik),blasiusSol(iRe,ik));

end

end 

elseif( testCase == 2 )
    
%--------------------------------------------------------------------------
% INCOMPRESSIBLE CHANNEL FLOW... (using Chebyshev basis)
%--------------------------------------------------------------------------
polType = 1;
                                                         % Quadrature nodes
                                                         %-----------------
% Chebyshev Quadrature Nodes...
[chebyGQNodes,chebyGQWeights] = makeChebyGQNodesWeights(order);
% Scaling the Chebyshev-Gauss Quadrature Nodes...
chebyGQNodes(:,1) = chebyGQNodes(:,1) ./ scalF;
% Plotting Chebyshev Gauss Quadrature...
plotChebyGaussQuadrature([8;16;24]);
                                               % Chebyshev polynomial bases
                                               %---------------------------
% Making the Chebyshev Polynomial basis and its derivatives...
chebyPol = makeChebyPol(order,chebyGQNodes);
chebyPol = makeChebyPolDerivs(chebyPol,chebyGQNodes);
% Making transformed Chebyshev Polynomial basis and its derivatives...
transChebyPol = makeTransChebyPol(chebyPol);
transChebyPol = makeTransChebyPolDerivs(chebyPol,transChebyPol);
                                            % Reducing order of polynomials
                                            %------------------------------
% Reducing order of matrices...
transChebyPol = reduceOrderOfBasis (transChebyPol,cutColumns);
                                           % Channel Base velocity profiles
                                           %-------------------------------
% Regular channel flow base velocity profile...
baseVelProf = makeChannelBaseFlow (chebyGQNodes, 3);
plotChannelFlowBaseProfiles(-1:0.01:1);

% Iterating over different test cases...
for iRe = 1 : size(ReNum,1)
    
for ik = 1 : size(waven,1)
    
% Print case number...
fprintf('Case %d out of %d!\n',(iRe-1)*size(waven,1)+ik,size(ReNum,1)*...
    size(waven,1));

% Orr-Sommerfeld Input...
k  = waven(ik,1);    % spatial wave number...
Re = ReNum(iRe,1);   % Reynolds Number...
                                                  % Orr-Sommerfeld Operator
                                                  %------------------------
% Orr-Sommerfeld Operator (linear base profile)...
channelSol(iRe,ik) = orrSommerfeldOperator ( k,Re,baseVelProf,...
    chebyGQWeights,transChebyPol,ivis,polType,scalF,testCase,...
    spatioTempo);
                                                      % Orr-Sommerfeld Post
                                                      %--------------------

end 
                                                        
end

end
