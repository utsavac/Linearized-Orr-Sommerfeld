function [laguerrePol1,laguerrePol2] = makeLaguerrePolDerivs(laguerrePol)

    laguerrePol1 = zeros(size(laguerrePol,1),size(laguerrePol,2));
    laguerrePol2 = zeros(size(laguerrePol,1),size(laguerrePol,2));
    
    % First Derivative...
    for k=1:size(laguerrePol,1)
        for i=2:size(laguerrePol,2)
            if(i>1)
                laguerrePol1(k,i) = -1*laguerrePol(k,i-1);
            end
        end
    end
    
    % Second Derivative...
    for k=1:size(laguerrePol,1)
        for i=1:size(laguerrePol,2)
            if(i>2)
                laguerrePol2(k,i) = laguerrePol(k,i-2)^2;
            end
        end
    end

end