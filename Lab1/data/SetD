hd_d = zeros(1,1000);
for i = 1:1000
    person1 = randi([1,20]);
    row1 = randi([1,20]);
    row2 = randi([1,20]);
    person2 = person1;
    while(person1 == person2)
        person2 = randi([1,20]);
    end
    load(sprintf('person%02d.mat',person1));
    x = iriscode(row1,:);
    load(sprintf('person%02d.mat',person2));
    y = iriscode(row2,:);
    hd_d(i) = sum(abs(x-y));
end
hd_d = hd_d/30;