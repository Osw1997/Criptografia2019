function [euclides_res] = euclides_ext(ffi_n, fe)
% [x1, x2, x3] = [1, 0, ffi_n]; 
X = [1, 0, ffi_n]; 
% [y1, y2, y3] = [0, 1, fe];
Y = [0, 1, fe];

inv = 2;
while(1)
%     if y3 == 0 
    if Y(3) == 0
    %     No inversa
        euclides_res = -1;
        return;
    end
%     if y3 ==1 
    if Y(3) == 1
%         euclides_res = y2;
        euclides_res = Y(2);
        return;
    end
%     Q = x3 / y3;
    Q = floor(X(3) / Y(3));
%     [t1, t2, t3] = [x1 - Q * y1, x2 - Q * y2, x3 - Q * y3];
    T = [X(1) - Q * Y(1), X(2) - Q * Y(2), X(3) - Q * Y(3)];
%     [x1, x2, x3] = [y1, y2, y3];
    X = Y;
%     [y1, y2, y3] = [t1, t2, t3];
    Y = T;
%     if (mod(fe * inv, ffi_n) == 1)
%         euclides_res = inv;
%         return;
%     elseif (inv > ffi_n)
%         euclides_res = -1;
%         return;
%     end
%     inv = inv + 1;
end