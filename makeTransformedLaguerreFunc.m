function laguerreFunctionTransformed = ...
    makeTransformedLaguerreFunc(laguerreFunc,nodes,type)

    if(type == 1)
    
        laguerreFunctionTransformed = zeros(5,size(laguerreFunc,2),...
        size(laguerreFunc,3)-1);
    
    for i=1:size(laguerreFunc,2)
        for j=1:size(laguerreFunc,3)-1
            laguerreFunctionTransformed(1,i,j) = laguerreFunc(1,i,j) - ...
                laguerreFunc(1,i,j+1);
        end
    end
    
    elseif(type == 2)
        
    if(size(nodes,1)==1); nodes = transpose(nodes); end

    laguerreFunctionTransformed = zeros(5,size(laguerreFunc,2),...
        size(laguerreFunc,3)-1);
    
    for i=1:size(laguerreFunc,2)
        for j=1:size(laguerreFunc,3)-1
            laguerreFunctionTransformed(1,i,j) = laguerreFunc(1,i,j) - ...
                laguerreFunc(1,i,j+1) - nodes(i,1)*exp(-nodes(i,1)/2);
        end
    end
    
    end
    
end