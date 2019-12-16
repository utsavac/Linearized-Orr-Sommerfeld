function laguerreFunc = makeLaguerreFunc(laguerrePol,xx)

    if(size(xx,1) ==1); xx=transpose(xx); end  
    laguerreFunc = zeros(5,size(laguerrePol,2),size(laguerrePol,3));
    
    for i=1:size(laguerrePol,2)
        for j=1:size(laguerrePol,3)
            laguerreFunc(1,i,j) = exp(-xx(i,1)/2)*laguerrePol(1,i,j);
        end
    end
    
end