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
       % Loop over every element, only the HD to HDtemp if the element in
       % testperson is not 2 (since that bit is unknown)
       for k = 1:30
           if x(1,k) ~= 2
               HDtemp = HDtemp + abs(x(1,k)-y(1,k));
           end
       end
       % If the HD of the current row is the lowest, replace HDmin with
       % that and update the person and row
       if HDtemp < HDmin
           HDmin = HDtemp;
           person = i;
           row = j;
       end
    end
end
% Scale HDmin to the amount of known bits in testperson (which is 20,
% because there are 10 unknown bits)
HDmin = HDmin/20;

normc = normcdf([0:0.001:1],mean(hd_d),std(hd_d));
plot(normc);
d = (sum(normc(:) == 0.0000))/1000;d
