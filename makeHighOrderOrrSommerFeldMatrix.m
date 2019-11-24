function highOrderMatrix = makeHighOrderOrrSommerFeldMatrix ...
    (g,basisMat,weights)

    numHighOrder = size(g,2);
    highOrderMatrix = ...
        zeros(numHighOrder,size(basisMat,2),size(basisMat,2));
    gw = zeros(size(g,1));
    
    for numg=1:numHighOrder
       
        for k=1:size(g,1); gw(k,1) = g(k,numg)*weights(k,1); end
        highOrderMatrix(numg,:,:) = transpose(gw*basisMat)*basisMat;
        
    end

end