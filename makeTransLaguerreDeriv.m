function transLaguerreFunc = makeTransLaguerreDeriv...
    (laguerreFunc,transLaguerreFunc,nodes,type)
    
    if(type == 1)
    
    for i=1:size(laguerreFunc,2)
        for j=1:size(laguerreFunc,2)-1
            for k=2:5
                transLaguerreFunc(k,i,j) = laguerreFunc(k,i,j) - ...
                    laguerreFunc(k,i,j+1);
            end
        end
    end
    
    elseif(type == 2)
    
    for i=1:size(laguerreFunc,2)
        for j=1:size(laguerreFunc,2)-1
            
            transLaguerreFunc(2,i,j) = laguerreFunc(2,i,j) - ...
                laguerreFunc(2,i,j+1) + exp(-nodes(i,1)/2) * ...
                ( -1 + (nodes(i,1)/2) );
            
            transLaguerreFunc(3,i,j) = laguerreFunc(3,i,j) - ...
                laguerreFunc(3,i,j+1) + exp(-nodes(i,1)/2) * ...
                ( 1 - (nodes(i,1)/4) );
            
            transLaguerreFunc(4,i,j) = laguerreFunc(4,i,j) - ...
                laguerreFunc(4,i,j+1) + exp(-nodes(i,1)/2) * ...
                ( -(3/4) + (nodes(i,1)/8) );
            
            transLaguerreFunc(5,i,j) = laguerreFunc(5,i,j) - ...
                laguerreFunc(5,i,j+1) + exp(-nodes(i,1)/2) * ...
                ( (1/2) - (nodes(i,1)/16) );
        end
    end
    
    end
    
end