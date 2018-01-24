function [x] = rad2cor(cor_sca)
%Function to convert coordinates in radians[scalar] to degrees[vector]
%   Detailed explanation goes here
deg_sca=rad2deg(cor_sca);
x(1)=floor(deg_sca);
x(2)=floor(mod(deg_sca,1)*60);
x(3)=floor(mod(mod(deg_sca,1)*60,1)*60);
end

