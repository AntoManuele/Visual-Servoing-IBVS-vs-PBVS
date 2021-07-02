clear, clc, close all; 

%% parameters
% frames
O = [0; 0; 0];        % world origin frame
C = [0.2; 0.3; 0.6];  % camera origin frame
versor_origin = 0.4;
versor_camera = 0.2;
origin_axis = {'O';'X';'Y';'Z'};
camera_axis = {'oc','zc','xc','yc'};
plane_y = 0.25;       % y image plane width
plane_z = 0.18;       % z image plane height

f = 0.15;             % focal lenght
p = [1.0; 0.15; 0.8]; % point's position (x,y,z) in world frame
d = C - O;            % distance between camera and world frame
ang = [pi/2 0.0 pi/2];  

[x_proj, y_proj] = proj(p, ang, d, f); % computes the projection of the point in the image plane


%% plot point

grid on; 
quiver3([O(1);O(1);O(1)],[O(2);O(2);O(2)],[O(3);O(3);O(3)],[versor_origin;0;0],[0;versor_origin;0],[0;0;versor_origin]) % world frame
text([O(1),O(1)+versor_origin,O(1),O(1)], [O(2),O(2),O(2)+versor_origin,O(2)], [O(3),O(3),O(3),O(3)+versor_origin], origin_axis)

axis equal
hold on;
quiver3([C(1);C(1);C(1)],[C(2);C(2);C(2)],[C(3);C(3);C(3)],[versor_camera;0;0],[0;versor_camera;0],[0;0;versor_camera]) % camera frame
text([C(1),C(1)+versor_camera,C(1),C(1)], [C(2),C(2),C(2)+versor_camera,C(2)], [C(3),C(3),C(3),C(3)+versor_camera], camera_axis)

scatter3(p(1),p(2),p(3)); 
scatter3(linspace(C(1),p(1)), linspace(C(2),p(2)), linspace(C(3),p(3)),' . ')

% create image plane
x = linspace(C(1)+f,C(1)+f,20);
y = linspace(C(2)-plane_y,C(2)+plane_y,20);
z = linspace(C(3)-plane_z,C(3)+plane_z,20);

[X, Y] = meshgrid(x,y);
Z = meshgrid(z);
s = surf(X,Y,Z,'FaceAlpha',0.3);
s.EdgeColor = 'none';


%% projection of an object

w = 0.1;   % width of the object
h = 0.2;   % height of the object
% x_surf = linspace(p(1)-w, p(1)+w, 3);
% y_surf = linspace(p(2)-w, p(2)+w, 3);
% z_surf = linspace(p(3)-h, p(3)+h, 3);

x_surf = linspace(1.4, 1.8, 4);
y_surf = linspace(0.1, 0.3, 4);
z_surf = linspace(0.5, 0.7, 4);

[X_surf, Y_surf] = meshgrid(x_surf,y_surf);
Z_surf = meshgrid(z_surf);

% points of the surface

% 
% points = [x_surf             x_surf                         x_surf;
%           y_surf [y_surf(2) y_surf(3) y_surf(1)] [y_surf(3) y_surf(1) y_surf(2)]; 
%           z_surf             z_surf                         z_surf]
%       

points = zeros(length(x_surf)*length(y_surf),3);
count = 1;
for i=1:length(x_surf)
    for j=1:length(y_surf)
        points(count,:) = [X_surf(i,j) Y_surf(i,j) Z_surf(i,j)];
        count = count + 1;
    end
end

% projection of the points in the image plane
proj_points = zeros(length(points), 2);
for i = 1:length(points)
    [proj_points(i,1), proj_points(i,2)] = proj(points(i, :)', ang, d, f);
end


% plot object
figure()
subplot(1,2,1)
grid on;
quiver3([O(1);O(1);O(1)],[O(2);O(2);O(2)],[O(3);O(3);O(3)],[versor_origin;0;0],[0;versor_origin;0],[0;0;versor_origin]) % origin frame
text([O(1),O(1)+versor_origin,O(1),O(1)], [O(2),O(2),O(2)+versor_origin,O(2)], [O(3),O(3),O(3),O(3)+versor_origin], origin_axis)

axis equal
hold on;
quiver3([C(1);C(1);C(1)],[C(2);C(2);C(2)],[C(3);C(3);C(3)],[versor_camera;0;0],[0;versor_camera;0],[0;0;versor_camera]) % camera frame
text([C(1),C(1)+versor_camera,C(1),C(1)], [C(2),C(2),C(2)+versor_camera,C(2)], [C(3),C(3),C(3),C(3)+versor_camera], camera_axis)

s = surf(X,Y,Z,'FaceAlpha',0.3);
s.EdgeColor = 'none';
s = surf(X_surf,Y_surf,Z_surf,'Facealpha',1);

for i = 1:length(points)
    scatter3(linspace(C(1),points(i,1)), linspace(C(2),points(i,2)), linspace(C(3),points(i,3)),' . ')
end

hold off;

%
subplot(1,2,2)
 xlim([min(proj_points(:,1))-0.05, max(proj_points(:,1))+0.05]);
 ylim([min(proj_points(:,2))-0.05, max(proj_points(:,2))+0.05]);
take_photo(proj_points);


