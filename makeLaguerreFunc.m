function laguerreFunc = makeLaguerreFunc(laguerrePol,xx)

    if(size(xx,1) ==1); xx=transpose(xx); end  
    laguerreFunc = zeros(size(laguerrePol,1),size(laguerrePol,2));
    
    for i=1:size(laguerrePol,1)
        for j=1:size(laguerrePol,2)
            laguerreFunc(i,j) = exp(-xx(i,1)/2)*laguerrePol(i,j);
        end
    end
    
end