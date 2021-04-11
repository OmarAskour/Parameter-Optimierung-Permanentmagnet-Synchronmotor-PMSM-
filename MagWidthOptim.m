%==========================================
% Title:  Parameteroptimierung elektrischer Maschinen mit Genetischen Algorithmen
% Author: Omar Askour
% Date:   WS20/21
%=========================================



openfemm
opendocument('seminarclosed.fem');
mi_saveas('Mag.fem');


% -----------%constants----------
radius= 27.8;
 %---> magnet thickness 
Mt_x1 = 2.99;           
Mt_y1 = 2;

% Mt_x1 = 2.9908;           
% Mt_y1 = 2.1;


                                      
% --->angle coordinates (limit & initial )
Xl=21.13;
Yl=18.05;
Xi=27.71;
Yi=2.18;

% ---> initial angle
alphainit = asind(Yi/radius);
%----> max angle (limit)
alphalimit = asind(Yl/radius);

disp(sprintf(' alphainit = %d ',alphainit));
disp(sprintf(' alphalimit = %d ',alphalimit));

%---------Parameter------------------
n=20;
s=0.5;
torq=[];%zeros(n,1);
widtdAng=[];%zeros(n,1);
vol=[];%zeros(n,1);

%---------- Form drawing----------

% mi_selectlabel(27.26,10.7);
% mi_selectlabel(10.7,27.26);
% mi_deleteselectedlabels;
% 
% mi_addblocklabel(22.5,18);
% mi_selectlabel(22.5,18 );
% mi_addblocklabel(18,22.5);
% mi_selectlabel(18,22.5);
% mi_setblockprop('P', 1, 0, '<None>', 201.5 , 1, 1);
% mi_clearselected


mi_selectnode(30.7,2.41);
mi_selectnode(27.71,2.18);
mi_selectnode(2.41,30.7);
mi_selectnode(2.18,27.71);

mi_selectnode(21.13,18.05);
mi_selectnode(23.43,20);
mi_selectnode(18.05,21.13);
mi_selectnode(20,23.43);

mi_deleteselectednodes;

 tic 
for i=1:s:n
% fname = sprintf('MagWidth%2.1f.fem', 44-i);

disp(sprintf('iteration %d: Angle right is %d',i,i+1));
disp(sprintf('iteration %d: Angle left is %d',i,44-i));

xMitt=radius*cosd(45);% for the arc between the magnet
yMitt=radius*sind(45);

x1=radius*cosd(i+1);%4
y1=radius*sind(i+1);
x2=radius*cosd(i+1) + Mt_x1*cosd(i+1);
y2=radius *sind(i+1)+ Mt_y1*sind(i+1);

x3=radius*cosd(44-i); %40
y3=radius*sind(44.5-i);
x4=radius*cosd(44-i) + Mt_x1*cosd(44-i);
y4=radius *sind(44.5-i)+ Mt_y1*sind(44.5-i);

% % % step back
xb1=radius*cosd(i+2-1); %5
yb1=radius*sind(i+2-1);
xb2=radius*cosd(i+2-1) + Mt_x1*cosd(i+2-1);
yb2=radius *sind(i+2-1)+ Mt_y1*sind(i+2-1);

xb3=radius*cosd(43-i+1); %39
yb3=radius*sind(43-i+1);
xb4=radius*cosd(44-i+1) + Mt_x1*cosd(44-i+1);%40
yb4=radius *sind(45.5-i+1)+ Mt_y1*sind(45.5-i+1);

%-----delete previous step

if i>1
mi_selectnode(xb1,yb1);
mi_selectnode(xb2,yb2);
mi_selectnode(yb1,xb1);
mi_selectnode(yb2,xb2);

mi_selectnode(xb3,yb3);
mi_selectnode(xb4,yb4);
mi_selectnode(yb3,xb3);
mi_selectnode(yb4,xb4);
mi_deleteselectednodes;

end

mi_addnode(x1,y1);
mi_addnode(x2,y2);
mi_addnode(x3,y3);
mi_addnode(x4,y4);

mi_addsegment(x1,y1,x2,y2);
mi_addsegment(x3,y3,x4,y4);
mi_addarc(27.8,0,x1,y1,3+((i*2)-4),0.11); %gruppe 1
mi_addarc(x1,y1,x3,y3,36,5); % gruppe 0 untre mag
mi_addarc(x2,y2,x4,y4,36,0.5); %gruppe 0 obere mag

%-----symmetry nodes
mi_addnode(y1,x1);
mi_addnode(y2,x2);
mi_addnode(y3,x3);
mi_addnode(y4,x4);

mi_addsegment(y2,x2,y1,x1);
mi_addsegment(y4,x4,y3,x3);
mi_addarc(y1,x1,0,27.8,3+((i*2)-4),0.11); %0.11
mi_addarc(y3,x3,y1,x1,36,5); %5
mi_addarc(y4,x4,y2,x2,36,0.5);
 mi_clearselected();
 
%------add  arc prop

mi_selectarcsegment(0,27.8);
mi_selectarcsegment(27.8,0);
mi_setarcsegmentprop(0.11, '<None>',0, 1)
mi_clearselected();

   %common arcc x3y3

mi_addarc(x3,y3,y3,x3,4.5+((i*2)-2),0.11+(i*0.01)); %9 0.27
mi_selectarcsegment(xMitt,yMitt);
mi_setarcsegmentprop(0.17, '<None>', 0, 1)
mi_clearselected();

%-- add nodes prop
mi_selectnode(x1,y1);
mi_selectnode(x2,y2);
mi_selectnode(x3,y3);
mi_selectnode(x4,y4);
 %symmetry nodes
mi_selectnode(y1,x1);
mi_selectnode(y2,x2);
mi_selectnode(y3,x3);
mi_selectnode(y4,x4);
mi_setnodeprop('<None>',1)
mi_clearselected();

% 
% % boundary "Air"  
% mi_addboundprop('Air', 0, 0, 0, 0, 0, 0, 0, 0, 0);
% 
% mi_selectarcsegment(x2,y2);
% mi_selectarcsegment(y2,x2);
% 
% mi_setarcsegmentprop(0.4, 'Air', 0, 1);
% mi_clearselected();

mi_analyze();
mi_loadsolution;

% mi_saveas(fname);
    
mo_groupselectblock(1);
torq=[torq , mo_blockintegral(22)];
vol= [vol,mo_blockintegral(10)];
widtdAng=[widtdAng,44-i];
% 

end
toc

% a=mean(torq);
% disp(sprintf('mean torque %i  ',a ));
disp(sprintf(' vol = %d ',vol));
disp(sprintf(' torqe = %d ',torq));

% plot
% 
figure
% axis auto
plot(widtdAng,torq,'r')
xlabel('arcc of magnet (width),°');
% xlim([20 35])
ylabel('Torque');
title('torque depends to width');



figure
% axis auto
plot(widtdAng,vol)
xlabel('arcc of magnet (width), °');
% xlim([20 35])
ylabel('volume ');
title('volume depends to width');

