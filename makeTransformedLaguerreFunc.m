function laguerreFunctionTransformed = ...
    makeTransformedLaguerreFunc(laguerreFunc)

    laguerreFunctionTransformed = zeros(size(laguerreFunc,1),...
        size(laguerreFunc,2)-1);
    
    for i=1:size(laguerreFunc,1)
        for j=1:size(laguerreFunc,2)-1
            laguerreFunctionTransformed(i,j) = laguerreFunc(i,j) - ...
                laguerreFunc(i,j+1);
        end
    end
    
end