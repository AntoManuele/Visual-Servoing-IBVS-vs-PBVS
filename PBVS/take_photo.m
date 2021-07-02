function [] = take_photo(projection)

hold on
for i = 1:size(projection)
    scatter(projection(i,1), projection(i,2),'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5);
end

% xlim([min(projection(:,1))-0.05, max(projection(:,1))+0.05]);
% ylim([min(projection(:,2))-0.05, max(projection(:,2))+0.05]);


hold off;

end