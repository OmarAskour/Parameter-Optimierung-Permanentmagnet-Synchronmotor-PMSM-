%==========================================
% Title:  Parameteroptimierung elektrischer Maschinen mit Genetischen Algorithmen
% Author: Omar Askour
% Date:   WS20/21
%=========================================


openfemm
opendocument('seminarclosed.fem');


%-----------------constants--------------
radius= 27.8;

%-----> magnet thickness 
Mt_x1 = 30.70;           
Mt_y1 = 2.41;  
Mt_x2 = 23.42;           
Mt_y2 = 20; 
               
%-----> angle coordinates (limit & initial)
Xl=21.13;
Yl=18.05;
Xi=27.71;
Yi=2.18;

% % initial angle
alphainit = asind(Yi/radius);
% % max angle
alphalimit = asind(Yl/radius);
% 
%----------Parameter--------
s= 0.1; %25
n = 3;
torq=[];
TickPos=[];
vol=[];

%----------Form draw--------

mi_selectlabel(27.26,10.7);
mi_selectlabel(10.7,27.26);
mi_deleteselectedlabels;
 
mi_addblocklabel(26,10.23);
mi_selectlabel(26,10.23 );
mi_setblockprop('P', 1, 0, '<None>', 201.5 , 1, 1);
mi_clearselected

mi_addblocklabel(10.23,26);
mi_selectlabel(10.23,26);
mi_setblockprop('P', 1, 0, '<None>', 66.5 , 1, 1);
mi_clearselected

mi_selectnode(30.70,2.41);
mi_selectnode(23.42,20);
mi_selectnode(2.41,30.70);
mi_selectnode(20,23.42);
mi_deleteselectednodes;

tic
for i=0.5:s:n
fname = sprintf('MagTick%2.2f.fem', i);

disp(sprintf('Angle %i of %i',i,n));

%actual position
x1_act=radius*cosd(5) + i*cosd(5);
y1_act=radius *sind(5)+ i*sind(5);
x2_act=radius*cosd(40) + i*cosd(40);
y2_act=radius *sind(40)+ i*sind(40);

% previous positions
x1_pre=radius*cosd(5) +i*cosd(5);
y1_pre=radius*sind(5)+ i*sind(5);
x2_pre=radius*cosd(40) +i*cosd(40);
y2_pre=radius*sind(40)+ i*sind(40);

% Form Drawing
mi_addnode(x1_act,y1_act);
mi_addnode(x2_act,y2_act);
mi_addnode(y1_act,x1_act);
mi_addnode(y2_act,x2_act);

mi_addsegment(Xi,Yi,x1_act,y1_act);
mi_addsegment(Xl,Yl,x2_act,y2_act);
mi_addsegment(y1_act,x1_act,Yi,Xi);
mi_addsegment(y2_act,x2_act,Yl,Xl);

mi_addarc(x1_act,y1_act,x2_act,y2_act,36,0.4);
mi_addarc(y2_act,x2_act,y1_act,x1_act,36,0.4);

%-- add nodes prop
mi_selectnode(x1_act,y1_act);
mi_selectnode(x2_act,y2_act);

 %symmetry nodes
mi_selectnode(y1_act,x1_act);
mi_selectnode(y2_act,x2_act);

mi_setnodeprop('<None>',1)
mi_clearselected();






% % boundary "Air"  
% mi_addboundprop('Air', 0, 0, 0, 0, 0, 0, 0, 0, 0);
% mi_selectarcsegment(x1_act,y1_act);
% mi_selectarcsegment(x2_act,y2_act);
% mi_setarcsegmentprop(0.4, 'Air', 0, 1);
% mi_clearselected();
 
mi_analyze();
mi_loadsolution;
 mi_saveas(fname); % save the changes
    
mo_groupselectblock(1);
torq=[torq , mo_blockintegral(22)];

TickPos= [TickPos,i];

vol= [vol,mo_blockintegral(10)];


mi_selectnode(x1_pre,y1_pre);
mi_selectnode(y1_pre,x1_pre);
mi_selectnode(x2_pre,y2_pre);
mi_selectnode(y2_pre,x2_pre);
mi_deleteselectednodes;

end
toc

disp(sprintf(' vol = %d ',vol));
disp(sprintf(' torge = %d ',torq));


% new magnet form (optional)
    x1_new = (Mt_x1+0.8)*cosd(alphainit);
    y1_new = (Mt_x1+0.8)*sind(alphainit);
    x2_new = (Mt_x1+0.8)*cosd(alphalimit);
    y2_new = (Mt_x1+0.8)*sind(alphalimit);

    mi_addnode(x1_new,y1_new );
    mi_addnode(x2_new,y2_new);
    mi_addsegment(x1_new,y1_new,Xi,Yi);
    mi_addsegment(x2_new,y2_new,Xl,Yl);
    mi_addarc(x1_new,y1_new,x2_new,y2_new,36,0.4);
    % %symmetry
    mi_addnode(y1_new,x1_new );
    mi_addnode(y2_new,x2_new);
    mi_addsegment(Yi,Xi,y1_new,x1_new);
    mi_addsegment(Yl,Xl,y2_new,x2_new);
    mi_addarc(y2_new,x2_new,y1_new,x1_new,36,0.4);


% Plot

figure
% axis auto
plot(TickPos,torq,'r')
xlabel('Thickness ');
% xlim([5 27])
ylabel('Torque');
title('torque depends on Thickness');
figure
% axis auto
plot(TickPos,vol)
xlabel('Thickness');
%xlim([5 27])
ylabel('volume ');
title('volume depends on thickness');


 





