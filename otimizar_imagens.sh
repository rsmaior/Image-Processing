#/bin/bash


##### Geotiff RGB (Byte) ########
##### translate: lê a banda 1, 2 e 3, cria uma saida em GTiff e comprime
##### addo: cria pirâmides pela média e comprime cada uma
for f in *;
do gdal_translate \
--config GDAL_NUM_THREADS ALL_CPUS   -co PHOTOMETRIC=YCBCR  -co COMPRESS=JPEG   -co TILED=YES   -b 1 -b 2 -b 3 \
$f o_$f   \
&& \
gdaladdo \
-ro -r near --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR --config INTERLEAVE_OVERVIEW PIXEL \
o_$f  2 4 8 16 32 64;
done;
#############################


##### ERDAS IMG #######
##### translate: lê a banda 1, 2 e 3, cria uma saida em GTiff, Transforma para Byte ajustando (scale) e comprime
##### addo: cria pirâmides pela média e comprime cada uma
for f in * ;
do gdal_translate \
-b 1 -b 2 -b 3    -of GTiff  -ot Byte -scale    -co PHOTOMETRIC=YCBCR -co COMPRESS=JPEG -co TILED=YES \
--config GDAL_NUM_THREADS ALL_CPUS    $f    O_${f%.img}.tif \
&& \
gdaladdo \
-ro -r near --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR --config INTERLEAVE_OVERVIEW PIXEL \
O_${f%.img}.tif    2 4 8 16 32 64;
done;
##########################
# opção -stats do translate é o caso???

##### Silvania ####
for f in * ;
do gdalwarp \
-s_srs EPSG:32722 -t_srs EPSG:4674 -r near -co NUM_THREADS=ALL_CPUS --config GDAL_CACHEMAX 1000 \
-wm 1000 -multi -q -cutline MOLDURA.shp -crop_to_cutline -dstalpha -of GTiff o_$f $f_SIRGAS2000.tif;
done;
