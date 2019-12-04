function chebyGQNodes = makeChebyGQNodes(order)

    chebyGQNodes = zeros(order+1,1);
    for i=1:order+1
        chebyGQNodes(i,1) = cos((i-1)*pi/order);
    end

end