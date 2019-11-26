function parabolicBaseVelocity = makeParabolicBaseVelocity (nodes)

    parabolicBaseVelocity = zeros(size(nodes,1),2);
    
    for i=1:size(nodes,1)
        if(nodes(i,1) <= 1)
            parabolicBaseVelocity(i,1) = 2*nodes(i,1) - nodes(i,1)^2;
            parabolicBaseVelocity(i,2) = -2;
        else
            parabolicBaseVelocity(i,1) = 1;
            parabolicBaseVelocity(i,2) = 0;
        end
    end

end