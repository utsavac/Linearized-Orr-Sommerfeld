function basisFunc = reduceOrderOfBasis ...
    (basisFunc,cutColumns)

    if(cutColumns > 0)        
        initColumns = size(basisFunc,3);
        basisFunc(:,:,initColumns-cutColumns+1:initColumns) = [];  
    end

end