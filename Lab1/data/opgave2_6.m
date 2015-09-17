% Load the testperson's iriscode
load(sprintf('testperson.mat')); 
x = iriscode(1,:);

% Initialize variables
HDmin = 30; % HDmin starts at the maximum HD
person = 0; % The person with the minimum HD
row = 0; % The row within that person with HDmin

% Loop over all persons
for i = 1:20
    load(sprintf('person%02d.mat',i));
    % Loop over all rows within the persons
    for j = 1:20
       y = iriscode(j,:);
       HDtemp = 0; % HD for this specific row
       % Loop over every element, only add the HD to HDtemp if the element in
       % testperson is not 2 (since that bit is unknown)
       for k = 1:30
           if x(1,k) ~= 2
               HDtemp = HDtemp + abs(x(1,k)-y(1,k));
           end
       end
       % If the HD of the current row is the lowest, replace HDmin with
       % that and update the person and row
       if HDtemp <= HDmin
           HDmin = HDtemp;
           person = i;
           row = j;
           if HDmin == 0; % print the persons and rows with the lowest HDmin possible
               person
               row
           end
       end
    end
end
% Normalize HDmin to the amount of known bits in testperson (which is 20,
% because there are 10 unknown bits)
HDmin = HDmin/20;


% Now calculate the normalized HDmin for the comparison of testperson with
% every row in person 5.

HDtemp = 0;
load(sprintf('person05.mat'));

for j = 1:20
   y = iriscode(j,:);
   % Loop over every element, only add the HD to HDtemp if the element in
   % testperson is not 2 (since that bit is unknown)
   for k = 1:30
       if x(1,k) ~= 2
           HDtemp = HDtemp + abs(x(1,k)-y(1,k));
       end
   end
end
HDmin = HDtemp/400 % Normalize HDmin 

% Calculate the set hd_5 just as with setS and setD

hd_5 = zeros(1,1000);
for i = 1:1000
    row1 = randi([1,20]);
    row2 = row1;
    while(row1 == row2)
        row2 = randi([1,20]);
    end
    load(sprintf('person05.mat',person));
    
    hd_5(i) = sum(abs(iriscode(row1,:)-iriscode(row2,:)));
end
hd_5 = hd_5/30;

% Calculate the integral of the tail of the distribution from the computed
% HDmin

normc = normcdf([0:0.001:1],mean(hd_5),std(hd_5));
1 - normc((HDmin*10000)+1)