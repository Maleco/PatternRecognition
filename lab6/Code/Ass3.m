x1 = [0 0];
x2 = [2 3];
x3 = [1 4];
x4 = [4 2];
x5 = [3 0];

% {{x1, x2, x3}, {x4, x5}}
m1 = 1/3 * (x1+x2+x3);
m2 = 1/2 * (x4+x5);
J1 = norm(x1-m1).^2+norm(x2-m1).^2+norm(x3-m1).^2+norm(x4-m2).^2+norm(x5-m2).^2

% {{x2, x3, x5}, {x1, x4}}
m1 = 1/3 * (x2+x3+x5);
m2 = 1/2 * (x1+x4);
J2 = norm(x2-m1).^2+norm(x3-m1).^2+norm(x5-m1).^2+norm(x1-m2).^2+norm(x4-m2).^2

% {{x4}, {x1, x2, x3, x5}}
m1 = x4;
m2 = 1/4 * (x1+x2+x3+x5);
J3 = norm(x4-m1).^2+norm(x1-m2).^2+norm(x2-m2).^2+norm(x3-m2).^2+norm(x5-m2).^2

% {{x4, x5}, {x1, x2, x3}}
m1 = 1/2 * (x4+x5);
m2 = 1/3 * (x1+x2+x3);
J4 = norm(x4-m1).^2+norm(x5-m1).^2+norm(x1-m2).^2+norm(x2-m2).^2+norm(x3-m2).^2

% {{x3, x5}, {x1, x2, x4}}
m1 = 1/2 * (x3+x5);
m2 = 1/3 * (x1+x2+x4);
J5 = norm(x3-m1).^2+norm(x5-m1).^2+norm(x1-m2).^2+norm(x2-m2).^2+norm(x4-m2).^2