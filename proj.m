function [x_proj, y_proj] = proj(p,ang,d,f)

Twc = [rot(ang(1),ang(2),ang(3))   d;
                zeros(1,3)         1];

p_cam = Twc^-1 * [p;1];   % point's position in camera frame

P = diag([f,f,1]) * [eye(3), zeros(3,1)]; % camera projection matrix

p_tilde = P*p_cam;       
x_proj = p_tilde(1)/p_cam(3);
y_proj = p_tilde(2)/p_cam(3);

end