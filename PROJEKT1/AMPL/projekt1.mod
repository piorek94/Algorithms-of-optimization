param n;					#number of given points
param d{1..n};				#vector of distances between POI and given points
param m = 3;				#three parts of coordinates: deg, min, sec
param lat_deg{1..n, 1..m};	#matrix of latitude of given points
param lon_deg{1..n, 1..m};	#matrix of longitude of given points
param pi = 4*atan(1);		#pi
param r = 6371;				#radius of earth [km]

#POI cooridnates [rad]
var m_lat_rad;
var m_lon_rad; 

#POI cooridanets [deg min sec]
var m_lat_deg = (m_lat_rad*180/pi) div 1;
var m_lon_deg = (m_lon_rad*180/pi) div 1;
var m_lat_min = (((m_lat_rad*180/pi) mod 1) * 60) div 1;
var m_lon_min = (((m_lon_rad*180/pi) mod 1) * 60) div 1;
var m_lat_sec = ((((m_lat_rad*180/pi) mod 1) * 60) mod 1) * 60 div 1;
var m_lon_sec = ((((m_lon_rad*180/pi) mod 1) * 60) mod 1) * 60 div 1;
var m_lat_cor{j in 1..m} = if j=1 then m_lat_deg else if j=2 then m_lat_min else m_lat_sec;
var m_lon_cor{j in 1..m} = if j=1 then m_lon_deg else if j=2 then m_lon_min else m_lon_sec;

#declared parameters - lon and lat in radians
param lat_rad{j in 1..n} = (sum{i in 1..m} lat_deg[j,i]/(60^(i-1)))*pi/180;
param lon_rad{j in 1..n} = (sum{i in 1..m} lon_deg[j,i]/(60^(i-1)))*pi/180;

#declared variable
var a{j in 1..n} = (sin((m_lat_rad-lat_rad[j])/2))^2+cos(m_lat_rad)*cos(lat_rad[j])*(sin((m_lon_rad-lon_rad[j])/2))^2;
var differ{j in 1..n} = d[j] - r*2*asin(sqrt(a[j]));
minimize totalsquareError: sum{j in 1..n} (differ[j])^2;

