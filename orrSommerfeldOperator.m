function [eigf,eigv] = orrSommerfeldOperator ...
    (wavenum,Re,u,d2udy2,weights,sij,s1ij,s2ij)

% Function to calculate the Eigen Values for Orr-Sommerfeld Operator
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    % Making the g matrix...
    g(:,1) = ones(size(u,1));
    g(:,2) = u;
    g(:,3) = d2udy2;
    
    % Making high order matrices....
    M1 = makeHighOrderOrrSommerFeldMatrix(g,sij,weights);
    M2 = makeHighOrderOrrSommerFeldMatrix(g(:,1:2),s1ij,weights);
    M3 = makeHighOrderOrrSommerFeldMatrix(g(:,1),s2ij,weights);
    
    % Boundary matrix...
    boundMat = zeros(size(sij,2),size(sij,2));
    for i=1:size(sij,2); boundMat(1,i) = s2ij(1,i)*sij(1,i); end
    
    % Setting up matrices for eigenvalue problem...
    A1 = wavenum^2.*M1(1,:,:) + M2(1,:,:);
    A2 = -M2(2,:,:) - wavenum^2.*M1(2,:,:) - M1(3,:,:) - ...
        (1/(1i*Re*wavenum)).*(M3(1,:,:) + boundMat + ...
        2*wavenum^2.*M2(1,:,:) + wavenum^4.*M1(1,:,:));
    
    % Forcing no-slip boundary condition...
    
    % Calculating the eigenvalues and eigen functions...
    [eigf,eigv] = eig(A2,A1);
    
end