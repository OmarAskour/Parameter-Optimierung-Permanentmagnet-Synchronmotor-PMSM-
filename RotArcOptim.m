%==========================================
% Title:  Parameteroptimierung elektrischer Maschinen mit Genetischen Algorithmen
% Author: Omar Askour
% Date:   WS20/21
%=========================================



%----- Prameter outside the for loop helps to get all graphs in one diagram
torq=[];
theta=[];
vol=[];
posArcc=[];
Mtorq= [];
ripple= [];
x2=31.30;
x1=31.35;



tic
for i=5.5:0.5:25
fname = sprintf('arccoptim%2.2f.fem', i);
openfemm
opendocument(fname);
mi_saveas('test.fem');

%----- Prameter inside the for loop helps to get every single graph separately
% torq=[]; 
% theta=[];
% posArcc=[];
% 
% Mtorq= [];
% x2=31.30;
% x1=31.35;


mi_selectsegment(0,31.326);
mi_selectsegment(31.326,0);
mi_deleteselected;

iphase=5;
for k=1:30
   
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


   mo_groupselectblock(1);
   torq=[torq , mo_blockintegral(22)];
   theta=[theta,theta_akt];
   
    
    mi_selectarcsegment(x_pre,y_pre);
    mi_selectarcsegment(-y_pre,x_pre);
    mi_deleteselectedarcsegments;
      
    mi_selectgroup(1);
    mi_moverotate(0,0,-theta_akt);
 
    
end

%%------plot graph separately 
% figure
% plot(theta,torq);
% xlabel('angle, 0');
% % xlim([5 27])
% ylabel('Torque');
% title(sprintf('  torque depends to Angle: arc =%d ', i));
% 

vol=[vol,mo_blockintegral(10)];
posArcc=[posArcc,i];
% Mtorq= mean(torq);
Mtorq=[Mtorq, mean(torq)];
ripple= (max(torq)- min(torq))/ 2*Mtorq;

% disp(sprintf(' iteration %i:  mean torque= %i ',i,Mtorq));
% disp(sprintf(' iteration %i:  ripple = %i ',i,ripple));

end
toc



disp(sprintf('torque ripple== %i',ripple));
disp(sprintf(' vol = %d ',vol));
disp(sprintf(' torqe = %d ',torq));
disp(sprintf(' mean torqe = %d ',Mtorq));

mi_addsegment(0,x2,0,x1);
mi_addsegment(x2,0,x1,0);


figure
plot(theta,torq,'r');
xlabel('angle, °');
% xlim([5 27])
ylabel('Torque');
title('torque depends to Angle');

figure
plot(theta,torq,'w');
xlabel('angle, °');
% xlim([5 27])
ylabel('Torque');
title('torque depends to Angle');


figure
plot(posArcc,Mtorq);
xlabel('arc');
% xlim([5 27])
ylabel('mean torque');
title('mean torque depends on arc ');


% figure
% % axis auto
% plot(posArcc,vol)
% xlabel('arcc positions, mm');
% %xlim([5 27])
% ylabel('volume ');
% title('volume depends to arc');

% plot(posArcc,ripple);
% xlabel('arc');
% % xlim([5 27])
% ylabel('ripple');
% title('ripple depends to arc');
