function blasiusBaseVelProfile = makeBlasiusBaseVelocity(nodes,newSol)
    
    if(newSol == 1)
        opt = optimset('Display','off','TolFun',1E-20);
        F = fsolve(@(F) eval_boundary(F),[0,0,0.33],opt);
        [x,y] = ode45(@(x,y) [y(2); y(3); -1.0*y(1)*y(3)],[0 1400],F);
        blasiusVel(:,1) = x;
        blasiusVel(:,2:4) = y;
    else
        load('blasiusVel.mat');
    end
    
    % Determing boundary     
    for i=1:size(blasiusVel,1)
        if(blasiusVel(i,3) > 0.99); etaT = blasiusVel(i,1); break; end
    end
    velProf(:,1) = blasiusVel(:,1)./etaT;
    velProf(:,2) = blasiusVel(:,3);
    velProf(:,3) = -1.0.*blasiusVel(:,2).*blasiusVel(:,4);
    blasiusBaseVelProfile(:,1) = interp1q(velProf(:,1),velProf(:,2),nodes);  
    blasiusBaseVelProfile(:,2) = etaT^2 .* ...
        interp1q(blasiusVel(:,1),velProf(:,3),nodes.*etaT);   
    %blasiusBaseVelProdile(:,2) = scalF^2.*blasiusBaseVelProdile(:,2);
end

function [g] = eval_boundary(F)
    [x,y] = ode45(@(x,y) [y(2); y(3); -1.0*y(1)*y(3)],[0 700],F);
    f_start = y(1,1); 
    df_start = y(1,2); 
    df_end = y(end,2); 
    
    g = [f_start
        df_start
        df_end - 1];        
end