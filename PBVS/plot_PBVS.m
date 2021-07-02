%%
figure()
set(gcf,'position',[400,400,1200,720])

subplot(1,2,1)
versor_origin = 0.4;
versor_camera = 0.2;
origin_axis = {'O';'X';'Y';'Z'};
plane_y = 0.25;       % y image plane width
plane_z = 0.18;       % z image plane height
p1_ = out.p;


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
  
    
     %% subplot 2
    cla(subplot(1,2,2));
    hold on
    grid on
    axis([0 100 min(min(out.error)) max(max(out.error))])
    plot(out.error(1:i, :))
    title('error')
    pause(0.0055);
    F(i) = getframe(gcf);
end

video = VideoWriter('PBVS.avi', 'Uncompressed AVI');
open(video);
writeVideo(video, F);
close(video);



