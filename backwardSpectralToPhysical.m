function physical = backwardSpectralToPhysical(spectral,basisFunc)

    physical = zeros(size(spectral,1),1);
    for i=1:size(spectral,1)
        for j=1:size(spectral,2)
            physical(i,1) = physical(i,1) + spectral(i,j)*basisFunc(i,j);
        end
    end           

end