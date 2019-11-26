function plotBaseVelProfiles(yy,numPlots)

    color{1} = '-ok'; color{2} = '-dr'; color{3} = '-sb'; color{4} = '-*g';

    if(size(yy,1) == 1); yy=transpose(yy); end
    p = zeros(size(yy,1),2*numPlots);
    switch(numPlots)
        case 1
            p(:,1:2) = makeLinearBaseVelocity (yy);
        case 2
            p(:,1:2) = makeLinearBaseVelocity (yy);
            p(:,3:4) = makeParabolicBaseVelocity (yy);
        case 3
            p(:,1:2) = makeLinearBaseVelocity (yy);
            p(:,3:4) = makeParabolicBaseVelocity (yy);
            p(:,5) = makeBlasiusBaseVelocity (yy);
    end
            
    figure;
    for i=1:numPlots
        plot( p(:,2*i-1),yy,...
            color{i},...
            'linewidth',2,...
            'markerindices',1:100:size(yy,1) ); hold on;
    end
    xlabel('$u$',...
        'fontsize',16,...
        'interpreter','latex' );
    ylabel('$y$',...
        'fontsize',16,...
        'interpreter','latex' );
    xlim([0 1.1]);
    legend('Linear Profile',...
        'Parabolic Profile',...
        'Blasius Profile',...
        'Numerical Profile' );
end