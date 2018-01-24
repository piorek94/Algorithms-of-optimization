function [x] = cor2rad(cor_vec)
%Function to convert coordinates in degrees[vector] to radians[scalar]
%   Detailed explanation goes here

x=deg2rad(cor_vec(1)+cor_vec(2)/60+cor_vec(3)/3600);

end

