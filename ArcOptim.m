
%==========================================
% Title:  Parameteroptimierung elektrischer Maschinen mit Genetischen Algorithmen
% Author: Omar Askour
% Date:   WS20/21
%=========================================



%-----Commands-------

%addpath('C:\Users\askou\OneDrive\Desktop\doc\Studium\WS2021\Seminar\Simulation-test\seminarclosed.fem');

%mi_addnode(x,y);
%mi_addsegment(x1,y1,x2,y2);
%mi_addarc(x1,y1,x2,y2,angle,maxseg);

%mi_clearselected();
%mi_selectsegment(x,y);
%mi_selectnode(x,y);
%mi_selectarcsegment(x,y);

%mi_deleteselected; Delete all selected objects.
%mi_deleteselectednodes;
%mi_deleteselectedsegments;
%mi_deleteselectedarcsegments;
%mi_deleteselectedlabels;

%mi_setnodeprop("propname",groupno);
%mi_setsegmentprop("propname", elementsize, automesh, hide, group);
%mi_setarcsegmentprop(maxsegdeg, "propname", hide, group);

% Apply the materials to the appropriate block labels
%mi_addblocklabel(x,y);
%mi_selectlabel(x,y);
%mi_setblockprop("blockname", automesh, meshsize, "incircuit", magdirection,group, turns)
%mi_clearselected

%add a new boundary property
%mi_addboundprop(’propname’, A0, A1, A2, Phi, Mu, Sig, c0, c1, BdryFormat,
%ia, oa);  
%--------------------

openfemm
opendocument('seminarclosed.fem');
mi_saveas('test.fem');


n=25;
torq=[];
posArcc=[];
vol=[];


mi_selectlabel(14,14);
mi_deleteselectedlabels;

mi_addblocklabel(19,19);
mi_selectlabel(19,19 );
mi_setblockprop('M-19 Steel', 1, 0, '<None>', 0, 1, 1);
mi_clearselected

mi_selectnode(0,15);
mi_selectnode(15,0);
mi_deleteselectednodes;
mi_selectarcsegment(0,15);
mi_deleteselectedarcsegments;

mi_addnode(0,5);
mi_addnode(5,0);
mi_addsegment(5,0,n,0);
mi_addsegment(0,5,0,n);
mi_addarc(5,0,0,5,90,0.39);
 
mi_addarc(2.18116,27.7143,0,27.8,4.5,0.11);

mi_selectnode(0,5);
mi_selectnode(5,0);
mi_setnodeprop('<None>',1);

mi_clearselected();

mi_selectsegment(0,5);
mi_selectsegment(5,0);
mi_setsegmentprop('se',0, 1, 0, 1)
mi_clearselected();

mi_selectarcsegment(2.18116,27.7143);
mi_setarcsegmentprop(0.11, '<None>', 0, 1);
mi_clearselected();

% boundary "Arcc"
mi_addboundprop('Air', 0, 0, 0, 0, 0, 0, 0, 0, 0);
mi_selectarcsegment(0,5);
mi_setarcsegmentprop(0.39,'Air', 0, 1);
mi_clearselected();



for i=5.5:0.5:n
 
fstep = i ;
bstep = i-0.5;
% fname = sprintf('arccoptim%2.2f.fem', i);

disp(sprintf('iteration %i of %i',i,25));
disp(sprintf('iteration %i of %i',fstep,25));
disp(sprintf('iteration %i of %i',bstep,25));

mi_analyze();
mi_loadsolution;
% 
% mi_saveas(fname);

mo_groupselectblock(1);

torq=[torq,mo_blockintegral(22)];
vol=[vol,mo_blockintegral(10)];
posArcc=[posArcc,i];


mi_addnode(0,fstep);
mi_addnode(fstep,0);
mi_addarc(fstep,0,0,fstep,90,0.39);

mi_selectnode(0,fstep);
mi_selectnode(fstep,0);
mi_setnodeprop('<None>',1);
mi_clearselected();

mi_selectnode(0,bstep);
mi_selectnode(bstep,0);
mi_deleteselectednodes;

% boundary "Arcc"
mi_addboundprop('Air', 0, 0, 0, 0, 0, 0, 0, 0, 0);
mi_selectarcsegment(fstep,0);
mi_setarcsegmentprop(0.39, 'Air', 0, 1);
mi_clearselected();

% % boundary "Air"
% mi_addboundprop('Air', 0, 0, 0, 0, 0, 0, 0, 0, 0);
% mi_selectarcsegment(fstep,0);
% mi_setarcsegmentprop(0.39, 'Air', 0, 1);
% mi_clearselected();

end



disp(sprintf(' vol = %d ',vol));
disp(sprintf(' torge = %d ',torq));

figure
axis auto
plot(posArcc,torq,'r')
xlabel('arcc positions, mm');
xlim([5 24])
ylabel('Torque');

title('torque depends to arc');
figure
% axis auto
plot(posArcc,vol)
xlabel('arcc positions, mm');
%xlim([5 27])
ylabel('volume ');
title('volume depends to arc');
