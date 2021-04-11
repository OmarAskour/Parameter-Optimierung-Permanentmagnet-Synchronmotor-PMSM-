%==========================================
% Title:  Parameteroptimierung elektrischer Maschinen mit Genetischen Algorithmen
% Author: Omar Askour
% Date:   WS20/21
%=========================================



openfemm
opendocument('seminarclosed.fem');
mi_saveas('test.fem');


n=70;
torq=[]; %zeros(n,1);
posArcc=[];%zeros(n,1);
vol=[];%zeros(n,1);


mi_selectlabel(36,36);
mi_deleteselectedlabels;

mi_addblocklabel(33,33);
mi_selectlabel(33,33 );
mi_setblockprop('M-19 Steel', 1, 0, '<None>', 0, 0, 1);
mi_clearselected

mi_selectnode(0,54);
mi_selectnode(54,0);
mi_deleteselectednodes;

mi_addnode(0,n);
mi_addnode(n,0);
mi_addsegment(49,0,n,0);
mi_addsegment(0,49,0,n);
mi_addarc(n,0,0,n,90,0.92);
 
mi_addboundprop('arcc', 0, 0, 0, 0, 0, 0, 0, 0, 0);
mi_selectarcsegment(n,0);
mi_setarcsegmentprop(0.39, 'arcc', 0, 2);
mi_clearselected();



for i=1:20
aktstep =n-i ;
prestep = aktstep+1;
fname = sprintf('StArccOptim%d.fem', aktstep);

% disp(sprintf('iteration %i of %i',i,19));
% disp(sprintf('aktstep %i of %i',aktstep,70));
% disp(sprintf('prestep %i of %i',prestep,70));

mi_analyze();
mi_loadsolution;

mi_saveas(fname);

mo_groupselectblock(1);
torq=[torq , mo_blockintegral(22)];

mo_groupselectblock(0);
vol=[vol,mo_blockintegral(10)];
posArcc=[posArcc,n-i];

mi_addnode(0,aktstep);
mi_addnode(aktstep,0);
mi_addarc(aktstep,0,0,aktstep,90,0.92);

mi_addboundprop('arcc', 0, 0, 0, 0, 0, 0, 0, 0, 0);
mi_selectarcsegment(aktstep,0);
mi_setarcsegmentprop(0.39, 'arcc', 0, 2);
mi_clearselected();

mi_selectnode(0,prestep);
mi_selectnode(prestep,0);
mi_deleteselectednodes;

% boundary "Arcc"
% mi_addboundprop('arcc', 0, 0, 0, 0, 0, 0, 0, 0, 0);
% mi_selectarcsegment(aktstep,0);
% mi_setarcsegmentprop(0.39, 'arcc', 0, 0);
% mi_clearselected();



end
% 
disp(sprintf(' vol = %d ',vol));
disp(sprintf(' torge = %d ',torq));


figure
axis auto
plot(posArcc,torq,'r')
xlabel('arcc positions, mm');
xlim([49 70])
ylabel('Torque');
title('torque depends to arc');
figure
axis auto
plot(posArcc,vol)
xlabel('arcc positions, mm');
xlim([49 70])
ylabel('volume ');
title('volume depends to arc');