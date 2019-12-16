function physical = backwardSpectralToPhysical(spectral,basisFunc,veldir)

    basisFunc1(:,:) = basisFunc(1,:,:);
    
    physical = zeros(size(basisFunc1,1),size(spectral,2));
    for i = 1:size(spectral,2)
        if(veldir == 1)
            physical(:,i) = basisFunc1 * real(spectral(:,i));
        elseif(veldir == 2)
            physical(:,i) = basisFunc1 * imag(spectral(:,i));
        end
    end

end