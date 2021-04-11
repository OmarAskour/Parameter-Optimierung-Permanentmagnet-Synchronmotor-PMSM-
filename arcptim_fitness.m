%==========================================
% Title:  Parameteroptimierung elektrischer Maschinen mit Genetischen Algorithmen
% Author: Omar Askour
% Date:   WS20/21
%=========================================




function output = arcptim_fitness(input)
 
x1=input(4); % Mean torque
x2=input(2); %volume
x3=input(3); %ripple

x4=input(1);
x5=input(5);
x6=input(6);

x7=input(7);
x8=input(8);
x9=input(9);

x10=input(10);
x11=input(11);
x12=input(12);

%% ++++++++++++++++ Arc Rotator
Mtorq_Rarc =x1;
vol_Rarc =x2 ;
rip_Rarc =x3 ;

%-- lb [1.817276 2.460088E-05  5.494849E-01]
%-- lu [1.822916 6.978057E-05  5.511901E-01]

% output=[-Mtorq_Rarc vol_Rarc rip_Rarc];

%% ++++++++++++++++++++ Magnetbreite

Mtorq_Mb =x4;
vol_Mb = x5 ;
rip_Mb = x6 ;

%--  lb [1.172446 4.465901E-05   1.258546]
%-- lu [1.635716 5.381833E-05   1.755838]

% 
% output=[-Mtorq_Mb vol_Mb rip_Mb];

%% +++++++++++++++++++++++++Magnetdicke

Mtorq_Mdi =x7;
vol_Mdi = x8 ;
rip_Mdi = x9 ;

%-- lb [3.920830e-01 4.485228e-05 3.328150e-01]
%-- lu [1.144982 5.401519e-05 9.719045e-01]

% output=[-Mtorq_Mdi vol_Mdi rip_Mdi];
%% +++++++++++++++++++++++++arc Stator

Mtorq_Sarc =x10;
vol_Sarc = x11 ;
rip_Sarc = x12 ;

% %-- lb [1.820541 1.279489e-04  4.607168e-01]
% %-- lu [1.824922 3.085107e-04  4.618255e-01]

% 
% output=[-Mtorq_Sarc vol_Sarc rip_Sarc];

%% +++++++++++++++++++++++++all input

%-- lb [1.817276 2.460088E-05  5.494849E-01 1.172446 4.465901E-05 1.258546 3.920830e-01 4.485228e-05 3.328150e-01 1.820541 1.279489e-04  4.607168e-01]
%-- lu [1.822916 6.978057E-05  5.511901E-01 1.635716 5.381833E-05 1.755838 1.144982 5.401519e-05 9.719045e-01 1.824922 3.085107e-04  4.618255e-01]
output=[Mtorq_Rarc vol_Rarc rip_Rarc -Mtorq_Mb vol_Mb rip_Mb Mtorq_Mdi vol_Mdi rip_Mdi Mtorq_Sarc vol_Sarc rip_Sarc ];


