function solU = orrSommerfeldOperator (wavenum,Re,u,weights,sij,ivis,...
    polType,scalF,testCase,spatioTempo)

% Function to calculate the Eigen Values for Orr-Sommerfeld Operator
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    % Making the g matrix...
    g = zeros(size(u,1),3);
    g(:,1) = 1;
    g(:,2) = u(:,1);
    g(:,3) = u(:,2);
    
    % Scaling...
    s1ij=zeros(size(sij,1),size(sij,2),size(sij,3));
    for ideriv = 2 : 5
        s1ij(1,:,:) = sij(1,:,:);
        s1ij(ideriv,:,:) = scalF^(ideriv-1).*sij(ideriv,:,:);
    end
    
    % Making high order matrices....
    weakSolMatrices = makeHighOrderOrrSommerFeldMatrix(g,s1ij,weights,6);
    
    if(spatioTempo == 1)
    
    % Setting up matrices for eigenvalue problem...
    A1(:,:) = wavenum^2.*weakSolMatrices(1,:,:) - weakSolMatrices(4,:,:);
    if(ivis == 1)                                                  % Viscid
                                                                   %------- 
        A2(:,:) = weakSolMatrices(5,:,:) - wavenum^2.*...
            weakSolMatrices(2,:,:) - weakSolMatrices(3,:,:) + ...
            (1i/(Re*wavenum)).* ( weakSolMatrices(6,:,:) - 2*wavenum^2.*...
            weakSolMatrices(4,:,:) + wavenum^4.*weakSolMatrices(1,:,:) );
    else                                                        % In-viscid
                                                                %----------
        A2(:,:) = weakSolMatrices(5,:,:) - wavenum^2.*...
            weakSolMatrices(2,:,:) - weakSolMatrices(3,:,:);
    end
    
    % No-slip (Depending on basis function and flow type)...
    if(ivis == 1)
        if(polType == 1 || testCase == 2)
            A1(1,:) = 0;
            A2(1,:) = s1ij(2,1,:);
            if(testCase == 2)
                A1(end,:) = 0;
                A2(end,:) = s1ij(2,end,:);
            end
        end
    end
    
    % Calculating the eigenvalues and eigen functions...
    [eigf,eigv] = eig(A2,-A1);
    eigenvalues = diag(eigv);
    
    elseif(spatioTempo == 2)
        
    A1(:,:) = (1i/Re).*weakSolMatrices(1,:,:);
    A2(:,:) = wavenum.*weakSolMatrices(1,:,:) - weakSolMatrices(2,:,:);
    A3(:,:) = -(2*1i/Re).*weakSolMatrices(4,:,:);
    A4(:,:) = weakSolMatrices(5,:,:) - ...
        wavenum.*weakSolMatrices(4,:,:) - weakSolMatrices(3,:,:);
    A5(:,:) = (1i/Re).*weakSolMatrices(6,:,:);
    
    % Calculating the eigenvalues and eigen functions...
    [eigf,eigv] = polyeig(A5,A4,A3,A2,A1);
    eigenvalues = diag(eigv);
    
    end    
 
    % Making a structured solution...
    sol.real      = real(eigenvalues(:,1));
    sol.imag      = imag(eigenvalues(:,1));
    sol.ikcreal   = real(-1i.*wavenum.*eigenvalues(:,1));
    sol.ikcimag   = imag(-1i.*wavenum.*eigenvalues(:,1));
    sol.modes     = eigf;
    sol.Rey       = Re;
    sol.waveNum   = wavenum;
    sol.velU      = backwardSpectralToPhysical(sol.modes,s1ij(2,:,:),1);
    sol.velV      = backwardSpectralToPhysical(sol.modes,s1ij(2,:,:),2);
    
    % Sorting solution...
    solU = sortSol (sol);
    
end