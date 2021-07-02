%%
figure()
set(gcf,'position',[400,400,1200,720])

subplot(1,2,1)
versor_origin = 0.4;
versor_camera = 0.2;
origin_axis = {'O';'X';'Y';'Z'};
plane_y = 0.3;       % y image plane width
plane_z = 0.25;       % z image plane height
p1_ = out.p(:, 1:3);
p2_ = out.p(:, 4:6);

%% plot point

grid on; 
quiver3([O(1);O(1);O(1)],[O(2);O(2);O(2)],[O(3);O(3);O(3)],[versor_origin;0;0],[0;versor_origin;0],[0;0;versor_origin]) % world frame
 
x_pose = out.pose(:, 1);
y_pose = out.pose(:, 2);
z_pose = out.pose(:, 3);
ang = out.pose(:, 4:6); 

for i = 1:length(out.pose)
    %% subplot 1
    cla(subplot(1,2,1));
    grid on; 
    axis equal
    
    hold on
    quiver3([O(1);O(1);O(1)],[O(2);O(2);O(2)],[O(3);O(3);O(3)],[versor_origin;0;0],[0;versor_origin;0],[0;0;versor_origin]) % world frame
    text([O(1),O(1)+versor_origin,O(1),O(1)], [O(2),O(2),O(2)+versor_origin,O(2)], [O(3),O(3),O(3),O(3)+versor_origin], origin_axis)
    
    rotation = rot(ang(i,1),ang(i,2),ang(i,3));
    quiver3([x_pose(i);x_pose(i);x_pose(i)],[y_pose(i);y_pose(i);y_pose(i)],[z_pose(i);z_pose(i);z_pose(i)],rotation(1,:)'/4,rotation(2,:)'/4,rotation(3,:)'/4) % camera frame
    
    scatter3(p1_(i,1), p1_(i,2), p1_(i,3));
    scatter3(p2_(i,1), p2_(i,2), p2_(i,3));
    
    %% subplot 2
    cla(subplot(1,2,2));
    hold on
    scatter(ref1(1),ref1(2),'red','x');
    scatter(ref2(1),ref2(2),'red','x');
    grid on
    rectangle('Position', [-plane_y -plane_z 2*plane_y 2*plane_z], 'EdgeColor', 'r')
    xlim([-0.45, 0.45])
    ylim([-0.18, 0.18])
    axis equal
    take_photo(out.proj1(i,:))
    take_photo(out.proj2(i,:))
    pause(0.015);
    F(i) = getframe(gcf);
end

take_photo(out.proj1)
take_photo(out.proj2)

video = VideoWriter('IBVS.avi', 'Uncompressed AVI');
open(video);
writeVideo(video, F);
close(video);
