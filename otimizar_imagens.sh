#/bin/bash


##### Geotiff RGB ########
for f in *;
do gdal_translate \
--config GDAL_NUM_THREADS ALL_CPUS   -co PHOTOMETRIC=YCBCR  -co COMPRESS=JPEG   -co TILED=YES   -b 1 -b 2 -b 3 \                   \
$f o_$f   \
&& \
gdaladdo \
-ro -r average --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR --config INTERLEAVE_OVERVIEW PIXEL \
o_$f  2 4 8 16 32 64;
done;
#############################


##### ERDAS IMG #######
for f in * ;
do gdal_translate \
-scale  -co PHOTOMETRIC=YCBCR  -co COMPRESS=JPEG  -co TILED=YES  -ot Byte  -of GTiff  -b 1 -b 2 -b 3  \
--config GDAL_NUM_THREADS ALL_CPUS    $f    O_${f%.img}.tif \
&& \
gdaladdo \
-ro -r average --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR --config INTERLEAVE_OVERVIEW PIXEL \
O_${f%.img}.tif    2 4 8 16 32 64;
done;
##########################

# opção -stats do translate é o caso???
