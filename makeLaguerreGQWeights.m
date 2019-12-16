function laguerreGQWeights = makeLaguerreGQWeights(order,laguerreFunc)

    laguerreGQWeights = zeros(order+1,1);
    
    for i=1:order+1
        laguerreGQWeights(i,1) = 1 / ...
            ((order+1)*laguerreFunc(1,i,order+1)^2);
    end
    
end