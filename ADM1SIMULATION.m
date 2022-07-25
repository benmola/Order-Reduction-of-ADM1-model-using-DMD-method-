%**********************************************************************
%**********************************************************************
%Programme qui simule la digestion Anaérobie représentée par le 
%modèle ADM1,comprenant 35 équations différentielles et 19 processus 
%de dégradation
%Il appelle une autre fonction par la commande ode23s qui servira pour la
%résolution des équations différentieeles contenues dans cette fonction là
%**********************************************************************
%**********************************************************************
function ADM1SIMULATION()
% One can change the following values (> values or < values)
%===========================================================
%Tmax   = 2592000;% secondes équivalents à 30jours de simulation
Tmax   = 31104000;% secondes équivalents à 360jours de simulation
%Tmax   = 15552000;% secondes équivalents à 180jours de simulation
% Tmax   = 7776000 ,%secondes équivalents à 90 jours de simulation
    
nbplot =  1000   ;      %Nombre de points
%nbplot = 500   ;      %Nombre de points
%prec   = 1e-4  ;      %Précision
 prec   = 1e-8  ;      %Précision


%**********************************************************************
%Paramètres cinétiques 
%**********************************************************************
k_m_su    = 30  ;
Ks_su     = 0.5 ;
k_m_aa    = 50  ;
Ks_aa     = 0.3 ;
k_m_fa    = 6   ;
Ks_fa     = 0.4 ;
k_m_c4    = 20  ;
Ks_c4     = 0.2 ;       
k_m_pro   = 13  ;
Ks_pro    = 0.1 ;           
k_m_ac    = 8   ;
Ks_ac     = 0.15;
k_m_h2    = 35  ;
Ks_h2     = 7e-6;
k_dec_Xsu = 0.02;
k_dec_Xaa = 0.02;
k_dec_Xfa = 0.02;
k_dec_Xc4 = 0.02;
k_dec_Xpro= 0.02;
k_dec_Xac = 0.02;
k_dec_Xh2 = 0.02;
Y_su      = 0.1  ;
Y_aa      = 0.08 ;
Y_c4      = 0.06 ;
Y_fa      = 0.06 ;
Y_pro     = 0.04 ;
Y_ac      = 0.05 ;
Y_h2      = 0.06 ;


%**********************************************************
%Paramètres relatifs aux fonctions d'inhibitions
%**********************************************************
phul_aa   = 5.5;
phul_ac   = 7  ;
phul_h2   = 6  ;
phll_aa   = 4  ;
phll_ac   = 6  ;
phll_h2   = 5  ;
KI_h2_fa  = 5e-6  ;
KI_h2_c4  = 1e-5  ;
Ks_in     = 1e-4  ;
KI_h2_pro = 3.5e-6;
KI_NH3_ac = 0.0018;


%**********************************************************************
%Paramètres de l'hydrolyse et de la désintégration
%**********************************************************************
k_dis     = 0.5 ;
k_hyd_ch  = 10  ;
k_hyd_pr  = 10  ;
k_hyd_li  = 10  ;



%****************************************************************
%Coefficients stoechiométrique
%****************************************************************
f_xI_xc   = 0.2  ;
f_fa_li   = 0.95 ;
f_va_aa   = 0.23 ;
f_bu_su   = 0.13 ;
f_bu_aa   = 0.26 ;
f_pro_su  = 0.27 ;
f_pro_aa  = 0.05 ;
f_ac_su   = 0.41 ;
f_ac_aa   = 0.4  ;
f_h2_su   = 0.19 ;
f_h2_aa   = 0.06 ;
f_ch_xc   = 0.2  ;
f_pr_xc   = 0.2  ;
f_li_xc   = 0.3  ;
f_si_xc   = 0.1  ;


%*******************************************************************
%Les teneurs en azote 
%*******************************************************************
Nbac      = 0.08/14  ;
Naa       = 0.007    ;
Nxc       = 0.0376/14;
NSi       = 0.06/14  ;
NXpr      = 0.007    ;
NXi       = 0.06/14  ;


%*******************************************************************
%Les teneurs en carbone  
%*******************************************************************
C_Si   =  0.03   ;
C_Xc   =  0.02786;
C_Xch  =  0.0313 ;
C_Xpr  =  0.03   ;
C_Xli  =  0.022  ;
C_Xi   =  0.03   ;
C_Ssu  =  0.0313 ;
C_Saa  =  0.03   ;
C_Sva  =  0.024  ;
C_Sfa  =  0.0217 ;
C_Sbu  =  0.025  ;
C_Spro =  0.0268 ;
C_Sac  =  0.0313 ;
C_Sch4 =  0.0156 ;
Cbac   =  0.0313 ;


%****************************************************************
%Entrées du bioréacteur
%****************************************************************
S_su_in   = 0.01  ;
S_aa_in   = 0.001 ;
S_fa_in   = 0.001 ;
S_va_in   = 0.001 ;
S_bu_in   = 0.001 ;
S_pro_in  = 0.001 ;
S_ac_in   = 0.001 ;
S_h2_in   = 1.0e-8;
S_ch4_in  = 1.0e-5;
S_ic_in   = 0.04  ;
S_in_in   = 0.01  ;
S_i_in    = 0.02  ;
X_c_in    = 2     ;
X_ch_in   = 5     ;
X_pr_in   = 20    ;
X_li_in   = 5     ;
X_su_in   = 0     ;
X_aa_in   = 0.01  ;
X_fa_in   = 0.01  ;
X_c4_in   = 0.01  ;
X_pro_in  = 0.01  ;
X_ac_in   = 0.01  ;
X_h2_in   = 0.01  ;
X_i_in    = 25    ;
S_cat_in  = 0.04  ; 
S_an_in   = 0.02  ;


%*****************************************************************
%Coefficients des équations acido-basiques 
%*****************************************************************
kA_Bva    = 1e10 ;
kA_Bbu    = 1e10 ;
kA_Bpro   = 1e10 ;
kA_Bac    = 1e10 ;
kA_Bco2   = 1e10 ;
kA_Bin    = 1e10 ;

Ka_va     = 10^(-4.86);
Ka_bu     = 10^(-4.82);
Ka_pro    = 10^(-4.88);
Ka_ac     = 10^(-4.76);

R         = 0.083145 ;        %Constante des gaz
Tbase     = 298.15   ;        %Température de base en Kelvin
Top       = 308.15   ;        %Température opérationnelle en Kelvin

%Coefficients dépendants de la température 
Ka_co2  = 10^(-6.35)*exp(7646/(R*100)*(1/Tbase-1/Top)) ;
Ka_in   = 10^(-9.25)*exp(51965/(R*100)*(1/Tbase-1/Top));


%*****************************************************************
%coefficients du transfert gaz/liquide
%*****************************************************************
kp  =5e4  ;
%pgas_h2o = 0.0313*exp(5290*(1/Tbase - 1/Top));
kLa =200  ;
Patm=1.013;
Vg  =300  ;
%coefficients dépendants de la température 
KH_h2   = 7.8e-4*exp(-4180/(R*100)*(1/Tbase-1/Top))    ;
KH_ch4  = 0.0014*exp(-14240/(R*100)*(1/Tbase-1/Top))   ;
KH_co2  = 0.035*exp(-19410/(R*100)*(1/Tbase-1/Top))    ;
Kw      = 1e-14*exp(55900/(R*100)*(1/Tbase-1/Top))     ;
pgaz_h2o= 0.0313*exp(5290*(1/Tbase-1/Top))             ;


%******************************************************************
eps   = 1e-6     ;     
v     = 1        ;
HRT   = 20       ;     %Temps de rétention hydrolique 
Vl    = 3400     ;     %Volume du liquide 
  

%***********************************************************************
%Vecteur des paramètres 
%***********************************************************************

p=[k_dis,k_hyd_ch,k_hyd_pr,k_hyd_li,k_m_su,Ks_su,k_m_aa,Ks_aa,k_m_fa,Ks_fa,...
    k_m_c4,Ks_c4,k_m_pro,Ks_pro,k_m_ac,Ks_ac,k_m_h2,Ks_h2,k_dec_Xsu,k_dec_Xaa,...
    k_dec_Xfa,k_dec_Xc4,k_dec_Xpro,k_dec_Xac,k_dec_Xh2,phul_aa,phul_ac,phul_h2,...
    phll_aa,phll_ac,phll_h2,KI_h2_fa,KI_h2_c4,KI_h2_pro,KI_NH3_ac,Ks_in,f_xI_xc,...
    S_su_in,f_fa_li,S_aa_in,S_fa_in,S_va_in,Y_aa,f_va_aa,S_bu_in,Y_su,f_bu_su,f_bu_aa,...
    S_pro_in,f_pro_su,f_pro_aa,Y_c4,S_ac_in,f_ac_su,f_ac_aa,Y_fa,Y_pro,S_h2_in,f_h2_su,...
    f_h2_aa,S_ch4_in,Y_ac,Y_h2,S_ic_in,S_in_in,S_i_in,f_si_xc,X_c_in,X_ch_in,f_ch_xc,f_pr_xc,...
    f_li_xc,X_pr_in,X_li_in,X_su_in,X_aa_in,X_fa_in,X_c4_in,X_pro_in,X_ac_in,X_h2_in,X_i_in,...
    S_cat_in,S_an_in,kA_Bva,kA_Bbu,kA_Bpro,kA_Bac,kA_Bco2,kA_Bin,Ka_va,Ka_bu,Ka_pro,Ka_ac,...
    Tbase,Top,Ka_co2,Ka_in,kp,kLa,KH_h2,KH_ch4,KH_co2,Kw,Patm,v,Vg,pgaz_h2o,Nbac,Naa,Nxc,...
    NSi,NXpr,NXi,C_Si,C_Xc,C_Xch,C_Xpr,C_Xli,C_Xi,C_Ssu,C_Saa,C_Sva,C_Sfa,C_Sbu,C_Spro,...
    C_Sac,C_Sch4,Cbac,eps,HRT,Vl,R];


%**************************************************************************
%Vecteur des conditions initiales
%**************************************************************************
y0=[0.009;...    % S_su
    0.0009;...   % S_aa
    0.0009;...   % S_fa
    0.0009;...   % S_va
    0.0009;...   % S_bu
    0.0009;...   % S_pro
    0.0009;...   % S_ac
    2.3594e-9;...%S_h2
    2.3594e-6;...%S_ch4
    0.039;...    %S_ic
    0.13023;...  %S_in
    0.009;...    %S_i
    0.30870;...  %X_c
    0.02795;...  %X_ch
    0.10260;...  %X_pr
    0.02948; ... %X_li
    0.42016;...  %X_su
    1.17917;...  %X_aa
    0.24303;...  %X_fa
    0.43192;...  %X_c4
    0.13730;...  %X_pro
    0.76056;...  %X_ac
    0.31702;...  %X_h2
    25.61739;... %X_i
    0.04;...     %S_cat
    0.02;...     %S_an
    0.0116;...   %S_vam
    0.01322;...  %S_bum
    0.01574;...  %S_prom
    0.19724;...  %S_acm
    0.14278;...  %S_hco3m
    0.00409;...  %S_nh3
    1.023e-5;... %h2
    1.62125;...  %ch4
    0.01411];    %co2


%**************************************************************************
%dessiner
%**************************************************************************
tic

options = odeset('RelTol',prec,'AbsTol',prec*ones(1,35));
[T,Y]=ode15s(@(t,y) ADM1_cor1(t,y,p),(0:Tmax/360:Tmax),y0,options);

%**************************************************************************
%Vecteur des sorties
%**************************************************************************
S_su   = Y(:,1) ; 
S_aa   = Y(:,2) ; 
S_fa   = Y(:,3) ;
S_va   = Y(:,4) ;
S_bu   = Y(:,5) ;
S_pro  = Y(:,6) ;
S_ac   = Y(:,7) ;
S_h2   = Y(:,8) ;
S_ch4  = Y(:,9) ;
S_ic   = Y(:,10);
S_in   = Y(:,11);
S_i    = Y(:,12);
X_c    = Y(:,13);
X_ch   = Y(:,14);
X_pr   = Y(:,15);
X_li   = Y(:,16);
X_su   = Y(:,17);
X_aa   = Y(:,18);
X_fa   = Y(:,19);
X_c4   = Y(:,20);
X_pro  = Y(:,21);
X_ac   = Y(:,22);
X_h2   = Y(:,23);
X_i    = Y(:,24);
S_cat  = Y(:,25);
S_an   = Y(:,26);
S_vam  = Y(:,27);
S_bum  = Y(:,28);
S_prom = Y(:,29);
S_acm  = Y(:,30);
S_hco3m= Y(:,31);
S_nh3  = Y(:,32);
h2     = Y(:,33);
ch4    = Y(:,34);
co2    = Y(:,35);

toc
T;
%figure(5)
%plot(T,co2)
T = T/86400;
%T =  linspace(0,T);
%**************************************************************************
%Graphiques
%**************************************************************************
figure(1)

subplot(3,5,1);plot(T,S_su);title('S_{su}');xlabel('Time [d]', 'FontSize', 14);grid
subplot(3,5,2);plot(T,S_aa);title('S_{aa}');xlabel('Time [d]', 'FontSize', 14);grid
subplot(3,5,3);plot(T,S_fa);title('S_{fa}');xlabel('Time [d]', 'FontSize', 14);grid
subplot(3,5,4);plot(T,S_va);title('S_{va}');xlabel('Time [d]', 'FontSize', 14);grid
subplot(3,5,5);plot(T,S_bu);title('S_{bu}');xlabel('Time [d]', 'FontSize', 14);grid
subplot(3,5,6);plot(T,S_pro);title('S_{pro}');xlabel('Time [d]', 'FontSize', 14);grid
subplot(3,5,7);plot(T,S_ac);title('S_{ac}');xlabel('Time [d]', 'FontSize', 14);grid
subplot(3,5,8);plot(T,S_h2);title('S_{h2}');xlabel('Time [d]', 'FontSize', 14);grid
subplot(3,5,9);plot(T,S_ch4);title('S_{ch4}');xlabel('Time [d]', 'FontSize', 14);grid
subplot(3,5,10);plot(T,S_ic);title('S_{ic}');xlabel('Time [d]', 'FontSize', 14);grid
subplot(3,5,11);plot(T,S_in);title('S_{in}');xlabel('Time [d]', 'FontSize', 14);grid
subplot(3,5,12);plot(T,S_i);title('S_{i}');xlabel('Time [d]', 'FontSize', 14);grid
subplot(3,5,13);plot(T,S_cat);title('S_{cat}');xlabel('Time [d]', 'FontSize', 14);grid
subplot(3,5,14);plot(T,S_an);title('S_{an}');xlabel('Time [d]', 'FontSize', 14);grid
subplot(3,5,15);plot(T,X_c);title('X_{c}');xlabel('Time [d]', 'FontSize', 14);grid

figure(2)

subplot(3,5,1);plot(T,X_ch);title('X_{ch}');xlabel('Time [d]', 'FontSize', 10);grid
subplot(3,5,2);plot(T,X_pr);title('X_{pr}');xlabel('Time [d]', 'FontSize', 10);grid
subplot(3,5,3);plot(T,X_li);title('X_{li}');xlabel('Time [d]', 'FontSize', 10);grid
subplot(3,5,4);plot(T,X_su);title('X_{su}');xlabel('Time [d]', 'FontSize', 10);grid
subplot(3,5,5);plot(T,X_aa);title('X_{aa}');xlabel('Time [d]', 'FontSize', 10);grid
subplot(3,5,6);plot(T,X_fa);title('X_{fa}');xlabel('Time [d]', 'FontSize', 10);grid
subplot(3,5,7);plot(T,X_c4);title('X_{c4}');xlabel('Time [d]', 'FontSize', 10);grid
subplot(3,5,8);plot(T,X_pro);title('X_{pro}');xlabel('Time [d]', 'FontSize', 10);grid
subplot(3,5,9);plot(T,X_ac);title('X_{ac}');xlabel('Time [d]', 'FontSize', 10);grid
subplot(3,5,10);plot(T,X_h2);title('X_{h2}');xlabel('Time [d]', 'FontSize', 10);grid
subplot(3,5,11);plot(T,X_i);title('X_{i}');xlabel('Time [d]', 'FontSize', 10);grid
subplot(3,5,12);plot(T,S_vam);title('S_{vam}');xlabel('Time [d]', 'FontSize', 10);grid
subplot(3,5,13);plot(T,S_bum);title('S_{bum}');xlabel('Time [d]', 'FontSize', 10);grid
subplot(3,5,14);plot(T,S_prom);title('S_{prom}');xlabel('Time [d]', 'FontSize', 10);grid
subplot(3,5,15);plot(T,S_acm);title('S_{acm}');xlabel('Time [d]', 'FontSize', 10);grid

figure(3)

subplot(3,5,1);plot(T,S_hco3m);title('S_{hco3m}');xlabel('Time [d]', 'FontSize', 10);grid on
subplot(3,5,2);plot(T,S_nh3);title('S_{nh3}');xlabel('Time [d]', 'FontSize', 10);grid on
subplot(3,5,3);plot(T,h2);title('h2');xlabel('Time [d]', 'FontSize', 10);grid on
subplot(3,5,4);plot(T,ch4);title('ch4');xlabel('Time [d]', 'FontSize', 10);grid on
subplot(3,5,5);plot(T,co2);title('co2');xlabel('Time [d]', 'FontSize', 10);grid on

 
Pgaz_h2 = h2*R*Top/16                       ;
Pgaz_ch4= ch4*R*Top/64                      ;
Pgaz_co2= co2*R*Top  ;

%plot gas pressure

figure(4)

hold all
plot(T,Pgaz_h2);
plot(T,Pgaz_ch4);
plot(T,Pgaz_co2);
box on
legend('H_2', 'CH_4', 'CO_2')
title('Gas pressur', 'FontSize', 16)
xlabel('Time [d]', 'FontSize', 14)
ylabel('Pressure [bar]', 'FontSize', 14)
%plot PH
S_nh4   =S_in-S_nh3;
b=S_cat+S_nh4-S_hco3m-(S_acm/64)-(S_prom/112)-(S_bum/160)-(S_vam/208)-S_an; %OH- équivalent à l'anion
Sh=(-b+sqrt(b.^2+4*Kw))*0.5;
if Sh<=0
    Sh=1e-12;
end
pH = -log10(Sh);

figure

plot(T, pH)
title('pH', 'FontSize', 16);
xlabel('Time [d]', 'FontSize', 14)
ylabel('pH', 'FontSize', 14)

%Gas Flow

S_nh4   =S_in-S_nh3;
S_co2   =S_ic-S_hco3m;

figure

Pgaz    = Pgaz_h2+Pgaz_ch4+Pgaz_co2+pgaz_h2o;
rot8    = kLa*(S_h2-16*KH_h2*Pgaz_h2)                                  ;
rot9    = kLa*(S_ch4-64*KH_ch4*Pgaz_ch4)                               ;                                                 ;
rot10   = kLa*(S_co2-KH_co2*Pgaz_co2);
qgas = R*Top/(Patm-pgaz_h2o)*Vl*(rot8 /16 + rot9/64 +rot10 );
Pgas    = Pgaz_h2+Pgaz_ch4+Pgaz_co2+pgaz_h2o;

%plot total gas flow

plot(T, qgas)

%calculate gas component gas flow
qgas_h2 = Pgaz_h2./Pgas.*qgas;
qgas_ch4 = Pgaz_ch4./Pgas.*qgas;
qgas_co2 = Pgaz_co2./Pgas.*qgas;
qgas_h2o = pgaz_h2o./Pgas.*qgas;

%plot component gas flow

hold all
plot(T, qgas_h2)
plot(T, qgas_ch4)
plot(T, qgas_co2)
plot(T, qgas_h2o)

legend('q_{gas,total}', 'q_{gas,h2}', 'q_{gas,ch4}', 'q_{gas,co2}', 'q_{gas,h2o}')
set(gca, 'YScale', 'log')
a = get(gcf, 'children');
set(a(end), 'fontSize', 14);
xlabel('Time [d]', 'FontSize', 14)
ylabel('Flow [m3/d]', 'FontSize', 14)
title('Gas flow', 'FontSize', 16)
ylim([0 4000])
T;

ADM1DataONE= Y';
save('ADM1DataONE.mat','ADM1DataONE');















%**************************************************************************
%**************************************************************************
%**************************************************************************
%La fonction second membre
%elle contient le système différentiel qu'a besoin ode15s pour faire la
%résolution,ainsi que toutes les équations qui lui sont reliées.
%**************************************************************************
%**************************************************************************
%**************************************************************************

function Y=ADM1_cor1(t,y,p)


%**************************************************************************
%définition des paramètres d'entrée de la fonction 
%**************************************************************************
k_dis     = p(1)  ;
k_hyd_ch  = p(2)  ;
k_hyd_pr  = p(3)  ;
k_hyd_li  = p(4)  ;
k_m_su    = p(5)  ;
Ks_su     = p(6)  ;
k_m_aa    = p(7)  ;
Ks_aa     = p(8)  ;
k_m_fa    = p(9)  ;
Ks_fa     = p(10) ;
k_m_c4    = p(11) ;
Ks_c4     = p(12) ;     
k_m_pro   = p(13) ;
Ks_pro    = p(14) ;         
k_m_ac    = p(15) ;
Ks_ac     = p(16) ;
k_m_h2    = p(17) ;
Ks_h2     = p(18) ;
k_dec_Xsu = p(19) ;
k_dec_Xaa = p(20) ;
k_dec_Xfa = p(21) ;
k_dec_Xc4 = p(22) ;
k_dec_Xpro= p(23) ;
k_dec_Xac = p(24) ;
k_dec_Xh2 = p(25) ;
phul_aa   = p(26) ;
phul_ac   = p(27) ;
phul_h2   = p(28) ;
phll_aa   = p(29) ; 
phll_ac   = p(30) ;
phll_h2   = p(31) ;
KI_h2_fa  = p(32) ;
KI_h2_c4  = p(33) ;
KI_h2_pro = p(34) ;
KI_NH3_ac = p(35) ;
Ks_in     = p(36) ;
f_xI_xc   = p(37) ;
S_su_in   = p(38) ;
f_fa_li   = p(39) ;
S_aa_in   = p(40) ;
S_fa_in   = p(41) ;
S_va_in   = p(42) ;
Y_aa      = p(43) ;
f_va_aa   = p(44) ;
S_bu_in   = p(45) ;
Y_su      = p(46) ;
f_bu_su   = p(47) ;
f_bu_aa   = p(48) ;
S_pro_in  = p(49) ;
f_pro_su  = p(50) ;
f_pro_aa  = p(51) ;
Y_c4      = p(52) ;
S_ac_in   = p(53) ;
f_ac_su   = p(54) ;
f_ac_aa   = p(55) ;
Y_fa      = p(56) ;
Y_pro     = p(57) ;
S_h2_in   = p(58) ;
f_h2_su   = p(59) ;
f_h2_aa   = p(60) ;
S_ch4_in  = p(61) ;
Y_ac      = p(62) ;
Y_h2      = p(63) ;
S_ic_in   = p(64) ;
S_in_in   = p(65) ;
S_i_in    = p(66) ;
f_si_xc   = p(67) ;
X_c_in    = p(68) ;
X_ch_in   = p(69) ;
f_ch_xc   = p(70) ;
f_pr_xc   = p(71) ;
f_li_xc   = p(72) ;
X_pr_in   = p(73) ;
X_li_in   = p(74) ;
X_su_in   = p(75) ;
X_aa_in   = p(76) ;
X_fa_in   = p(77) ;
X_c4_in   = p(78) ;
X_pro_in  = p(79) ;
X_ac_in   = p(80) ;
X_h2_in   = p(81) ;
X_i_in    = p(82) ;
S_cat_in  = p(83) ;
S_an_in   = p(84) ; 
kA_Bva    = p(85) ;
kA_Bbu    = p(86) ;
kA_Bpro   = p(87) ;
kA_Bac    = p(88) ;
kA_Bco2   = p(89) ;
kA_Bin    = p(90) ;
Ka_va     = p(91) ;
Ka_bu     = p(92) ;
Ka_pro    = p(93) ;
Ka_ac     = p(94) ;
%Tbase    = p(95) ;
Top       = p(96) ;
Ka_co2    = p(97) ;
Ka_in     = p(98) ;
kp        = p(99) ;
kLa       = p(100);
KH_h2     = p(101);
KH_ch4    = p(102);
KH_co2    = p(103);
Kw        = p(104);
Patm      = p(105);
v         = p(106);
Vg        = p(107);
pgaz_h2o  = p(108);
Nbac      = p(109);
Naa       = p(110);
Nxc       = p(111);
NSi       = p(112); 
NXpr      = p(113);
NXi       = p(114);
C_Si      = p(115);
C_Xc      = p(116);
C_Xch     = p(117);
C_Xpr     = p(118);
C_Xli     = p(119);
C_Xi      = p(120);
C_Ssu     = p(121);
C_Saa     = p(122);
C_Sva     = p(123);
C_Sfa     = p(124);
C_Sbu     = p(125);
C_Spro    = p(126);
C_Sac     = p(127);
C_Sch4    = p(128);
Cbac      = p(129);
eps       = p(130);
HRT       = p(131);
%Qin      = p(132);
Vl        = p(132);
R         = p(133);
t ;                 %pour afficher le temps de calcul

y;



%*************************************************************************
%définition du vecteur des entrées de la fonction
%**************************************************************************
S_su  = y(1) ;
S_aa  = y(2) ;
S_fa  = y(3) ;
S_va  = y(4) ;
S_bu  = y(5) ;
S_pro = y(6) ;
S_ac  = y(7) ;
S_h2  = y(8) ;
S_ch4 = y(9) ;
S_ic  = y(10);
S_in  = y(11);
S_i   = y(12);
X_c   = y(13);
X_ch  = y(14);
X_pr  = y(15);
X_li  = y(16);
X_su  = y(17);
X_aa  = y(18);
X_fa  = y(19);
X_c4  = y(20);
X_pro = y(21);
X_ac  = y(22);
X_h2  = y(23);
X_i   = y(24);
S_cat = y(25);
S_an  = y(26);
S_vam = y(27);
S_bum = y(28);
S_prom= y(29);
S_acm = y(30);
S_hco3m=y(31);
S_nh3 = y(32);
h2    = y(33);
ch4   = y(34);
co2   = y(35);


%**************************************************************************
%Calcul de la pression des gaz
%**************************************************************************
Pgaz_h2 = h2*R*Top/16                       ;
Pgaz_ch4= ch4*R*Top/64                      ;
Pgaz_co2= co2*R*Top                         ;
Pgaz    = Pgaz_h2+Pgaz_ch4+Pgaz_co2+pgaz_h2o;  %préssions de tous les gaz
qgaz    = kp*(Pgaz-Patm)*Pgaz/Patm          ;  %flux du gaz sortant 


%*****************************************************************
%calcul du potentiel d'hydrogène Sh
%*****************************************************************
S_nh4   =S_in-S_nh3;
b=S_cat+S_nh4-S_hco3m-(S_acm/64)-(S_prom/112)-(S_bum/160)-(S_vam/208)-S_an; %OH- équivalent à l'anion
Sh=(-b+sqrt(b^2+4*Kw))*0.5;
if Sh<=0
    Sh=1e-12;
end
ph=-log10(Sh);

%Inhibitons par ph
if ph<phul_aa
    Iph_aa=exp(-3*((ph-phul_aa)/(phul_aa-phll_aa))^2);
else
Iph_aa=1;
end 
if ph<phul_ac
    Iph_ac=exp(-3*((ph-phul_ac)/(phul_ac-phll_ac))^2);
else
Iph_ac=1;
end
if ph<phul_h2
    Iph_h2=exp(-3*((ph-phul_h2)/(phul_h2-phll_h2))^2);
else
Iph_h2=1;
end 


%************************************************************************
% Toute les expressions d'inhibition restantes 
%************************************************************************
I_IN_lim= (S_in/(S_in+Ks_in))           ; 
I_h2_fa = (KI_h2_fa/(KI_h2_fa+S_h2))    ; 
I_h2_c4 = (KI_h2_c4/(KI_h2_c4+S_h2))    ;
I_h2_pro= (KI_h2_pro/(KI_h2_pro+S_h2))  ;
I_NH3_ac= (KI_NH3_ac/(KI_NH3_ac+S_nh3)) ;
I1_5    = Iph_aa*I_IN_lim               ;
I1_6    = Iph_aa*I_IN_lim               ;
I2_7    = Iph_aa*I_IN_lim*I_h2_fa       ;
I2_8    = Iph_aa*I_IN_lim*I_h2_c4       ;
I2_9    = Iph_aa*I_IN_lim*I_h2_c4       ;
I2_10   = Iph_aa*I_IN_lim*I_h2_pro      ;
I3_11   = Iph_ac*I_IN_lim*I_NH3_ac      ;
I1_12   = Iph_h2*I_IN_lim               ;


%**********************************************************************
%Les taux de réactions des 19 processus
%**********************************************************************
ro1     = k_dis*X_c                                                    ;
ro2     = k_hyd_ch*X_ch                                                ;
ro3     = k_hyd_pr*X_pr                                                ;
ro4     = k_hyd_li*X_li                                                ;
ro5     = k_m_su*(S_su/(Ks_su+S_su))*X_su*I1_5                         ;
ro6     = k_m_aa*(S_aa/(Ks_aa+S_aa))*X_aa*I1_6                         ;
ro7     = k_m_fa*(S_fa/(Ks_fa+S_fa))*X_fa*I2_7                         ;
ro8     = k_m_c4*(S_va/(Ks_c4+S_va))*X_c4*((S_va)/(S_va+S_bu+eps))*I2_8;
ro9     = k_m_c4*(S_bu/(Ks_c4+S_bu))*X_c4*((S_bu)/(S_bu+S_va+eps))*I2_9;
ro10    = k_m_pro*(S_pro/(Ks_pro+S_pro))*X_pro*I2_10                   ;
ro11    = k_m_ac*(S_ac/(Ks_ac+S_ac))*X_ac*I3_11                        ;
ro12    = k_m_h2*(S_h2/(Ks_h2+S_h2))*X_h2*I1_12                        ;
ro13    = k_dec_Xsu*X_su                                               ;
ro14    = k_dec_Xaa*X_aa                                               ;
ro15    = k_dec_Xfa*X_fa                                               ;
ro16    = k_dec_Xc4*X_c4                                               ;
ro17    = k_dec_Xpro*X_pro                                             ;
ro18    = k_dec_Xac*X_ac                                               ;
ro19    = k_dec_Xh2*X_h2                                               ;


%***********************************************************************
%Taux des transferts gaz/liquide 
%***********************************************************************
rot8    = kLa*(S_h2-16*KH_h2*Pgaz_h2)                                  ;
rot9    = kLa*(S_ch4-64*KH_ch4*Pgaz_ch4)                               ;
S_co2   = S_ic-S_hco3m                                                 ;
rot10   = kLa*(S_co2-KH_co2*Pgaz_co2)                                  ;


%***********************************************************************
%Les processus
%***********************************************************************
pro1    = C_Si*f_si_xc-C_Xc+C_Xch*f_ch_xc+C_Xpr*f_pr_xc+C_Xli*f_li_xc+C_Xi*f_xI_xc             ;
pro2    = C_Ssu-C_Xch                                                                          ;
pro3    = C_Saa-C_Xpr                                                                          ;
pro4    = C_Ssu*(1-f_fa_li)+C_Sfa*f_fa_li-C_Xli                                                ;
pro5    = -C_Ssu+(1-Y_su)*(C_Sbu*f_bu_su+C_Spro*f_pro_su+C_Sac*f_ac_su)+Y_su*Cbac              ; %Cbac=Cxsu
pro6    = -C_Saa+(1-Y_aa)*(C_Sva*f_va_aa+C_Sbu*f_bu_aa+C_Spro*f_pro_aa+C_Sac*f_ac_aa)+Y_aa*Cbac;
pro7    = -C_Sfa+(1-Y_fa)*(0.7*C_Sac)+Y_fa*Cbac                                                ;
pro8    = -C_Sva+(1-Y_c4)*(0.54*C_Spro+0.31*C_Sac)+Y_c4*Cbac                                   ;
pro9    = -C_Sbu+(1-Y_c4)*(0.8*C_Sac)+Y_c4*Cbac                                                ;
pro10   = -C_Spro+(1-Y_pro)*(0.57*C_Sac)+Y_pro*Cbac                                            ;
pro11   = -C_Sac+(1-Y_ac)*C_Sch4+Y_ac*Cbac                                                     ;
pro12   = (1-Y_h2)*C_Sch4+Y_h2*Cbac                                                            ;
pro13   = C_Xc-Cbac                                                                            ;


%**************************************************************************
%Les équations différentielles 
%**************************************************************************
Qin = Vl/HRT   ;
D = Qin/Vl;       %Le taux de dilution 
te= 1/86400   ;   %86400 équivalent à 1 jour par seconde 
 
dS_su   = (D*(S_su_in-S_su)+ro2+(1-f_fa_li)*ro4-ro5)*te                      ;
dS_aa   = (D*(S_aa_in-S_aa)+ro3-ro6)*te                                      ;
dS_fa   = (D*(S_fa_in-S_fa)+f_fa_li*ro4-ro7)*te                              ;
dS_va   = (D*(S_va_in-S_va)+(1-Y_aa)*f_va_aa*ro6-ro8)*te                     ;
dS_bu   = (D*(S_bu_in-S_bu)+(1-Y_su)*f_bu_su*ro5+(1-Y_aa)*f_bu_aa*ro6-ro9)*te;
dS_pro  = (D*(S_pro_in-S_pro)+(1-Y_su)*f_pro_su*ro5+(1-Y_aa)*f_pro_aa*ro6+(1-Y_c4)*0.54*ro8-ro10)*te;
dS_ac   = (D*(S_ac_in-S_ac)+(1-Y_su)*f_ac_su*ro5+(1-Y_aa)*f_ac_aa*ro6+(1-Y_fa)*0.7*ro7+(1-Y_c4)*0.31*ro8+(1-Y_c4)*0.8*ro9+(1-Y_pro)*0.57*ro10-ro11)*te     ;
dS_h2   = (D*(S_h2_in-S_h2)+(1-Y_su)*f_h2_su*ro5+(1-Y_aa)*f_h2_aa*ro6+(1-Y_fa)*0.3*ro7+(1-Y_c4)*0.15*ro8+(1-Y_c4)*0.2*ro9+(1-Y_pro)*0.43*ro10-ro12-rot8)*te;
dS_ch4  = (D*(S_ch4_in-S_ch4)+(1-Y_ac)*ro11+(1-Y_h2)*ro12-rot9)*te           ;
dS_ic   = (D*(S_ic_in-S_ic)-(pro1*ro1+pro2*ro2+pro3*ro3+pro4*ro4+pro5*ro5+pro6*ro6+pro7*ro7+pro8*ro8+pro9*ro9+pro10*ro10+pro11*ro11+pro12*ro12+pro13*(ro13+ro14+ro15+ro16+ro17+ro18+ro19))-rot10)*te                                                    ;
dS_in   = (D*(S_in_in-S_in)-Y_su*Nbac*ro5+(Naa-Y_aa*Nbac)*ro6-Y_fa*Nbac*ro7-Y_c4*Nbac*ro8-Y_c4*Nbac*ro9-Y_pro*Nbac*ro10-Y_ac*Nbac*ro11-Y_h2*Nbac*ro12+(Nbac-Nxc)*(ro13+ro14+ro15+ro16+ro17+ro18+ro19)+ro1*(Nxc-NSi*f_si_xc+NXpr*f_pr_xc+NXi*f_xI_xc))*te; %NXch=NXli=0
dS_i    = (D*(S_i_in-S_i)+f_si_xc*ro1)*te                                    ;
dX_c    = (D*(X_c_in-X_c)-ro1+ro13+ro14+ro15+ro16+ro17+ro18+ro19)*te         ;
dX_ch   = (D*(X_ch_in-X_ch)+f_ch_xc*ro1-ro2)*te                              ;
dX_pr   = (D*(X_pr_in-X_pr)+f_pr_xc*ro1-ro3)*te                              ;
dX_li   = (D*(X_li_in-X_li)+f_li_xc*ro1-ro4)*te                              ;
dX_su   = (D*(X_su_in-X_su)+Y_su*ro5-ro13)*te                                ;
dX_aa   = (D*(X_aa_in-X_aa)+Y_aa*ro6-ro14)*te                                ;
dX_fa   = (D*(X_fa_in-X_fa)+Y_fa*ro7-ro15)*te                                ;
dX_c4   = (D*(X_c4_in-X_c4)+Y_c4*(ro8+ro9)-ro16)*te                          ;
dX_pro  = (D*(X_pro_in-X_pro)+Y_pro*ro10-ro17)*te                            ;
dX_ac   = (D*(X_ac_in-X_ac)+Y_ac*ro11-ro18)*te                               ;
dX_h2   = (D*(X_h2_in-X_h2)+Y_h2*ro12-ro19)*te                               ;
dX_i    = (D*(X_i_in-X_i)+f_xI_xc*ro1)*te                                    ;
dS_cat  = (D*(S_cat_in-S_cat))*te                                            ;
dS_an   = (D*(S_an_in-S_an))*te                                              ;
dS_vam  = -(kA_Bva*(S_vam*(Ka_va+Sh)-Ka_va*S_va))*te                         ;
dS_bum  = -(kA_Bbu*(S_bum*(Ka_bu+Sh)-Ka_bu*S_bu))*te                         ;
dS_prom = -(kA_Bpro*(S_prom*(Ka_pro+Sh)-Ka_pro*S_pro))*te                    ;
dS_acm  = -(kA_Bac*(S_acm*(Ka_ac+Sh)-Ka_ac*S_ac))*te                         ;
dS_hco3m= -(kA_Bco2*(S_hco3m*(Ka_co2+Sh)-Ka_co2*S_ic))*te                    ;
dS_nh3  = -(kA_Bin*(S_nh3*(Ka_in+Sh)-Ka_in*S_in))*te                         ;  %NH3
dh2     = ((-h2*qgaz/Vg)+rot8*Vl/Vg)*te                                      ;
dch4    = ((-ch4*qgaz/Vg)+rot9*Vl/Vg)*te                                     ;
dco2    = ((-co2*qgaz/Vg)+rot10*Vl/Vg)*te                                    ;

Y       =[dS_su;dS_aa;dS_fa;dS_va;dS_bu;dS_pro;dS_ac;dS_h2;dS_ch4;dS_ic;dS_in;dS_i;dX_c;dX_ch;dX_pr;dX_li;dX_su;dX_aa;dX_fa;dX_c4;dX_pro;dX_ac;dX_h2;dX_i;dS_cat;dS_an;dS_vam;dS_bum;dS_prom;dS_acm;dS_hco3m;dS_nh3;dh2;dch4;dco2];
