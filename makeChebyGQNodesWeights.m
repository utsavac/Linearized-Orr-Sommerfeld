function [chebyGQNodes,chebyGQWeights] = makeChebyGQNodesWeights(order)

    chebyGQNodes   = zeros(order+1,1);
    chebyGQWeights = zeros(order+1,1);
    for i=1:order+1
        chebyGQNodes(i,1)   = -cos((2*(i-1)+1)*pi/(2*order+2));
        chebyGQWeights(i,1) = pi/(order+1);
    end
    chebyGQNodes(1,1) = -1;
    chebyGQNodes(end,1) = 1;

end