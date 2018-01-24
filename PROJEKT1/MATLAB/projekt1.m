%%AMO, Projket I zewstaw AK, nr 4
clear variables;
digits(500);
%--------------------------------------------------------------------------
%pass data
%stations coordinates in degrees[deg,min,sec]
%longitude
lon_deg = [ 22  37  23;
            22  30  47;
            22  44  00];
%latitude
lat_deg = [ 52  45  54;
            52  40  27;
            52  43  37];
%distance to stations[km]
dist = [4;
        13.4;
        4.1];
 
%--------------------------------------------------------------------------    
%checking number of points    
if length(lon_deg(:,1)) == length(dist(:,1)) && length(dist(:,1)) == length(lat_deg(:,1))
    point_num = length(lat_deg(:,1));
else
    disp('Invaild parameters - stop execution');
    return;
end

%--------------------------------------------------------------------------
%stations coordinates in radians
lon_rad = zeros(point_num,1);
lat_rad = zeros(point_num,1);
for i=1:point_num
    %longitude
    lon_rad(i) = cor2rad(lon_deg(i,:));
    %latitude
    lat_rad(i) = cor2rad(lat_deg(i,:));
end

%--------------------------------------------------------------------------
%lsqnonlin - optmalization
%initial point - POI coorinates in degrees [longitude;latitude]
%point 0,0
x0_deg = [ 0 0 0;
           0 0 0];
%point A + 1''
% x0_deg = [ 22  37  24;
%            52  45  55];
%point B + 1''
% x0_deg = [ 22  30  48;
%            52  40  28];
%point C + 1''
% x0_deg = [ 22  44  01;
%            52  43  38];
%average point (A+B+C)/3
% x0_deg = [ 22  37  23;
%            52  43  19];
%initial point - POI coorinates in radians [longitude;latitude]
x0_rad = [ cor2rad(x0_deg(1,:)) ; cor2rad(x0_deg(2,:))];

%computing gradient as symbolic function(Jacobian)
grad_sym=grad_sym_fun(lon_rad,lat_rad,dist,point_num);

%options
%{
Algorithm 'trust-region-reflective' or 'levenberg-marquardt' 
'SpecifyObjectiveGradient',false(default)
'FunctionTolerance',1e-6(default)
'OptimalityTolerance',1e-6(default)
'StepTolerance',1e-6(defalut)
'MaxIterations',400(defalut)
LM algorithm uses an optimality tolerance (stopping criterion) of 1e-4 times FunctionTolerance and does not use OptimalityTolerance
%}
options = optimoptions('lsqnonlin','Algorithm','levenberg-marquardt','Display','iter-detailed',...
    'SpecifyObjectiveGradient',true,'FunctionTolerance',1e-6,'StepTolerance',1e-6);


[x_optim_rad,resnorm,residual,exitflag,output,lambda,jacobian] = lsqnonlin(@(x) obj_func(x,lon_rad,lat_rad,dist,point_num,grad_sym),x0_rad,[],[],options);

%calculate geographic coordinates
x_optim_deg = zeros(2,3);
for i=1:2
    x_optim_deg(i,:)=rad2cor(x_optim_rad(i));
end

fprintf('Users coordinates: \nlongitude: ');disp(x_optim_deg(1,:));
fprintf('latitude: '); disp(x_optim_deg(2,:));


