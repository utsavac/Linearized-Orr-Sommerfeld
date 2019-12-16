function solU = sortSol (sol)

    [A,idx] = sort(sol.imag,'descend');
    clearvars A;
    
    for i=1:size(sol.imag,1)
        
        solU.real(i,1)      = sol.real(idx(i,1),1);
        solU.imag(i,1)      = sol.imag(idx(i,1),1);
        solU.ikcreal(i,1)   = sol.ikcreal(idx(i,1),1);
        solU.ikcimag(i,1)   = sol.ikcimag(idx(i,1),1);
        solU.modes(:,i)     = sol.modes(:,idx(i,1));
        solU.Rey            = sol.Rey;
        solU.waveNum        = sol.waveNum;
        solU.velU(:,i)      = sol.velU(:,idx(i,1));
        solU.velV(:,i)      = sol.velV(:,idx(i,1));
            
    end
    
end