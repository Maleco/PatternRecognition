hd_s = zeros(1,1000);
for i = 1:1000
    person = randi([1,20]);
    row1 = randi([1,20]);
    row2 = row1;
    while(row1 == row2)
        row2 = randi([1,20]);
    end
    load(sprintf('person%02d.mat',person));
    
    hd_s(i) = sum(abs(iriscode(row1,:)-iriscode(row2,:)));
end
hd_s = hd_s/30;