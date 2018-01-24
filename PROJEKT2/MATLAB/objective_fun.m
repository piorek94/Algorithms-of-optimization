function [ obj, grad ] = objective_fun( x )
global N D
%D - Delta
%x(1,:)=x1
%x(2,:)=x2
%x(3,:)=u
%objective function
obj=0;
for k=1:N
    obj = obj + x(1,k)^2 + x(2,k)^2 + 0.005*x(3,k)^2;
end
obj=obj*D;
%gradient
if nargout > 1
    grad = zeros(3,N);
    for k=1:N
        grad(1,k) = D*2*x(1,k);
        grad(2,k) = D*2*x(2,k);
        grad(3,k) = D*2*0.005*x(3,k);
    end
end
end

