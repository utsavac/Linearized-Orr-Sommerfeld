function linearBaseVelocity = makeLinearBaseVelocity (nodes)

    linearBaseVelocity = zeros(size(nodes,1),1);
    
    for i=1:size(nodes,1)
        if(nodes(i,1) <= 1)
            linearBaseVelocity(i,1) = nodes(i,1);
        else
            linearBaseVelocity(i,1) = 1;
        end
    end

end