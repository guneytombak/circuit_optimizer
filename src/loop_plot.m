fig_no = gen + 1;

if fig_flag

figure(fig_no);
set(gcf, 'Units', 'Normalized', 'OuterPosition', fig_pos_vec);
legend_cell = {'Erroneous', 'Selecteds', 'Raw'};

scatter3(wY(:,1),wY(:,2),wY(:,3),'xr');
hold on;
scatter3(sY(:,1),sY(:,2),sY(:,3),'og');
s = scatter3(rY(:,1),rY(:,2),rY(:,3),'.b');
if specs.au_flag
    auY = specs.aup.Y;
    scatter3(auY(:,1),auY(:,2),auY(:,3),'dm');
    legend_cell = [legend_cell, 'Golden'];
end

view(AZ,EL);

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
        row = dataTipTextRow(naming.unused(k),rU(:,k));
        s.DataTipTemplate.DataTipRows(specs.noXYU(2)+k) = row;
    end
    for k = 1:specs.noXYU(1)
        row = dataTipTextRow(naming.input(k),rX(:,k));
        s.DataTipTemplate.DataTipRows(specs.noXYU(2)+specs.noXYU(3)+k)=row;
    end

end

pause(pause_duration);

end

if (fig_no > act_fig_no) && ishandle(fig_no - act_fig_no)
    close(fig_no - act_fig_no)
end