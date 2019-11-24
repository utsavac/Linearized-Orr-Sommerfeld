function [laguerreFunc1,laguerreFunc2] = makeLaguerreFuncDerivs(...
    laguerrePol,laguerrePol1,laguerrePol2,laguerreGQNodes)

    laguerreFunc1 = zeros(size(laguerreGQNodes,1),size(laguerrePol,2));
    laguerreFunc2 = zeros(size(laguerreGQNodes,1),size(laguerrePol,2));
    
    % First Derivative...
    for k=1:size(laguerreGQNodes,1)
        for i=1:size(laguerrePol,2)
            laguerreFunc1(k,i) = ( laguerrePol1(k,i) - ...
                laguerrePol(k,i)/2 ) * exp(-laguerreGQNodes(k,1)/2);
        end
    end
    
    % Second Derivative...    
    for k=1:size(laguerreGQNodes,1)
        for i=1:size(laguerrePol,2)
            laguerreFunc2(k,i) = ( laguerrePol2(k,i) - ...
                laguerrePol1(k,i) - laguerrePol(k,i)/4 ) * ...
                exp(-laguerreGQNodes(k,1)/2);
        end
    end

end