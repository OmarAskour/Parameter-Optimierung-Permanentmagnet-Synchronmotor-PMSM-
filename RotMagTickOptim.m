%==========================================
% Title:  Parameteroptimierung elektrischer Maschinen mit Genetischen Algorithmen
% Author: Omar Askour
% Date:   WS20/21
%=========================================


% %----- Prameter outside the for loop helps to get all graphs in one diagram
% 
s= 0.1;
n = 3;
torq=[];
theta=[];
TickPos =[];
vol=[];
Mtorq= [];
ripple= [];
x2=31.30;
x1=31.35;


iphase=5;


tic
for i=0.5:s:n
fname = sprintf('MagTick%2.2f.fem', i);
openfemm
opendocument(fname);
mi_saveas('test.fem');

%----- Prameter inside the for loop helps to get every single graph separately


% torq=[];
% theta=[];
% TickPos =[];;
% Mtorq= [];
% % ripple= [];
% x2=31.30;
% x1=31.35;
%-----------------------

mi_selectsegment(0,31.326);
mi_selectsegment(31.326,0);
mi_deleteselected;



for k=1:30
    % fname = sprintf('MagWidth%d.fem', i);
    
    theta_akt = k;
    theta_pre = k-1;
    phi_q = 0;
   
    x_akt=x2*cosd(theta_akt);
    y_akt=x2*sind(theta_akt);
    
    x_pre=x2*cosd(theta_pre);
    y_pre=x2*sind(theta_pre);
    
    
      
    mi_modifycircprop('A',1,iphase*cosd(4*(theta_akt+phi_q)));
    mi_modifycircprop('B',1,iphase*cosd(4*(theta_akt-120)+phi_q));
    mi_modifycircprop('C',1,iphase*cosd(4*(theta_akt-240)+phi_q));
    
      
      mi_selectgroup(1);
      mi_moverotate(0,0,theta_akt);

     %%--- x(-)y(+)
    mi_addarc(0,x1,-y_akt,x_akt,theta_akt,1);
    mi_addarc(x1,0,x_akt,y_akt,theta_akt,1);
    
    
  
    mi_selectarcsegment(-y_akt,x_akt);
    mi_selectarcsegment(x_akt,y_akt);
    mi_setarcsegmentprop(1, 'arcgap', 0, 1);
    
   
mi_clearselected();
    
mi_analyze();
mi_loadsolution;

% mi_saveas(fname);
    
mo_groupselectblock(1);
torq=[torq , mo_blockintegral(22)];
theta=[theta,theta_akt];

    
    mi_selectarcsegment(x_pre,y_pre);
    mi_selectarcsegment(-y_pre,x_pre);
    mi_deleteselectedarcsegments;
      
    mi_selectgroup(1);
    mi_moverotate(0,0,-theta_akt);
 
    
end
% %--- get single graph
% figure
% % 
% plot(theta,torq);
% % hold off
% xlabel('angle, °');
% % xlim([5 27])
% ylabel('Torque');
% title(sprintf('torque depends to Angle (Magnet tickness = %2.2f)', i));

% savefig(sprintf('MagTick%2.2d.fem', i));


vol=[vol,mo_blockintegral(10)];
TickPos= [TickPos,i];

Mtorq=[Mtorq, mean(torq)];

ripple= (max(torq)- min(torq))/ 2*Mtorq;



end
toc

disp(sprintf('  mean torque= %i  ' ,Mtorq));
disp(sprintf('  ripple = %i  ' ,ripple));


mi_addsegment(0,x2,0,x1);
mi_addsegment(x2,0,x1,0);

figure
plot(theta,torq);

xlabel('angle, °');
xlim([1 30])
ylabel('Torque');
title('torque depends on Angle (global)');

figure
plot(theta,torq,'w');

xlabel('angle, °');
xlim([1 30])
ylabel('Torque');
title('torque depends on Angle (global)');


figure
plot(TickPos,Mtorq);
xlabel('Magnet thickness');
% xlim([5 27])
ylabel('mean torque');
title('mean torque depends on Magnet thickness ');




figure
% axis auto
plot(TickPos,vol)
xlabel('Magnet thickness positions, mm');
%xlim([5 27])
ylabel('volume');
title('volume depends on Magnet thickness');

% plot(TickPos,ripple);
% xlabel('Magnet thickness');
% % xlim([5 27])
% ylabel('ripple');
% title('ripple depends on Magnet thickness');
