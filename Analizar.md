# Fase IV: Analizar

## Resumen de los valores

De acuerdo a las tablas generadas en la fase anterior, tenemos la siguiente información.

![Reporte de los dataset individuales](https://github.com/semilun4/Bellabeat-Google_Data_Analytics/blob/main/doc/RV_individual.png)
![Reporte de los dataset unidos](https://github.com/semilun4/Bellabeat-Google_Data_Analytics/blob/main/doc/RV_merge.png)

Puntos importantes:
- Cada fichero tiene un número distinto de registros, que nos indica que no tendremos la misma cantidad de información para cada usuario.
- Una de las variables que menos información tiene es el BMI.
- Las personas usuarias, en promedio duermen 6.9 horas, a pesar de estar 7.6 horas en cama.
- En promedio, las personas queman 2303.61 calorías, manteniendo aproximadamente 21 minutos de alta actividad.

## Correlación
Veamos como se están relacionando todas las variables que unimos.

![Correlación de las variables](https://github.com/semilun4/Bellabeat-Google_Data_Analytics/blob/main/doc/correlacion_v1.png)

Puntos importantes:
- Podemos observar, como las variables de TrackerDistance, TotalDistance y TotalSteps guardan un muy alta correlación. Lo mismo con las variables de BMI, Fat y Weight. 
- Hace sentido que para la variable Calories, se presente una correlación negativa con la variable Fat.

Ahora, si creamos unas cuantas variables extra para tratar de hacer alguna regresión con la finalidad de tener recomendaciones a las posibles usuarias en cuanto al tiempo de su actividad física o la calidad del sueño.

## Nuevas variables

- SleepQuality, que es un ratio entre los minutos de sueño sobre los minutos en cama.
- BoolVeryMin, una variable booleana para puntuar a las personas que realicen actividad intensa por más tiempo que la media.
- - BoolVeryDist, una variable booleana para puntuar a las personas que realicen actividad intensa por más distancia que el promedio.




