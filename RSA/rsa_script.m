% % Algortimos de cifrado RSA
% Se proponen los 2 nùmeros primos 'p' y 'q'
vec_prim = primes(999999);
p = vec_prim(end-55000); %p = 11;
q = vec_prim(end - 60000); %q = 23;
% se calcula n
n = p * q;
% Usando la funciòn de Euler, se obtiene fi(n) = fi(p) * fi(q)
% Puesto que son primos, entonces fi(x) = x - 1
fi_n = (p - 1) * (q - 1);
% Se calcula 'e', el cual debe de ser un primo relativo de fi(n)
e = 3;
% Números primos disponibles en fi_n
% bloques de 100 números
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

% clave pública
e;
n;
% Clave privada 
d = res_euclides;
n;

% Diccionario de alfabeto y símbolos
dicc = 1:54;
dicc_str = num2str(dicc');
% dicc_let = ['A':'N' 'Ñ':'Z' '0':'9' 'ÁÉÍÓÚ .,¿?¡!";Ü'];
dicc_let = ['A':'N' 'Ñ' 'O':'Z' '0':'9' 'ÁÉÍÓÚ .,¿?¡!";Ü'];
% se agregan ceros del 1 al 9
for m =1 : 9
    dicc_str(m, 1:2) = ['0' dicc_str(m, 2)];
end

% Texto a cifrar
id = fopen('texto.txt', 'r');
msj = upper(fscanf(id, '%c'));
fclose(id);
% msj = 'Hola crayola ü';

% msj = 'Hola 12345';
msj_upper = upper(msj);
long_msj = length(msj_upper);
if (mod(long_msj, 5) ~= 0)
    msj_upper = [msj_upper repmat(' ', [1,mod(long_msj, 5)])];
end


% Se divide el mensaje en bloques de 5 (número de 10 dígitos, 2 por c/letra)
filas = ceil(long_msj/5);
bloque = zeros(filas, 5);
indx = 1;
for m = 1:filas
    bloque(m, 1:5) = msj_upper(indx : indx + 4);
    indx = indx + 5;
end
% Se obtienen los números de 10 cifras de cada bloque
numeros_10 = zeros(filas,10);
for x = 1:filas
    array_10 = [];
    for y = 1:5
        array_10 = [array_10 dicc_str(find(dicc_let == char(bloque(x,y))),1:2)];
    end
    array_10
%     pause;
    numeros_10(x, 1:10) = str2num(array_10);
end


% Se guarda el resultado en un txt
id = fopen('cif_rsa.txt','wt');
% array_rsa = zeros(1,long_msj);
array_rsa = zeros(1,filas);
% for m = 1:long_msj
for m = 1:filas
%     array_rsa(m) = powermod(find(msj_upper(m) == dicc_let), e, n);
    array_rsa(m) = powermod(numeros_10(m), d, n);
    fprintf(id, [num2str(array_rsa(m)),',']);
end
fclose(id);
