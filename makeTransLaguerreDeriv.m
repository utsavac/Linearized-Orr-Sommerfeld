function [transLaguerreFunc1,transLaguerreFunc2] = ...
    makeTransLaguerreDeriv(laguerreFunc1,laguerreFunc2)

    transLaguerreFunc1 = zeros(size(laguerreFunc1,1),...
        size(laguerreFunc1,2)-1);
    transLaguerreFunc2 = zeros(size(laguerreFunc2,1),...
        size(laguerreFunc2,2)-1);
    
    for i=1:size(laguerreFunc1,1)
        for j=1:size(laguerreFunc1,2)-1
            transLaguerreFunc1(i,j) = laguerreFunc1(i,j) - ...
                laguerreFunc1(i,j+1);
            transLaguerreFunc2(i,j) = laguerreFunc2(i,j) - ...
                laguerreFunc2(i,j+1);
        end
    end
    
end