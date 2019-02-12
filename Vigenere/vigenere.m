% % % Creamos el cuadro Vigenere
alfabeto = 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ';
long_alfa = length(alfabeto);
cuadro_vig = zeros(long_alfa,long_alfa); 
% Corrimiento del alfabeto
for n = 1:long_alfa + 1
    for m = 1:long_alfa
        cuadro_vig(n,m) = alfabeto(mod(n - 2 + m, long_alfa) + 1);
    end
end
% Se convierte a char
cuadro_vig = char(cuadro_vig);
frase = input('Frase a codificar: ', 's');
pass = input('Contraseña: ', 's');

indx_pwd = 0;
for n = 1:length(frase)
    if(frase(n) ~= ' ')
        indx_pwd = indx_pwd + 1;
%     Coordenada Y
        if (mod(indx_pwd, length(pass) + 1) == 0)
            indx_pwd = 1;
        end
        y = find(cuadro_vig(:,1) == upper( pass(indx_pwd) ));
%         Coordenada X
        x = find(cuadro_vig(1,:) == upper( frase(n) ));
        fprintf('%c', cuadro_vig(y,x));
    else
        fprintf(' ');
    end
end
fprintf('\n'); 
 