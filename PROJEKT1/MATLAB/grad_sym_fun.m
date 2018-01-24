function [grad_sym] = grad_sym_fun(lon_rad,lat_rad,dist,point_num)
%   symbolic function to compute gradient
%   Detailed explanation goes here
digits(500);
syms lat lon;
R=6371;         %earth's radius [km]
for i=1:point_num
    a=(sin((lat_rad(i)-lat)/2))^2+cos(lat)*cos(lat_rad(i))*(sin((lon_rad(i)-lon)/2))^2;
    %c=2*atan2(sqrt(a),sqrt(1-a));%similar implementation-this same result
    c=2*asin(sqrt(a));
    F(i) = (R*c - dist(i));

end

for i=1:point_num    
     grad_sym(i,:)=gradient(F(i), [lon,lat]);
end

