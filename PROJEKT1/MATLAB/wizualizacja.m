clear;
x_lat=0:5e-3:pi/2;
x_lon=0:5e-3:pi;
grad_sym=1;
lon_deg = [ 22  37  23;
            22  30  47;
            22  44  00];
lat_deg = [ 52  45  54;
            52  40  27;
            52  43  37];
dist = [4;
        13.4;
        4.1];  
    point_num=3;
lon_rad = zeros(point_num,1);
lat_rad = zeros(point_num,1);
for i=1:point_num
    %longitude
    lon_rad(i) = cor2rad(lon_deg(i,:));
    %latitude
    lat_rad(i) = cor2rad(lat_deg(i,:));
end

for i=1:length(x_lat)
    for j=1:length(x_lon)
        x=[x_lon(j),x_lat(i)];
        F=obj_func(x,lon_rad,lat_rad,dist,point_num,grad_sym);
        F_2=F.^2;
        z(i,j)=sum(F_2);
    end
end
minMatrix = min(z(:));
[row,col] = find(z==minMatrix);
lat=rad2cor(x_lat(row));
lon=rad2cor(x_lon(col));
figure

meshc(x_lon,x_lat,z)
xlabel('lon');
ylabel('lat');
zlabel('dist');

