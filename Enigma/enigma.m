% % % La máquina ENIGMA
% % Rotores
% 1er Rotor
R1 = 'ZAMINTXFPVBJGRUHSELDCYOWKQ';
% 2do Rotor
R2 = 'JTHODYENKCPXARIVGZLSBFQMWU';
% 3er Rotor 
R3 = 'UVLIRMXAHDQNZBSCKEFOYTGJPW';
% Reflector
R = ['XTGEMHYCZUBAN';...
     'LDJQRPFSVKOWI'];
% % Posiciones iniciales
% clave = input('Clave: ', 's');
% clave = 'NET';
% clave = upper(clave);
% texto = upper(input('Texto: ', 's'));
id = fopen('enigma__.txt', 'r');
texto = upper(fscanf(id, '%c'));
fclose(id);
texto = upper('HOLA');
% texto = upper(tetxo);
% Se quitan los espacios
texto(texto == ' ') = [];
% Se quitan los ACENTOS
texto(texto == 'Á') = 'A';
texto(texto == 'É') = 'E';
texto(texto == 'Í') = 'I';
texto(texto == 'Ó') = 'O';
texto(texto == 'Ú') = 'U';
texto(texto == 'Ñ') = 'N';
texto(texto == '0') = [];
texto(texto == '1') = [];
texto(texto == '2') = [];
texto(texto == '3') = [];
texto(texto == '4') = [];
texto(texto == '5') = [];
texto(texto == '6') = [];
texto(texto == '7') = [];
texto(texto == '8') = [];
texto(texto == '9') = [];
% Longitud del texto}
long_txt = length(texto);
% Estableciendo las posiciones iniciales según la clave (Char - ASCII)
% P1 = clave(1) - 65;
% P2 = clave(2) - 65;
% P3 = clave(3) - 65;
% R1 = circshift(R1,P1);
% R1 = circshift(R1,P1);
% R1 = circshift(R1,P1);
cursor = 1;
cadena = [];
c2 = 0; c3 = 0;
while(cursor <= long_txt)
%     letra = input('C: ', 's');
%     letra = upper(letra);
    letra = texto(cursor);
%     pos_final_reflector = find(R3 == char(find(R2 == char(find(R1 == letra) + 65)) + 65)) + 65;
    R_r1 = R1(letra - 64);
    R_r2 = R2(R_r1 - 64);
    R_r3 = R3(R_r2 - 64);
%     Reflector 
    [fila, columna] = find(R == R_r3);
    if (fila == 1)
        fila = 2;
    else
        fila = 1;
    end
    regreso = R(fila,columna);
%     Regresando
    RR_r3 = char(find(R3 == regreso) + 64);
    RR_r2 = char(find(R2 == RR_r3) + 64);
    RR_r1 = char(find(R1 == RR_r2) + 64);
%     Cadena final
    cadena = [cadena RR_r1];
%     Se incrementa el cursor de la cadena
    cursor = cursor + 1;
%     Se muestra la ruta 
    fprintf('Ida: [%c]  -> %c -> %c -> %c | %c \n', letra, R_r1, R_r2, R_r3, regreso);
    fprintf('vue: [%c]\t   <- %c <- %c | %c \n\n', RR_r1, RR_r2, RR_r3, regreso);
%     Se giran los rotores
    R1 = circshift(R1, -1, 2);
    c2 = c2 + 1;
    if (mod(c2, 26) == 0 && c2 ~= 0)
        R2 = circshift(R2, -1, 2); 
        c2 = 0;
        c3 = c3 + 1;
    end
    if (mod(c3, 26) == 0 && c3 ~= 0)
%         R3
        R3 = circshift(R3, -1, 2);
        c3 = 0;
%         R1
%         R2
%         R3
%         cadena
%         pause();
    end
end
% Resultado
fprintf('\nTexto final: ');
cadena