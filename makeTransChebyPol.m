function transChebyPol = makeTransChebyPol(chebyPol)

    transChebyPol = zeros(5,size(chebyPol,2),size(chebyPol,3)-2);
    
    for k = 1 : size(chebyPol,2)
        for i = 1 : size(chebyPol,3) - 2
            transChebyPol(1,k,i) = chebyPol(1,k,i+2) - chebyPol(1,k,i);
        end
    end

end