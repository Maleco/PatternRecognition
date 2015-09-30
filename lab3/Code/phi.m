function [ answer ] = phi( point, datapoint, h )
answer = 0;
for i = 1:3
    answer = answer + ((point(i)-datapoint(i))^2);
end
answer = exp ( (-1 * answer) / (2*(h^2)));
end

