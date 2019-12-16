function chebyPol = makeChebyPolDerivs(chebyPol,nodes);
    
    if(size(nodes,1)==1); nodes=transpose(nodes); end
    
    % First 4 derivatives...
    for ideriv = 1 : 4
        for k=1:size(chebyPol,2)
            
            if(ideriv==1); chebyPol(2,k,2) = 1; end
            for i=3:size(chebyPol,3)
                chebyPol(ideriv+1,k,i) = ...
                    2*nodes(k,1)*chebyPol(ideriv+1,k,i-1) + ...
                    2*ideriv*chebyPol(ideriv,k,i-1) - ...
                    chebyPol(ideriv+1,k,i-2);
            end
            
        end
    end
                

    
end