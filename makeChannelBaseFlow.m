function velProf = makeChannelBaseFlow (nodes,ind)

    velProf = zeros(size(nodes,1),2);
    
    % Different velocity profiles...
    switch(ind)
        
        case 1
            velProf(:,1) = -nodes(:,1).^2 + 1;
            velProf(:,2) = -2;
        case 2
            velProf(:,1) = 0.5.*nodes(:,1).^3 + 0.5.*nodes(:,1);
            velProf(:,2) = 3.*nodes(:,1);
        case 3
            velProf(:,1) = tanh(2.*nodes(:,1));
            velProf(:,2) = -8.*tanh(2.*nodes(:,1)).*...
                (sech(2.*nodes(:,1))).^2;
            
    end
            

end