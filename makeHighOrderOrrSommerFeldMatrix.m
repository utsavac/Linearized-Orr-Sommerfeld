function weakSolMatrices = makeHighOrderOrrSommerFeldMatrix ...
    (g,basisMat,basisMat1,basisMat2,weights,num)

    weakSolMatrices = zeros(num,size(basisMat,2),size(basisMat,2));
    gw              = zeros(size(g,1),1);
    
    % Making Orr-Sommerfeld matrices for eigenvalue problem...
    for numg=1:num
       
        basisMatT = zeros(size(basisMat,1),size(basisMat,2));
        switch(numg)
            case 1 % 
                for k=1:size(g,1)
                    gw(k,1) = g(k,1)*weights(k,1); 
                    basisMatT(k,:) = basisMat(k,:) .* gw(k,1);
                end
                weakSolMatrices(numg,:,:) = transpose(basisMatT)*basisMat;
            case 2 %
                for k=1:size(g,1) 
                    gw(k,1) = g(k,2)*weights(k,1);
                    basisMatT(k,:) = basisMat(k,:) .* gw(k,1);
                end
                weakSolMatrices(numg,:,:) = transpose(basisMatT)*basisMat;
            case 3 %
                for k=1:size(g,1)
                    gw(k,1) = g(k,3)*weights(k,1); 
                    basisMatT(k,:) = basisMat(k,:) .* gw(k,1);
                end
                weakSolMatrices(numg,:,:) = transpose(basisMatT)*basisMat;
            case 4 %
                for k=1:size(g,1)
                    gw(k,1) = g(k,1)*weights(k,1);
                    basisMatT(k,:) = basisMat1(k,:) .* gw(k,1);
                end
                weakSolMatrices(numg,:,:) = transpose(basisMatT)*basisMat1;
            case 5 %
                for k=1:size(g,1)
                    gw(k,1) = g(k,2)*weights(k,1); 
                    basisMatT(k,:) = basisMat2(k,:) .* gw(k,1);
                end
                weakSolMatrices(numg,:,:) = transpose(basisMatT)*basisMat;
            case 6 % 
                for k=1:size(g,1)
                    gw(k,1) = g(k,1)*weights(k,1); 
                    basisMatT(k,:) = basisMat2(k,:) .* gw(k,1);
                end
                weakSolMatrices(numg,:,:) = transpose(basisMatT)*basisMat2;
            case 7 %
                gw(1,1) = g(1,1)*weights(1,1);
                weakSolMatrices(numg,:,:) = ...
                    transpose(gw(1,1)*basisMat2(1,:))*basisMat1(1,:);
        end    
        
    end

end