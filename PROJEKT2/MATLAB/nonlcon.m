function [ c, ceq ] = nonlcon( x )
global N x10 x20 D
%D - Delta
%x(1,:)=x1
%x(2,:)=x2
%x(3,:)=u
% equality constraints
ceq(1)=x(1,1)-x10;
ceq(2)=x(2,1)-x20;
for k=1:N-1
    ceq(k*2+1)=x(1,k+1)-x(1,k)-D*x(2,k);
    ceq(k*2+2)=x(2,k+1)-x(2,k)-D*(x(3,k)-x(2,k));
end
% nonlinear inequality constraints
for i=1:N
    c(i)=x(2,i)-(8*((i-1)*D-0.5)^2-0.5);
end
end

