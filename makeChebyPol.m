function chebyPol = makeChebyPol(order,xx)

    if(size(xx,1) == 1 ); xx=transpose(xx); end
    
    sizex         = size(xx,1);   
    chebyPol      = zeros(sizex,order);
    
    for i=1:sizex
        chebyPol(i,1) = 1;
        chebyPol(i,2) = xx(i,1);
        for j=3:order+1
            chebyPol(i,j) = 2*xx(i,1)*chebyPol(i,j-1) - ...
                chebyPol(i,j-2);
        end
    end

end