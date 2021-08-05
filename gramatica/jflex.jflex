/*Primera seccion, librerias */
package gramatica;
import java_cup.runtime.*;
import static gramatica.parser.*;
import static gramatica.sym.*;
import clasesDAO.Token;
import clasesDAO.TokenError;
import java.util.ArrayList;

/*Segunda seccion, config*/
%%
%class lexer
%cup
%cupdebug
%unicode
%line
%public
%column


%{
    //Creamos un listado de llos errores lexicos
    ArrayList<TokenError> listadoErroresLexicos = new ArrayList();

%}

%{
    //Funciones
    //retorna un simbolo despues de crear un nuevo token y agregarlo al listado
    private Symbol retornarSimbolo(int tipo, String tipoToken, String lexema, int fila, int columna){
        //creamos un  token auxiliar
        Token tokenAux = new Token(tipoToken, lexema, fila, columna);
        System.out.println("Fila: "+fila+" Columa: "+columna+" Token: "+tipoToken+ " Lexema: "+lexema);
        //retornamos el token aux como simbolo
        return new Symbol(tipo, tokenAux);
    }
    
    //Agregamos un token al array list de errores lexicos
    private void addErrorLexico(String tipoToken, String lexema, String msgError, int fila, int columna){
        //creamos un  token auxiliar
        TokenError tokenErrorAux = new TokenError(tipoToken, lexema, msgError, fila, columna);
        //Agregamos al listado
        listadoErroresLexicos.add(tokenErrorAux);
    }

    //Obtenemos el arrLust de los errores lexicos
    public ArrayList<TokenError> obtenerListadoErroresLexicos(){
        return listadoErroresLexicos;
    }
%}

//SEPARADORES
SEPARADORES = [ \r\t\b\f\n]

//SIMBOLOS
PAREN_INI    = "(";
PAREN_FIN    = ")";
SIGNO_POR    = "*";
SIGNO_MAS    = "+";

//NUMEROS
NUMERO = ([0-9]+);

%%

/*Tercera accion, expresiones*/
<YYINITIAL>{
    //SIMBOLOS
    {PAREN_INI       }           { return retornarSimbolo(PAREN_INI       , "PAREN_INI"       , yytext(), yyline + 1, yycolumn + 1); }    
    {PAREN_FIN       }           { return retornarSimbolo(PAREN_FIN       , "PAREN_FIN"       , yytext(), yyline + 1, yycolumn + 1); }    
    {SIGNO_POR       }           { return retornarSimbolo(SIGNO_POR       , "SIGNO_POR"       , yytext(), yyline + 1, yycolumn + 1); }    
    {SIGNO_MAS       }           { return retornarSimbolo(SIGNO_MAS       , "SIGNO_MAS"       , yytext(), yyline + 1, yycolumn + 1); }    
    {NUMERO          }           { return retornarSimbolo(NUMERO          , "NUMERO"          , yytext(), yyline + 1, yycolumn + 1); }    
    
    //{}           { return retornarSimbolo(HEX, "HEX" , yytext(), yyline + 1, yycolumn + 1); }
    
    {SEPARADORES }           { /*                                                                                     */ }
}

[^] { addErrorLexico ("LEXICO", yytext(), "Token no valido", yyline + 1, yycolumn + 1);}





