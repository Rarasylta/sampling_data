#!/usr/bin/bash

#download
wget -P ./data https://github.com/labusiam/dataset/raw/main/weather_data.xlsx
cd data

#mengubah data dalam bentuk csv
FILE=/mnt/c/sampling_data/data/weather_data.xlsx
if [[ -f "$FILE" ]]; then
	echo "File Exists"
	in2csv weather_data.xlsx --sheet "weather_2014" > weather_2014.csv
	in2csv weather_data.xlsx --sheet "weather_2015" > weather_2015.csv
	csvstack weather_2014.csv weather_2015.csv > weather.csv
	rm weather_data.xlsx
else
	echo "File doesn't exist"
fi

#membuat sampling data
FILE=/mnt/c/sampling_data/data/weather.csv
if [[ -f "$FILE" ]]; then
	cat weather.csv | sample -r 0.3 >> sample_weather.csv
	echo "Successfully saved sample_weather.csv"
else
	echo "File weather.csv doesn't exist"
fi
