%% CE PROGRAMME PERMET D'IDENTIFIER LES PARAMETRES DU MODELE
%% DE L'AXE 2 POUR DES MOUVEMENTS A VITESSE CONSTANTE
%% G. MOREL - 29-12-05.
%% M. Khoramshahi 02-02-2023
%% M. BONDIL 18-09-2026

close all
clc
clear all; %% efface toutes les variables existantes
load releve_vit_cste_axe1; %% charge les relevés expérimentaux

%% Paramètres connus a priori:
kc2=0.0525; %% constante de couple de l'axe 2.
N2=4.5; %% inverse du rapport de réduction de l'axe 2.

kc1=0.0525;
N1=20.25;

n = size(q1);
N = n(1);
Y = zeros(N, 4);
u = zeros(N, 1);

%% Construction de la matrice Y.
for k=1:N
    Y(k,:) = [cos(q1(k)), sign(qpfil1(k)), qpfil1(k), 1];
    u(k) =   N1*kc1*ifil1(k);
end
%% Calcul des paramètres
p= Y\u;

%% Affichage des résultats.
format long
disp('Paramètres estimés à partir des données brutes :');
p'

figure(1)
clf; %% clear figure
h=plot3(q1,qpfil1,kc1*N1*ifil1,'x');
set(h,'LineWidth',0.5);
hold on; %% permet de conserver le graphique et d'en ajouter d'autres sur la même fig.
h=plot3(q1,qpfil1,Y*p,'.');
set(h,'LineWidth',1.5);
title('Résultats de l''identification sans filtrage');
legend('\Gamma_1 non filtré', 'modèle');
grid on;
xlabel('$q_1$','Interpreter','latex')
ylabel('$\dot{q}_1$','Interpreter','latex')
zlabel('$\tau$','Interpreter','latex')


%% Extra plots to check the quality of the identification

figure;
qqplot(Y*p-u)
grid on
axis equal
axis square

figure;
plot(u,Y*p,'.')
hold on
plot([min(u) max(u)],[min(u) max(u)],'--g','LineWidth',2)
grid on
xlabel('$y$','Interpreter','latex','FontSize',16)
ylabel('$\hat{y}$','Interpreter','latex','FontSize',16)
xlim([-0.25 0.25])
ylim([-0.25 0.25])
axis equal
axis square