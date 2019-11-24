function laguerreGQNodes = makeLaguerreGQNodes(order)

    A = zeros(order+1,order+1);
    
    for i=1:order+1
        if(i~=1 && i~=order+1)
            A(i,i-1) = -(i-1);
            A(i,i) = 2*(i-1)+1;
            A(i,i+1) = -i;
        elseif(i==1)
            A(1,1) = 1; A(1,2) = -1;
        else
            A(order+1,order) = -order;
            A(order+1,order+1) = order;
        end
    end
    laguerreGQNodes=eig(A);

end