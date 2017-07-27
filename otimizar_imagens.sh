#/bin/bash



for f in *; do

### reproject from WGS84 to SAD69 UTM 23S
#gdalwarp -overwrite -s_srs EPSG:4326 -t_srs EPSG:29193 -of GTiff    mosaico      2172_4_SE_SAD69.tif


gdal_translate   -co PHOTOMETRIC=YCBCR  -co COMPRESS=JPEG   -co TILED=YES  -b 1 -b 2 -b 3  $f o_$f

gdaladdo -ro -r average --config COMPRESS_OVERVIEW JPEG --config PHOTOMETRIC_OVERVIEW YCBCR --config INTERLEAVE_OVERVIEW PIXEL o_$f  2 4 8 16 32 64

  
done

