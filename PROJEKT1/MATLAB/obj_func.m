function [F,J] = obj_func(x,lon_rad,lat_rad,dist,point_num,grad_sym)
%   objective function and jakobian
%   Detailed explanation goes here
%   Objective function values at x
digits(500);
F=zeros(point_num,1);
R=6371;         %earth's radius [km]
for i=1:point_num
    a=(sin((lat_rad(i)-x(2))/2))^2+cos(x(2))*cos(lat_rad(i))*(sin((lon_rad(i)-x(1))/2))^2;
    %c=2*atan2(sqrt(a),sqrt(1-a)); %similar implementation-this same result
    c=2*asin(sqrt(a));
    F(i) = (R*c - dist(i));
end
% Jacobian of the function evaluated at x    
if nargout >1   %Two output arguments
    lon=x(1);
    lat=x(2);
    J=eval(grad_sym);

%analitical jackobian
%{
    for i=1:point_num
        h=(sin((lat_rad(i)-x(2))/2))^2+cos(x(2))*cos(lat_rad(i))*(sin((lon_rad(i)-x(1))/2))^2;
        mn=R/(sqrt(h-h^2)+(10^-100));
        dx1=-0.5*cos(x(2))*cos(lat_rad(i))*sin(lon_rad(i)-x(1));
        dx2=-0.5*sin(lat_rad(i)-x(2))-sin(x(2))*cos(lat_rad(i))*(sin((lon_rad(i)-x(1))/2))^2;
        J(i,:)=mn*[dx1,dx2];
    end
%}
end

end


