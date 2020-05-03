figure(gen+1);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.2 0.2 0.6 0.6]);
legend_cell = {'Erroneous', 'Selecteds', 'Raw'};

scatter3(wY(:,1),wY(:,2),wY(:,3),'xr');
hold on;
scatter3(sY(:,1),sY(:,2),sY(:,3),'og');
s = scatter3(rY(:,1),rY(:,2),rY(:,3),'.b');
if au_flag
    auY = specs.aup.Y;
    scatter3(auY(:,1),auY(:,2),auY(:,3),'dm');
    legend_cell = [legend_cell, 'Golden'];
end
view(85,27);
title(['Real Parameters Gen: ' num2str(gen)]);
xlabel(naming.dimens{1});
ylabel(naming.dimens{2});
zlabel(naming.dimens{3});
legend(legend_cell, 'Location', 'NorthEast');
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