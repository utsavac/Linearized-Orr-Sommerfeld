function [chebyPol1,chebyPol2] = makeChebyPolDerivs(chebyPol,xx);

    chebyPol1 = zeros(size(chebyPol,1),size(chebyPol,2));
    chebyPol2 = zeros(size(chebyPol,1),size(chebyPol,2));
    
    % First derivative...
    for i=1:size(chebyPol,1)
        chebyPol1(i,2) = 1;
        for j=3:size(chebyPol,2)
            chebyPol1(i,j) = 2*chebyPol(i,j-1) + ...
                2*xx(i,1)*chebyPol1(i,j-1) - ...
                chebyPol1(i,j-2);
        end
    end
    
    % Second derivative...
    for i=1:size(chebyPol,1)
        for j=3:size(chebyPol,2)
            chebyPol2(i,j) = 4*chebyPol1(i,j-1) + ...
                2*xx(i,1)*chebyPol2(i,j-1) - ...
                chebyPol2(i,j-2);
        end
    end
    
end