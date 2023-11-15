# Data collected for exercise b)

#### 1 via

| parameter         |    8kB |   16kB |   32kB |   64kB |  128kB |
| ----------------- | -----: | -----: | -----: | -----: | -----: |
| Number of cycles  | 221577 | 221621 | 221837 | 202451 | 246549 |
| Idle cycles       | 149520 | 149564 | 149760 | 140418 | 187929 |
| Overall hits      |    793 |    793 |    790 |   6102 |  10760 |
| Read request hits |    479 |    479 |    477 |   5902 |   7688 |

#### 2 vias

| parameter         |    8kB |   16kB |   32kB |   64kB |  128kB |
| ----------------- | -----: | -----: | -----: | -----: | -----: |
| Number of cycles  | 187681 | 187793 | 187793 | 187793 | 246549 |
| Idle cycles       | 122350 | 122412 | 122412 | 122412 | 187929 |
| Overall hits      |   5300 |   5301 |   5301 |   5301 |  10760 |
| Read request hits |   5175 |   5172 |   5172 |   5172 |   7688 |

#### 4 vias

| parameter         |    8kB |   16kB |   32kB |   64kB |  128kB |
| ----------------- | -----: | -----: | -----: | -----: | -----: |
| Number of cycles  | 246931 | 246567 | 246567 | 246567 | 246549 |
| Idle cycles       | 188304 | 187940 | 187940 | 187940 | 187929 |
| Overall hits      |  10755 |  10755 |  10755 |  10755 |  10760 |
| Read request hits |   7685 |   7685 |   7685 |   7685 |   7688 |

#### 8 vias

| parameter         |    8kB |   16kB |   32kB |   64kB |  128kB |
| ----------------- | -----: | -----: | -----: | -----: | -----: |
| Number of cycles  | 246943 | 246567 | 246567 | 246567 | 246549 |
| Idle cycles       | 188316 | 187940 | 187940 | 187940 | 187929 |
| Overall hits      |  10755 |  10755 |  10755 |  10755 |  10760 |
| Read request hits |   7685 |   7685 |   7685 |   7685 |   7688 |

## Ejercicio e: técnicas de mejora

Con caché de 1 vía y 32kB

Inicialmente, contábamos con un procesador de baja calidad; luego aplicamos la técnica de loop unrolling con dos iteraciones por ciclo (en donde se intenta reducir el número de ciclos en el loop aumentando las iteraciones en cada uno). Posteriormente modificamos la condición del bucle, sumado a eso refactorizamos el código. Finalmente decidimos aumentar a cuatro iteraciones por ciclo, de esta forma logramos reducir notoriamente la cantidad de ciclos inactivos impactando así en la cantidad de ciclos totales.

| parámetro         | sin modificaciones | loop unrolling 2 | changed loop condition | code refactor | loop unroling 4 | out_of_order |
| ----------------- | -----------------: | ---------------: | ---------------------: | ------------: | --------------: | -----------: |
| Number of cycles  |             221837 |           207058 |                 206124 |        198761 |          152423 |        36308 |
| Idle cycles       |             149760 |           130452 |                 131564 |        147795 |          107212 |          225 |
| Overall hits      |                790 |              463 |                    479 |          2349 |            4650 |         5997 |
| Read request hits |                477 |              458 |                    471 |          2347 |            2893 |         4406 |

Nota: La cache de instrucciones solo lee, la de datos escribe o lee (para analizar).
