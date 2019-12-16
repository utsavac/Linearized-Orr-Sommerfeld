function laguerrePol = makeLaguerrePol (order,xx)

    if(size(xx,1) == 1 ); xx=transpose(xx); end

    sizex            = size(xx,1);   
    laguerrePol      = zeros(5,sizex,order);
    
    for i=1:sizex
        laguerrePol(1,i,1) = 1;
        laguerrePol(1,i,2) = 1-xx(i,1);
        for j=3:order+1
            laguerrePol(1,i,j) = ( (2*(j-2)+1-xx(i,1))*...
                laguerrePol(1,i,j-1) - ...
                (j-2)*laguerrePol(1,i,j-2) ) / (j-1);
        end
    end

end