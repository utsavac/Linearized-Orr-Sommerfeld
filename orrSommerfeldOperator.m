function sol = orrSommerfeldOperator ...
    (wavenum,Re,u,d2udy2,weights,sij,s1ij,s2ij)

% Function to calculate the Eigen Values for Orr-Sommerfeld Operator
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    % Making the g matrix...
    g = zeros(size(u,1),3);
    g(:,1) = 1;
    g(:,2) = u;
    g(:,3) = d2udy2;
    
    % Making high order matrices....
    weakSolMatrices = ...
        makeHighOrderOrrSommerFeldMatrix(g,sij,s1ij,s2ij,weights,7);
    
    % Setting up matrices for eigenvalue problem...
    A1(:,:) = wavenum^2.*weakSolMatrices(1,:,:) + weakSolMatrices(4,:,:);
    A2(:,:) = weakSolMatrices(5,:,:) - wavenum^2.*...
        weakSolMatrices(2,:,:) - weakSolMatrices(3,:,:) - ...
        (1/(1i*Re*wavenum)).* ( weakSolMatrices(6,:,:) + ...
        weakSolMatrices(7,:,:) + 2*wavenum^2.*weakSolMatrices(4,:,:)  + ...
        wavenum^4.*weakSolMatrices(1,:,:) );
    
    % Forcing no-slip boundary condition...
    
    % Calculating the eigenvalues and eigen functions and sorting...
    [eigf,eigv] = eig(A2,A1);
    eigenvalues = imag(diag(eigv));
    sol = zeros(size(eigenvalues,1)+1,size(eigenvalues,1));
    for i=1:size(eigenvalues,1)
        sol(i,1) = eigenvalues(i,1);
        sol(i,2:size(eigenvalues,1)+1) = eigf(:,i);
    end
    sol = sortrows(sol,1,'descend');
    
end