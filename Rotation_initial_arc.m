%==========================================
% Title:  Parameteroptimierung elektrischer Maschinen mit Genetischen Algorithmen
% Author: Omar Askour
% Date:   WS20/21
%=========================================


openfemm
% opendocument('seminarclosed.fem');
opendocument('Finalshape2.fem');
mi_saveas('test.fem');


torq=[];
theta=[];
vol=[];
x2=31.30;
x1=31.35;


mi_selectsegment(0,31.326);
mi_selectsegment(31.326,0);
mi_deleteselected;



iphase=5;
tic
for k=1:45
    % fname = sprintf('RotationInit%d.fem', i);
    
    theta_akt = k;
    theta_pre = k-1;
    phi_q = 0;
   
    x_akt=x2*cosd(theta_akt);
    y_akt=x2*sind(theta_akt);
    
    x_pre=x2*cosd(theta_pre);
    y_pre=x2*sind(theta_pre);
    
%     disp(sprintf('teta %i und dtta %i ',theta_akt,dtta));
%     disp(sprintf('teta %i und x_akt %i ',theta_akt,x_akt));
%     disp(sprintf('teta %i und y_akt %i ',theta_akt,y_akt));
%       
    mi_modifycircprop('A',1,iphase*cosd(4*(theta_akt+phi_q)));
    mi_modifycircprop('B',1,iphase*cosd(4*(theta_akt-120)+phi_q));
    mi_modifycircprop('C',1,iphase*cosd(4*(theta_akt-240)+phi_q));
    
      
      mi_selectgroup(1);
      mi_moverotate(0,0,theta_akt);
      
%       mi_addnode(-y_akt,x_akt);
%       mi_addnode(-x_akt,-y_akt);
%       mi_addnode(x_akt,-y_akt);
      
     %%--- x(-)y(+)
    mi_addarc(0,x1,-y_akt,x_akt,theta_akt,1);
    mi_addarc(x1,0,x_akt,y_akt,theta_akt,1);
  
    mi_selectarcsegment(-y_akt,x_akt);
    mi_selectarcsegment(x_akt,y_akt);
    mi_setarcsegmentprop(1,'arcgap', 0, 1);
    
    %%--- x(-)y(-)
    %%--- x(+)y(-)
    %%--- x(+)y(+)
  
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
toc
vol=[vol,mo_blockintegral(10)];
Mtorq= mean(torq);
ripple= (max(torq)-min(torq))/ 2*Mtorq;


disp(sprintf('torque ripple== %i',ripple));
disp(sprintf(' mean torqe = %d ',Mtorq));
disp(sprintf(' vol = %d ',vol));

mi_addsegment(0,x2,0,x1);
mi_addsegment(x2,0,x1,0);

figure
% axis auto
plot(theta,torq,'r')

xlabel('Rotation Winkel [?]');
% xlim([5 27])
yline(Mtorq,'-','Mittleres Drehmoment [N.m]');
ylabel('Drehmoment [N.m]');
title('mittleres Drehmoment abh?ngig von ');























