function blasiusBaseVelProfile = makeBlasiusBaseVelocity(nodes)

    opt = optimset('Display','off','TolFun',1E-20);
    F = fsolve(@(F) eval_boundary(F),[0,0,0.33],opt);
    [x,y] = ode45(@(x,y) [y(2); y(3); -1.0*y(1)*y(3)],[0 100],F);
    
    for i=1:size(y,1); if(y(i,2) > 0.99); etaT = x(i,1); break; end; end
    velProf(:,1) = x./etaT;
    velProf(:,2) = y(:,2);
    blasiusBaseVelProfile = interp1q(velProf(:,1),velProf(:,2),nodes);  
    
end

function [g] = eval_boundary(F)

    [x,y] = ode45(@(x,y) [y(2); y(3); -1.0*y(1)*y(3)],[0 100],F);
    f_start = y(1,1); 
    df_start = y(1,2); 
    df_end = y(end,2); 
    
    g = [f_start
        df_start
        df_end - 1];
        
end