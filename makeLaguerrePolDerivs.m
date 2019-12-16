function laguerrePol = makeLaguerrePolDerivs(laguerrePol,nodes)
    
    % First four derivatives...
    for ideriv = 1:4
        for k = 1:size(laguerrePol,2)
            for i=1:size(laguerrePol,3)
                
                if(ideriv==1)
                    laguerrePol(ideriv+1,k,2) = -1;
                    offset = 2;
                else
                    offset = ideriv;
                end
                
                if(i>offset)
                    laguerrePol(ideriv+1,k,i) = ( (2*(i-1)-nodes(k,1)-1)*...
                        laguerrePol(ideriv+1,k,i-1) - ...
                        ideriv*laguerrePol(ideriv,k,i-1) -...
                        (i-2)*laguerrePol(ideriv+1,k,i-2) ) / (i-1);
                end
            end
        end
    end
    
end