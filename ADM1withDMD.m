clc , close all   
%Load ADM1 data 
load ../ADM1withDMD/ADM1DataONE.mat
% organize the data matrices X1 and X2
X1 = ADM1DataONE(:,2:179);
X2 = ADM1DataONE(:,3:180);

%Apply the DMD method and truncate at order 7
[Phi,omega,lambda,b,Xdmd] = DMD(X1,X2,7,1);

T=1:1:90;
Xr=real(Xdmd);
%plot original state varriables along with the DMD estimated and predicted
%ones

S_su   = ADM1DataONE(1,:) ; 
S_aa   = ADM1DataONE(2,:) ; 
S_fa   = ADM1DataONE(3,:) ;
S_va   = ADM1DataONE(4,:) ;
S_bu   = ADM1DataONE(5,:) ;
S_pro  = ADM1DataONE(6,:) ;
S_ac   = ADM1DataONE(7,:) ;
S_h2   = ADM1DataONE(8,:) ;
S_ch4  = ADM1DataONE(9,:) ;
S_ic   = ADM1DataONE(10,:);
S_in   = ADM1DataONE(11,:);
S_i    = ADM1DataONE(12,:);
S_cat  = ADM1DataONE(25,:);
S_an   = ADM1DataONE(26,:);
X_c    = ADM1DataONE(13,:);
X_ch   = ADM1DataONE(14,:);
X_pr   = ADM1DataONE(15,:);
X_li   = ADM1DataONE(16,:);
X_su   = ADM1DataONE(17,:);
X_aa   = ADM1DataONE(18,:);
X_fa   = ADM1DataONE(19,:);
X_c4   = ADM1DataONE(20,:);
X_pro  = ADM1DataONE(21,:);
X_ac   = ADM1DataONE(22,:);
X_h2   = ADM1DataONE(23,:);
X_i    = ADM1DataONE(24,:);
S_vam  = ADM1DataONE(27,:);
S_bum  = ADM1DataONE(28,:);
S_prom = ADM1DataONE(29,:);
S_acm  = ADM1DataONE(30,:);
S_hco3m= ADM1DataONE(31,:);
S_nh3  = ADM1DataONE(32,:);
h2     = ADM1DataONE(33,:);
ch4    = ADM1DataONE(34,:);
co2    = ADM1DataONE(35,:);
figure(1)
subplot(3,5,1);plot(S_su);title('S_{su}');xlabel('Time [d]', 'FontSize', 14);grid
hold on 
plot(Xr(1,:),'k--') ; 

subplot(3,5,2);plot(S_aa);title('S_{aa}');xlabel('Time [d]', 'FontSize', 14);grid
hold on 
plot(Xr(2,:),'k--')
subplot(3,5,3);plot(S_fa);title('S_{fa}');xlabel('Time [d]', 'FontSize', 14);grid
hold on 
plot(Xr(3,:),'k--')
subplot(3,5,4);plot(S_va);title('S_{va}');xlabel('Time [d]', 'FontSize', 14);grid
hold on 
plot(Xr(4,:),'k--')
subplot(3,5,5);plot(S_bu);title('S_{bu}');xlabel('Time [d]', 'FontSize', 14);grid
hold on 
plot(Xr(5,:),'k--')
subplot(3,5,6);plot(S_pro);title('S_{pro}');xlabel('Time [d]', 'FontSize', 14);grid
hold on 
plot(Xr(6,:),'k--')
subplot(3,5,7);plot(S_ac);title('S_{ac}');xlabel('Time [d]', 'FontSize', 14);grid
hold on 
plot(Xr(7,:),'k--')
subplot(3,5,8);plot(S_h2);title('S_{h2}');xlabel('Time [d]', 'FontSize', 14);grid
hold on 
plot(Xr(8,:),'k--')
subplot(3,5,9);plot(S_ch4);title('S_{ch4}');xlabel('Time [d]', 'FontSize', 14);grid
hold on 
plot(Xr(9,:),'k--')
subplot(3,5,10);plot(S_ic);title('S_{ic}');xlabel('Time [d]', 'FontSize', 14);grid
hold on 
plot(Xr(10,:),'k--')
subplot(3,5,11);plot(S_in);title('S_{in}');xlabel('Time [d]', 'FontSize', 14);grid
hold on 
plot(Xr(11,:),'k--')
subplot(3,5,12);plot(S_i);title('S_{i}');xlabel('Time [d]', 'FontSize', 14);grid
hold on 
plot(Xr(12,:),'k--')
subplot(3,5,13);plot(S_cat);title('S_{cat}');xlabel('Time [d]', 'FontSize', 14);grid
hold on 
plot(Xr(25,:),'k--')
subplot(3,5,14);plot(S_an);title('S_{an}');xlabel('Time [d]', 'FontSize', 14);grid
hold on 
plot(Xr(26,:),'k--')
subplot(3,5,15);plot(X_c);title('X_{c}');xlabel('Time [d]', 'FontSize', 14);grid
hold on 
plot(Xr(13,:),'k--')

figure(2)

subplot(3,5,1);plot(X_ch);title('X_{ch}');xlabel('Time [d]', 'FontSize', 10);grid
hold on 
plot(Xr(14,:),'k--')
subplot(3,5,2);plot(X_pr);title('X_{pr}');xlabel('Time [d]', 'FontSize', 10);grid
hold on 
plot(Xr(15,:),'k--')
subplot(3,5,3);plot(X_li);title('X_{li}');xlabel('Time [d]', 'FontSize', 10);grid
hold on 
plot(Xr(16,:),'k--')
subplot(3,5,4);plot(X_su);title('X_{su}');xlabel('Time [d]', 'FontSize', 10);grid
hold on 
plot(Xr(17,:),'k--')
subplot(3,5,5);plot(X_aa);title('X_{aa}');xlabel('Time [d]', 'FontSize', 10);grid
hold on 
plot(Xr(18,:),'k--')
subplot(3,5,6);plot(X_fa);title('X_{fa}');xlabel('Time [d]', 'FontSize', 10);grid
hold on 
plot(Xr(19,:),'k--')
subplot(3,5,7);plot(X_c4);title('X_{c4}');xlabel('Time [d]', 'FontSize', 10);grid
hold on 
plot(Xr(20,:),'k--')
subplot(3,5,8);plot(X_pro);title('X_{pro}');xlabel('Time [d]', 'FontSize', 10);grid
hold on 
plot(Xr(21,:),'k--')
subplot(3,5,9);plot(X_ac);title('X_{ac}');xlabel('Time [d]', 'FontSize', 10);grid
hold on 
plot(Xr(22,:),'k--')
subplot(3,5,10);plot(X_h2);title('X_{h2}');xlabel('Time [d]', 'FontSize', 10);grid
hold on 
plot(Xr(23,:),'k--')
subplot(3,5,11);plot(X_i);title('X_{i}');xlabel('Time [d]', 'FontSize', 10);grid
hold on 
plot(Xr(24,:),'k--')
subplot(3,5,12);plot(S_vam);title('S_{vam}');xlabel('Time [d]', 'FontSize', 10);grid
hold on 
plot(Xr(27,:),'k--')
subplot(3,5,13);plot(S_bum);title('S_{bum}');xlabel('Time [d]', 'FontSize', 10);grid
hold on 
plot(Xr(28,:),'k--')
subplot(3,5,14);plot(S_prom);title('S_{prom}');xlabel('Time [d]', 'FontSize', 10);grid
hold on 
plot(Xr(29,:),'k--')
subplot(3,5,15);plot(S_acm);title('S_{acm}');xlabel('Time [d]', 'FontSize', 10);grid
hold on 
plot(Xr(30,:),'k--')
figure(3)

subplot(3,5,1);plot(S_hco3m);title('S_{hco3m}');xlabel('Time [d]', 'FontSize', 10);grid on
hold on 
plot(Xr(31,:),'k--')
subplot(3,5,2);plot(S_nh3);title('S_{nh3}');xlabel('Time [d]', 'FontSize', 10);grid on
hold on 
plot(Xr(32,:),'k--')
subplot(3,5,3);plot(h2);title('h2');xlabel('Time [d]', 'FontSize', 10);grid on
hold on 
plot(Xr(33,:),'k--')
subplot(3,5,4);plot(ch4);title('ch4');xlabel('Time [d]', 'FontSize', 10);grid on
hold on 
plot(Xr(34,:),'k--')
subplot(3,5,5);plot(co2);title('co2');xlabel('Time [d]', 'FontSize', 10);grid on
hold on 
plot(Xr(35,:),'k--')

%% %%  Plot DMD spectrum
figure(6)
theta = (0:1:100)*2*pi/100;
plot(cos(theta),sin(theta),'k--') % plot unit circle
hold on, grid on
scatter(real(lambda),imag(lambda),'ok')
axis([-1.1 1.1 -1.1 1.1]);
%%





