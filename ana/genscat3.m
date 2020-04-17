function [] = genscat3(data,N)

version_controlling;

gX = data.arch.X;
gY = data.arch.Y;
gU = data.arch.U;

naming = data.naming;
specs = data.specs;

noXYU = specs.noXYU;

legend_str = cell(1,length(N));

for ind_N = 1:length(N)
    
    n = N(ind_N);
    
    legend_str{ind_N} = ['gen: ' num2str(n)];

    s = scatter3(gY(n,:,1),gY(n,:,2),gY(n,:,3),'.');
    title(['Real Parameters N = ' num2str(specs.popSize)]);
    xlabel(naming.dimens{1});
    ylabel(naming.dimens{2});
    zlabel(naming.dimens{3});
    hold on;

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
end

legend(legend_str,'Location','NorthEast');
