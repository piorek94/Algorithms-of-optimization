clear all;
%Initial point [-5 0 5 30]
Init=[-5 0 5 30];
D=1/50;
N=50;
sample(1,N)=0;
for i=1:N
    sample(i)=(i-1)*D;
end
width=1.2;
for j=1:size(Init,2)
    DONLP=load(strcat('../DANE/DONLP2_',num2str(Init(j)),'.txt'));
    LOQO=load(strcat('../DANE/LOQO_',num2str(Init(j)),'.txt'));
    MINOS=load(strcat('../DANE/MINOS_',num2str(Init(j)),'.txt'));
    SNOPT=load(strcat('../DANE/SNOPT_',num2str(Init(j)),'.txt'));
    load(strcat('../DANE/SQP_',num2str(Init(j)),'.mat'));
    load(strcat('../DANE/SQP_nongrad_',num2str(Init(j)),'.mat'));
    
    
    fig1 = figure('units','normalized','outerposition',[0 0 0.8 0.8]);
    subplot(3,1,1);
    stairs(sample,DONLP(3:52,2),'LineWidth',width)
    hold on
    stairs(sample,LOQO(3:52,2),'LineWidth',width)
    hold on
    stairs(sample,MINOS(3:52,2),'LineWidth',width)
    hold on
    stairs(sample,SNOPT(3:52,2),'LineWidth',width)
    hold on
    stairs(sample,x(1,:),'LineWidth',width)
    hold on
    stairs(sample,x_nongrad(1,:),'LineWidth',width)
    title(strcat('Compare results MATLAB vs AMPL, initial point (u,x_1,x_2)=(',num2str(Init(j)),',',num2str(Init(j)),',',num2str(Init(j)),')'));
    legend('AMPL-DONLP2','AMPL-LOQO','AMPL-MINOS','AMPL-SNOPT','MATLAB-SQP with gradient','MATLAB-SQP without gradient','Location','best');
    xlabel('k');
    ylabel('x_1(k)');
    grid on;
    subplot(3,1,2);
    stairs(sample,DONLP(53:102,2),'LineWidth',width)
    hold on
    stairs(sample,LOQO(53:102,2),'LineWidth',width)
    hold on
    stairs(sample,MINOS(53:102,2),'LineWidth',width)
    hold on
    stairs(sample,SNOPT(53:102,2),'LineWidth',width)
    hold on
    stairs(sample,x(2,:),'LineWidth',width)
    hold on
    stairs(sample,x_nongrad(2,:),'LineWidth',width)
    legend('AMPL-DONLP2','AMPL-LOQO','AMPL-MINOS','AMPL-SNOPT','MATLAB-SQP with gradient','MATLAB-SQP without gradient','Location','best');
    xlabel('k');
    ylabel('x_2(k)');
    grid on;
    subplot(3,1,3);
    stairs(sample,DONLP(103:152,2),'LineWidth',width)
    hold on
    stairs(sample,LOQO(103:152,2),'LineWidth',width)
    hold on
    stairs(sample,MINOS(103:152,2),'LineWidth',width)
    hold on
    stairs(sample,SNOPT(103:152,2),'LineWidth',width)
    hold on
    stairs(sample,x(3,:),'LineWidth',width)
    hold on
    stairs(sample,x_nongrad(3,:),'LineWidth',width)
    legend('AMPL-DONLP2','AMPL-LOQO','AMPL-MINOS','AMPL-SNOPT','MATLAB-SQP with gradient','MATLAB-SQP without gradient','Location','best');
    xlabel('k');
    ylabel('u(k)');
    grid on;
    print(fig1, strcat('../Obrazy/compare_MATLAB_AMPL_x0=',num2str(Init(j))),'-dpng','-r300');
    OUT(2*j-1,1)=fval;
    OUT(2*j,1)=output.iterations;
    OUT(2*j-1,2)=fval_nongrad;
    OUT(2*j,2)=output_nongrad.iterations;
    OUT(2*j-1,3)=MINOS(2,2);
    OUT(2*j,3)=MINOS(1,2);
    OUT(2*j-1,4)=DONLP(2,2);
    OUT(2*j,4)=DONLP(1,2);
    OUT(2*j-1,5)=LOQO(2,2);
    OUT(2*j,5)=LOQO(1,2);
    OUT(2*j-1,6)=SNOPT(2,2);
    OUT(2*j,6)=SNOPT(1,2);    
end
%save('../DANE/compare_MATLAB_AMPL.mat','OUT');
%{
% k=1;
% if k==1
%     initial_point=0;
%     fval=0.18138;
%     x1=[0  0           10 -0.0629806   20 -0.0963901   30 -0.19095     40 -0.234026
%         1 -0.02        11 -0.0630735   21 -0.10479     31 -0.19935     41 -0.23435
%         2 -0.0343984   12 -0.0633235   22 -0.113766    32 -0.207046    42 -0.234469
%         3 -0.0446064   13 -0.063963    23 -0.12319     33 -0.21391     43 -0.234454
%         4 -0.0516904   14 -0.0652541   24 -0.132934    34 -0.219814    44 -0.234358
%         5 -0.0564589   15 -0.0675101   25 -0.14287     35 -0.22463     45 -0.234218
%         6 -0.0595289   16 -0.0711101   26 -0.15287     36 -0.22823     46 -0.234063
%         7 -0.0613759   17 -0.0759261   27 -0.162806    37 -0.230703    47 -0.233908
%         8 -0.0623736   18 -0.0818301   28 -0.17255     38 -0.232352    48 -0.233764
%         9 -0.0628235   19 -0.0886941   29 -0.181974    39 -0.233403    49 -0.233636];
%     x2=[0 -1             10 -0.00464418    20 -0.42          30 -0.42       40 -0.0161741
%         1 -0.71992       11 -0.0125041     21 -0.4488        31 -0.3848     41 -0.00594734
%         2 -0.510402      12 -0.0319751     22 -0.4712        32 -0.3432     42  0.000733649
%         3 -0.3542        13 -0.064551      23 -0.4872        33 -0.2952     43  0.00479993
%         4 -0.238425      14 -0.1128        24 -0.4968        34 -0.2408     44  0.00696813
%         5 -0.153496      15 -0.18          25 -0.5           35 -0.18       45  0.00779833
%         6 -0.0923529     16 -0.2408        26 -0.4968        36 -0.123662   46  0.00774092
%         7 -0.0498816     17 -0.2952        27 -0.4872        37 -0.0824292  47  0.00717374
%         8 -0.0224977     18 -0.3432        28 -0.4712        38 -0.0525415  48  0.00643186
%         9 -0.00785346    19 -0.3848        29 -0.4488        39 -0.031168   49  0.0058363];
%     u=[ 0 13.004       10 -0.39764     20 -1.86        30  1.34        40  0.495162
%         1  9.756       11 -0.986052    21 -1.5688      31  1.6952      41  0.328102
%         2  7.29972     12 -1.66077     22 -1.2712      32  2.0568      42  0.204048
%         3  5.43452     13 -2.477       23 -0.9672      33  2.4248      43  0.11321
%         4  4.00802     14 -3.4728      24 -0.6568      34  2.7992      44  0.0484783
%         5  2.90367     15 -3.22        25 -0.34        35  2.63689     45  0.0049275
%         6  2.03121     16 -2.9608      26 -0.0168      36  1.93799     46 -0.0206178
%         7  1.31931     17 -2.6952      27  0.3128      37  1.41195     47 -0.0299205
%         8  0.709715    18 -2.4232      28  0.6488      38  1.01613     48 -0.0233463
%         9  0.152611    19 -2.1448      29  0.9912      39  0.718531    49  0];
% end
% num=size(u,1);
% for i=2:2:size(u,2)
%     x(1,((i/2)-1)*num+1:(i/2)*num) = x1(:,i);
%     x(2,((i/2)-1)*num+1:(i/2)*num) = x2(:,i);
%     x(3,((i/2)-1)*num+1:(i/2)*num) = u(:,i);
% end
% 
% sample(1,50)=0;
% for i=1:size(x,2)
%     sample(i)=(i-1);
% end
% 
% fig1 = figure('units','normalized','outerposition',[0 0 0.8 0.8]);
% subplot(3,1,1); 
% stairs(sample,x(1,:));
% title({'AMPL - solver MINOS',strcat('Plot of x_1(k), J(x,u)=', num2str(fval))});
% xlabel('k'); 
% ylabel('x_1(k)');
% grid on;
% subplot(3,1,2); 
% stairs(sample,x(2,:));
% title(strcat('Plot of x_2(k), J(x,u)=', num2str(fval)));
% xlabel('k');
% ylabel('x_2(k)');
% grid on;
% subplot(3,1,3);
% stairs(sample,x(3,:));
% title(strcat('Plot of u(k), J(x,u)=', num2str(fval)));
% xlabel('k');
% ylabel('u(k)');
% grid on;
% print(fig1, strcat('../Obrazy/AMPL_plots_x0=',num2str(initial_point)),'-dpng','-r600');
%}