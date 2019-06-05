% % Algortimos de cifrado RSA
% Se proponen los 2 n�meros primos 'p' y 'q'
vec_prim = primes(999999);
p = vec_prim(end-55000); %p = 11;
q = vec_prim(end - 60000); %q = 23;
% se calcula n
n = p * q;
% Usando la funci�n de Euler, se obtiene fi(n) = fi(p) * fi(q)
% Puesto que son primos, entonces fi(x) = x - 1
fi_n = (p - 1) * (q - 1);
% Se calcula 'e', el cual debe de ser un primo relativo de fi(n)
e = 3;
% N�meros primos disponibles en fi_n
% bloques de 100 n�meros
index = 1;
fin = 0;
while (index < fi_n && fin ~=1)
    lon_bloque = 100;
%     index = 1;
    m = index:(index + lon_bloque - 1);
    primos_bloque = m(isprime(m));
    long_primos = length(primos_bloque);
    index_p = 1;
    while (index_p <= long_primos && fin ~= 1)
        e = primos_bloque(index_p);
        res_euclides = euclides_ext(fi_n, e);
        if (res_euclides ~= -1)
%             disp(res_euclides, e);
            fprintf('res_euclides: %d, e: %d\n', res_euclides, e);
            if (res_euclides > 0)
                fin = 1;
            end
%             break
        end
        index_p = index_p + 1;
    end
    index = index + lon_bloque - 1;
end

% clave p�blica
e;
n;
% Clave privada 
d = res_euclides;
n;

% Diccionario de alfabeto y s�mbolos
dicc = 1:54;
dicc_str = num2str(dicc');
dicc_let = ['A':'Z' '0':'9' '����� .,�?�!";�'];
% se agregan ceros del 1 al 9
for m =1 : 9
    dicc_str(m, 1:2) = ['0' dicc_str(m, 2)];
end
msj = 'Hola crayola �';
msj_upper = upper(msj);
long_msj = length(msj_upper);

array_rsa = zeros(1,long_msj);
for m = 1:long_msj
%     array_rsa(m) = uint64(mod(find(msj_upper(m) == dicc_let)^e,n));
%     array_rsa(m) = mod(find(msj_upper(m) == dicc_let)^e,n);
    array_rsa(m) = powermod(find(msj_upper(m) == dicc_let), e, n);
end

% % Descifrado
array_rsa_des = zeros(1,long_msj);
msj_final = zeros(1,long_msj);
for m = 1:long_msj
%     array_rsa_des(m) = uint64(mod(array_rsa(m)^d, n));
%     array_rsa_des(m) = mod(array_rsa(m)^d, n);
    array_rsa_des(m) = powermod(array_rsa(m), d, n);
    msj_final(m) = dicc_let(array_rsa_des(m));
end
msj_final = char(msj_final)

