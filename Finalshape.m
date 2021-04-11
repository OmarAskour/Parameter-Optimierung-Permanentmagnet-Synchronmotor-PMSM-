%==========================================
% Title:  Parameteroptimierung elektrischer Maschinen mit Genetischen Algorithmen
% Author: Omar Askour
% Date:   WS20/21
%=========================================




openfemm
opendocument('seminarclosed.fem');
% opendocument('MagWidth40.5.fem');

mi_saveas('test.fem');


%% -- add optimal arc Rotator arc=20.5
mi_selectlabel(14,14);
mi_deleteselectedlabels;

mi_addblocklabel(17,17);
mi_selectlabel(17,17 );
mi_setblockprop('M-19 Steel', 1, 0, '<None>', 0, 1, 1);
mi_clearselected

mi_addnode(0,20.5);
mi_addnode(20.5,0);
mi_addarc(20.5,0,0,20.5,90,0.39);
 
mi_selectnode(0,15);
mi_selectnode(15,0);
mi_deleteselectednodes;

mi_selectnode(0,20.5);
mi_selectnode(20.5,0);
mi_setnodeprop('<None>',1);
mi_clearselected();


% boundary "Arcc"
mi_addboundprop('arcc', 0, 0, 0, 0, 0, 0, 0, 0, 0);
mi_selectarcsegment(20.5,0);
mi_setarcsegmentprop(0.39,'arcc', 0, 1);
mi_clearselected();

%% --add optimal stator arc = 52 mm

mi_selectlabel(36,36);
mi_deleteselectedlabels;

mi_addblocklabel(33,33);
mi_selectlabel(33,33 );
mi_setblockprop('M-19 Steel', 1, 0, '<None>', 0, 0, 1);
mi_clearselected

mi_addnode(0,52);
mi_addnode(52,0);
mi_addarc(52,0,0,52,90,0.92);

mi_addboundprop('arcc', 0, 0, 0, 0, 0, 0, 0, 0, 0);
mi_selectarcsegment(52,0);
mi_setarcsegmentprop(0.92, 'arcc', 0, 0);
mi_clearselected();

mi_selectnode(0,54);
mi_selectnode(54,0);
mi_deleteselectednodes;

%% add optimal magnet width = 38°
% radius= 27.8;
% Mt_x1 = 2.99;           
% Mt_y1 = 2;
% xMitt=radius*cosd(45);
% yMitt=radius*sind(45);
% 
% x1=radius*cosd(7);
% y1=radius*sind(7);
% x2=radius*cosd(7) + Mt_x1*cosd(7);
% y2=radius *sind(7)+ Mt_y1*sind(7);
% 
% x3=radius*cosd(38); 
% y3=radius*sind(38);
% x4=radius*cosd(38) + Mt_x1*cosd(38);
% y4=radius *sind(39.5)+ Mt_y1*sind(39.5);
% 
% mi_addnode(x1,y1);
% mi_addnode(x2,y2);
% mi_addnode(x3,y3);
% mi_addnode(x4,y4);
% mi_addnode(y1,x1);
% mi_addnode(y2,x2);
% mi_addnode(y3,x3);
% mi_addnode(y4,x4);
% 
% mi_selectnode(x1,y1);
% mi_selectnode(x2,y2);
% mi_selectnode(x3,y3);
% mi_selectnode(x4,y4);
%  %symmetry nodes
% mi_selectnode(y1,x1);
% mi_selectnode(y2,x2);
% mi_selectnode(y3,x3);
% mi_selectnode(y4,x4);
% 
% mi_setnodeprop('<None>',1)
% mi_clearselected();
% 
% mi_addsegment(x1,y1,x2,y2);
% mi_addsegment(x3,y3,x4,y4);
% mi_addsegment(y2,x2,y1,x1);
% mi_addsegment(y4,x4,y3,x3);
% 
% mi_selectnode(30.7,2.41);
% mi_selectnode(20,23.43);
% mi_selectnode(23.43,20);
% mi_selectnode(2.41,30.7);
% mi_deleteselectednodes;
% 
% mi_addarc(27.8,0,x1,y1,5,0.11); %gruppe 1
% mi_addarc(y1,x1,0,27.8,5,0.11); %0.11
% mi_addarc(x2,y2,x4,y4,36,0.5); %gruppe 0 obere mag
% mi_addarc(y4,x4,y2,x2,36,0.5);
% mi_addarc(x3,y3,y3,x3,9,0.17); 
% 
% mi_selectnode(27.71,2.18);
% mi_selectnode(2.18,27.71);
% mi_selectnode(21.13,18.05);
% mi_selectnode(18.05,21.13);
% mi_deleteselectednodes;
% 
% 
% mi_selectarcsegment(0,27.8);
% mi_selectarcsegment(27.8,0);
% mi_setarcsegmentprop(0.11, '<None>',0, 1)
% mi_clearselected();
% 
% 
% mi_selectarcsegment(xMitt,yMitt);
% mi_setarcsegmentprop(0.17, '<None>', 0, 1)
% mi_clearselected();
% 
%% add optimal Magnet tickness = 2.2 mm



% x1_act=radius*cosd(7.5) + 2.2*cosd(7.5);
% y1_act=radius *sind(6.819)+ 2.2*sind(6.819);
% x2_act=radius*cosd(38) + 2.2*cosd(38);
% y2_act=radius *sind(38)+ 2.2*sind(38);
% 
% mi_addnode(x1_act,y1_act);
% mi_addnode(x2_act,y2_act);
% 
% mi_addnode(y1_act,x1_act);
% mi_addnode(y2_act,x2_act);
% 
% mi_addarc(x1_act,y1_act,x2_act,y2_act,36,0.4);
% mi_addarc(y2_act,x2_act,y1_act,x1_act,36,0.4);
% 
% mi_selectnode(30.70,2.41);
% mi_selectnode(23.42,20);
% mi_selectnode(2.41,30.70);
% mi_selectnode(20,23.42);
% % 
% mi_selectnode(x1_act,y1_act);
% mi_selectnode(x2_act,y2_act);
% mi_selectnode(y1_act,x1_act);
% mi_selectnode(y2_act,x2_act);
% 
% mi_deleteselectednodes;
% 
% 
% mi_selectnode(3.56458,29.7432);
% mi_selectnode(29.7432,3.56458);
% 
% mi_selectnode(18.4694,23.6407);
% mi_selectnode(23.6407,18.4694);
% 
% mi_setnodeprop('<None>',1)
% mi_clearselected();

% %% add neu optimal Magnet tickness = 2.2 mm 
% x1_act=radius*cosd(4.5) + 2.2*cosd(4.5);
% y1_act=radius *sind(2.5)+ 2.2*sind(2.5);
% x2_act=radius*cosd(40.5) + 2.2*cosd(40.5);
% y2_act=radius *sind(40.5)+ 2.2*sind(40.5);
% 
% 
% mi_addnode(x1_act,y1_act);
% mi_addnode(x2_act,y2_act);
% 
% mi_addnode(y1_act,x1_act);
% mi_addnode(y2_act,x2_act);
% % 
% % mi_addarc(x1_act,y1_act,x2_act,y2_act,36,0.4);
% % mi_addarc(y2_act,x2_act,y1_act,x1_act,36,0.4);
% % 
% % mi_selectnode(30.70,2.41);
% % mi_selectnode(23.42,20);
% % mi_selectnode(2.41,30.70);
% % mi_selectnode(20,23.42);
% % % 
% % mi_selectnode(x1_act,y1_act);
% % mi_selectnode(x2_act,y2_act);
% % mi_selectnode(y1_act,x1_act);
% % mi_selectnode(y2_act,x2_act);
% % 
% % mi_deleteselectednodes;
% % 
% % 
% % mi_selectnode(3.56458,29.7432);
% % mi_selectnode(29.7432,3.56458);
% % 
% % mi_selectnode(18.4694,23.6407);
% % mi_selectnode(23.6407,18.4694);
% % 
% % mi_setnodeprop('<None>',1)
% % mi_clearselected();
% 
% x1_act=radius*cosd(4.5) + 2.2*cosd(4.5);
% y1_act=radius *sind(2.5)+ 2.2*sind(2.5);
% x2_act=radius*cosd(40.5) + 2.2*cosd(40.5);
% y2_act=radius *sind(40.5)+ 2.2*sind(40.5);
% 
% 
% mi_addnode(x1_act,y1_act);
% mi_addnode(x2_act,y2_act);
% 
% mi_addnode(y1_act,x1_act);
% mi_addnode(y2_act,x2_act);
% % 
% mi_addarc(x1_act,y1_act,x2_act,y2_act,36,0.4);
% mi_addarc(y2_act,x2_act,y1_act,x1_act,36,0.4);
% 
% mi_selectnode(30.70,2.41);
% mi_selectnode(23.42,20);
% mi_selectnode(2.41,30.70);
% mi_selectnode(20,23.42);
% % % 
% mi_selectnode(x1_act,y1_act);
% mi_selectnode(y1_act,x1_act);
% mi_deleteselectednodes;
% % 
% % 
% mi_selectnode(2.34767,29.8299);
% mi_selectnode(29.8299,2.34767);
% 
% mi_selectnode(19.4834,22.8122);
% mi_selectnode(22.8122,19.4834);
% mi_setnodeprop('<None>',1)
% mi_clearselected();
% 




%% save;

mi_saveas('Finalshape2.fem');


