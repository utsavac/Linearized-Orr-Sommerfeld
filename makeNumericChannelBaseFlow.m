function [steadyU,y] = makeChannelBaseFlow ...
    (numNodes,bodyForceType,initPlugVel,dt,tt,visc,bc)

    intnumNodes = numNodes - 2;
    DD          = zeros(intnumNodes,intnumNodes);
    U           = initPlugVel*ones(intnumNodes,1);
    dy          = 2/(numNodes-1);
    steadyU     = zeros(numNodes,1);
    y           = -1:dy:1;
    
    if(initPlugVel == 123)
        for i=1:size(U,1)
            if(i<size(U,1)/2)
                U(i,1) = 0;
            else
                U(i,1) = 1;
            end
        end
    end
    
    % Making body force vector...
    switch(bodyForceType)
        case 0
            fx = zeros(intnumNodes,1);
            fx(1,1) = visc*bc(1)/dy^2;
            fx(end,1) = visc*bc(2)/dy^2;
    end           
    
    % Making central differencing matrix...
    for i=1:intnumNodes
        DD(i,i) = -2/dy^2;
        if(i~=1 && i~=intnumNodes)
            DD(i,i-1) = 1/dy^2;
            DD(i,i+1) = 1/dy^2;
        elseif(i==1)
            DD(i,i+1) = 1/dy^2;
        else
            DD(i,i-1) = 1/dy^2;
        end
    end
    
    % Making boundary matrix...
    
    % Iterative temporal solver...
    t = 0;
    while(t<tt)
        t = t + dt;
        mat1 = ( eye(intnumNodes) + 0.5*dt*visc.*DD );
        mat2 = ( eye(intnumNodes) - 0.5*dt*visc.*DD );
        newU = inv(mat2)*(mat1*U + dt.*fx);
        U = newU;
    end
    
    % Applying boundary condition and plotting...
    steadyU(1,1) = bc(1);
    steadyU(end,1) = bc(2);
    steadyU(2:end-1,1)=U;
    if(size(y,1)==1); y=transpose(y); end
    
end