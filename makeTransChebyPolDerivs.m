function transChebyPol = makeTransChebyPolDerivs(chebyPol,transChebyPol)
    
    for ideriv = 1 : 4
        for k = 1 : size(transChebyPol,2)
            for i = 1 : size(transChebyPol,3)
                transChebyPol(ideriv+1,k,i) = chebyPol(ideriv+1,k,i+2) -...
                    chebyPol(ideriv+1,k,i);
            end
        end
    end

end