%%AMO, Projket II zestaw AK, nr 2, Arkadiusz Piorkowski 259079
clear all;
global N D x10 x20
%pass data
N=50;               %number of samples
t0=0;               %start time
tf=1;               %end time
D=(tf-t0)/N;        %Delta
x10=0;              %x1(0)
x20=-1;             %x2(0)
%Initial point for x1,x2 and u
initial_point=0;
%x(1,:)=x1
%x(2,:)=x2
%x(3,:)=u
x0 = initial_point*ones(3,N);
%vector of samples 0..N-1
for i=1:N
    sample(i)=(i-1);
end
%optimization options
options = optimoptions('fmincon','SpecifyObjectiveGradient',false,...
    'Display','iter','StepTolerance',1e-6,'Algorithm','sqp',...
    'MaxIterations',500,'MaxFunctionEvaluations',30000);
%optimization
[x, fval,exitflag,output] = fmincon(@(x) objective_fun(x),x0,[],[],[],[],[],[],@(x) nonlcon(x), options);

%plots
fig1 = figure('units','normalized','outerposition',[0 0 0.8 0.8]);
subplot(3,1,1); 
stairs(sample,x(1,:));
title({'MATLAB - Algorithm SQP',strcat('Plot of x_1(k), J(x,u)=', num2str(fval))});
xlabel('k'); 
ylabel('x_1(k)');
grid on;
subplot(3,1,2); 
stairs(sample,x(2,:));
title(strcat('Plot of x_2(k), J(x,u)=', num2str(fval)));
xlabel('k');
ylabel('x_2(k)');
grid on;
subplot(3,1,3);
stairs(sample,x(3,:));
title(strcat('Plot of u(k), J(x,u)=', num2str(fval)));
xlabel('k');
ylabel('u(k)');
grid on;
%print(fig1, strcat('../Obrazy/MATLAB_plots_x0=',num2str(initial_point)),'-dpng','-r600');
%save(strcat('../DANE/SQP_',num2str(initial_point),'.mat'),'x','fval','output');