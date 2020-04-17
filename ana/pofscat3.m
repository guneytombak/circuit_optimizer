function [] = pofscat3(data)

version_controlling;

arch = data.arch;
specs = data.specs;
naming = data.naming;
noXYU = specs.noXYU;
noGen = specs.noGen;
popSize = specs.popSize;


gX = arch.X;
gY = arch.Y;
gU = arch.U;

aX = reshape(gX,[noGen*popSize noXYU(1)]);
aY = reshape(gY,[noGen*popSize noXYU(2)]);
aU = reshape(gU,[noGen*popSize noXYU(3)]);

aXYU = [aX aY aU];

XYU = unique(aXYU,'rows');

X = XYU(:,1:noXYU(1));
Y = XYU(:,(noXYU(1)+1):(noXYU(1)+noXYU(2)));
U = XYU(:,(noXYU(1)+noXYU(2)+1):end);

R = (~specs.highY).*Y - specs.highY.*Y;

[Ni,~] = size(R);
fL = false(Ni,1);
    
for k = 1:Ni
    fL(k) = (~any(all(R(k,:)' > R')));
end
    
sX = X(fL,:);
sY = Y(fL,:);
sU = U(fL,:);
    

	s = scatter3(sY(:,1),sY(:,2),sY(:,3),'.');
    title(['All Pareto Optimal Front N = ' num2str(length(sX))]);
    xlabel(naming.dimens{1});
    ylabel(naming.dimens{2});
    zlabel(naming.dimens{3});
    hold on;

    if dataTipFlag

        for k = 1:specs.noXYU(2)
            s.DataTipTemplate.DataTipRows(k).Label = naming.output(k);
        end    
        for k = 1:specs.noXYU(3)
            row = dataTipTextRow(naming.unused(k),sU(:,k));
            s.DataTipTemplate.DataTipRows(noXYU(2)+k) = row;
        end
        for k = 1:specs.noXYU(1)
            row = dataTipTextRow(naming.input(k),sX(:,k));
            s.DataTipTemplate.DataTipRows(noXYU(2)+noXYU(3)+k) = row;
        end

    end

end

