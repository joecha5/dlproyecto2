# Circuito decodificador de Gray usando Nexys 3

## Funcionamiento del circuito y de cada subsistema

El circuito tiene como función decodificar código Gray, para esto el sistema está compuesto por los siguientes subsistemas:

#### Deco1.v
Módulo que convierte el valor de código gray a binario para ser utilizado en los siguientes subsistemas.

#### Registro.v
Módulo que lleva registro del valor ingresado, se actualiza agregando al registro cada cambio realizado en la entrada.

#### Display 1 y Display 2
Código que selecciona cuales segmento del display 1 y display 2 deben encenderse en la pantallas de acuerdo al código binario convertido desde gray que recibe en la entrada.

#### Refresh And1.v
Módulo que define la tasa de refresco de cada segmento del led para mostrar la iluminación deseada en cada segmento de acuerdo al valor que se quiere mostrar en pantalla.

#### RefreshCounter.v

Módulo contador para el display, lleva un conteo hasta alcanzar el valor máximo y tras refrescarse se reinicia y cuenta de nuevo.

#### FFT.v

Código que implementa un Flip Flop que se utiliza para la tasa de refresco

#### MUX

Módulo que implementa un multiplexor para que los LEDs sean encendidos en el orden correcto y evitar encendido en segmentos no deseados.

#### Refreshcounter 500mS

Módulo contador para alcanzar la tasa de refresco de 500ms para actualizar la display de 7 segmentos.

#### TestTotal.v

Módulo de prueba que simula el proyecto de forma completa para verificar funcionamiento del sistema.

#### FPGAProy2.ucf

Código que programa la FPGA Nexys 3 para ejecutar el sistema

El sistema inicia recibiendo un código de gray ingresado en los switches de la FPGA, este valor es leído por el subsistema y es decodificado como código gray. Con el valor en código gray, este es convertido en binario por el subsistema decodificador a binario, este valor en binario es desplegado en los LEDs de la FPGA.
El valor en binario es convertido a decimal, este valor en decimal es el que se despliega en la pantalla de 7 segmentos.

El valor ingresado es almacenado en el registro, el cual se refresca cada 500ms para actualizar el estado en el sistema en caso de haber un cambio en la entrada de los switches de la FPGA.

## Diagrama de bloque de cada subsistema

 ![Imgur](https://i.imgur.com/0lRQ4Np.png)
![Imgur](https://i.imgur.com/8zRCLKL.png)

## Simulación

Para la comprobación del funcionamiento se utilizó el programa ISE Design Suite 14.7 y se hizo ejecución al código llamado "ProyectoCOMPL.v", seguidamente para la ejecución, se conecta una FPGA Nexus 3 por medio del puesto USB.

En la Nexys 3 se ingresa el código de Gray de 4 bits utilizando los switch integrados de la FPGA, siendo la posición "arriba" un "1" o alto, y la posición "Abajo" el "0" o el baja. De acuerdo al diseño, el código gray se convierte a valor binario, y los Leds de la FPGA se iluminan mostrando el valor correspondiente, siendo encendido del led "1" y apagado del led "0", por ultimo el valor binario se convierte a decimal y este se muestra en la pantalla de 7 segmentos.

En la siguente imagen se muestra el resultado de ingresar el código gray 1011, el cúal corresponde a 13 en decimal y 1101 en binario, como se observa el valor de los Leds corresponde al valor en binario y en la pantalla de 7 segmentos corresponde a la converción a decimal. 

![Imgur](https://i.imgur.com/RfoPHJc.png)

## Análisis del consumo de recursos en la FPGA y del consumo de potencia

Después de la ejecución se tomaron los datos de consumo de potencia y consumo de recursos que despliega la herramienta de diseño ISE de la Nexys 3. 

Para el uso de potencia se consumen 87mW totales, con el siguiente detalle: 

![Imgur](https://i.imgur.com/UMYNU6A.png)


Para el consumo de recursos se detalla de la siguiente forma:

![Imgur](https://i.imgur.com/G5tqSg9.png)

## Velocidades máximas de reloj posibles en el diseño 

La velocidad máximo del reloj es de 0.885nS, según se muestra en la siguiente tabla:

![Imgur](https://i.imgur.com/WN1N0BH.png)


## Principales problemas hallados durante el trabajo y de las soluciones aplicadas 
- Al ingresar números de dos dígitos el número en An 1 se mostraba parcialmente en el An 2, esto se solucionó implementando un multiplexor de 2 a 1.

- En la pantalla todos los 7 segmentos se encendían al mismo tiempo de los 4 display, se desahabilitó el funcionamiento de los an 3 y 4 para unicamente usar 1 y 2. Además los segmentos que corresponden al valor ingresado iluminaban con mayor intensidad, esto se solucionó variando el valor de la tasa de refresco hasta iluminar unicamente los segmentos correspondientes.
