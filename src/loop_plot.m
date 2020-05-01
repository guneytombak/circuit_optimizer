figure(gen+1);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2 0.2 0.6 0.6]);

scatter3(wY(:,1),wY(:,2),wY(:,3),'xr');
hold on;
scatter3(sY(:,1),sY(:,2),sY(:,3),'og');
s = scatter3(rY(:,1),rY(:,2),rY(:,3),'.b');
view(85,27);
title(['Real Parameters Gen: ' num2str(gen)]);
xlabel(naming.dimens{1});
ylabel(naming.dimens{2});
zlabel(naming.dimens{3});
legend('Erroneous', 'Selecteds', 'Raw', 'Location', 'NorthEast');
hold off;

if dataTipFlag

    for k = 1:specs.noXYU(2)
        s.DataTipTemplate.DataTipRows(k).Label = naming.output(k);
    end    
    for k = 1:specs.noXYU(3)
        row = dataTipTextRow(naming.unused(k),gU(n,:,k));
        s.DataTipTemplate.DataTipRows(noXYU(2)+k) = row;
    end
    for k = 1:specs.noXYU(1)
        row = dataTipTextRow(naming.input(k),gX(n,:,k));
        s.DataTipTemplate.DataTipRows(noXYU(2)+noXYU(3)+k) = row;
    end

end

pause(pause_duration);

if gen > numClose
    close(gen - numClose)
end