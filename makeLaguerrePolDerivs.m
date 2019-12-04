function [laguerrePol1,laguerrePol2] = ...
    makeLaguerrePolDerivs(laguerrePol,nodes)

    laguerrePol1 = zeros(size(laguerrePol,1),size(laguerrePol,2));
    laguerrePol2 = zeros(size(laguerrePol,1),size(laguerrePol,2));
    
    % First Derivative...
    for k=1:size(laguerrePol,1)
        laguerrePol1(k,2) = -1;
        for i=3:size(laguerrePol,2)
            if(i>2)
                laguerrePol1(k,i) = ( (2*(i-1)-nodes(k,1)-1)*...
                    laguerrePol1(k,i-1) - laguerrePol(k,i-1) - ...
                    (i-2)*laguerrePol1(k,i-2) ) / (i-1);
            end
        end
    end
    
    % Second Derivative...
    for k=1:size(laguerrePol,1)
        for i=1:size(laguerrePol,2)
            if(i>2)
                laguerrePol2(k,i) = ( (2*(i-1)-nodes(k,1)-1)*...
                    laguerrePol2(k,i-1) - 2*laguerrePol1(k,i-1) - ...
                    (i-2)*laguerrePol2(k,i-2) ) / (i-1);
            end
        end
    end

end