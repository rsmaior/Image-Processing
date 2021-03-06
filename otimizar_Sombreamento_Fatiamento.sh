#/bin/bash


##### Sombreamento (Float32) ########
##### translate: lê a banda 1 cria uma saida em GTiff e comprime
##### addo: cria pirâmides pela média e comprime cada uma
for f in *;
do gdal_translate \
--config GDAL_NUM_THREADS ALL_CPUS  -co COMPRESS=DEFLATE  -co PREDICTOR=2  -co ZLEVEL=9  -co TILED=YES  -b 1 \
$f o_$f   \
&& \
gdaladdo \
-ro  -r near  --config COMPRESS_OVERVIEW DEFLATE  --config PREDICTOR_OVERVIEW 2  --config ZLEVEL 9  --config INTERLEAVE_OVERVIEW PIXEL \
o_$f  2 4 8 16 32 64;
done;
#############################


##### Fatiamento (Float32) ########
##### translate: lê a banda 1 cria uma saida em GTiff e comprime
##### addo: cria pirâmides pela média e comprime cada uma
for f in *;
do gdal_translate \
--config GDAL_NUM_THREADS ALL_CPUS  -co COMPRESS=DEFLATE  -co ZLEVEL=9  -co TILED=YES   -b 1 \
$f o_$f   \
&& \
gdaladdo \
 -ro  -r near  --config COMPRESS_OVERVIEW DEFLATE   --config ZLEVEL 9  --config INTERLEAVE_OVERVIEW PIXEL \
o_$f  2 4 8 16 32 64;
done;
#############################
