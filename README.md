# penjelasan kode yang berada di dalam sampling.sh pada repository sampling_data
# mendefinisikan shebang:
#!/usr/bin/bash 

# Mendownload data di repository sampling_data dan menyimpannya di folder data:
wget -P ./data https://github.com/labusiam/dataset/raw/main/weather_data.xlsx

# pindah direktori kerja ke folder data untuk mempermudah langkah2 yang akan dijalankan:
cd data

# mengubah data dalam bentuk csv, dengan pertama2 memastikan bahwa file sudah terdownload:
FILE=/mnt/c/sampling_data/data/weather_data.xlsx
if [[ -f "$FILE" ]]; then
        echo "File Exists"
# apabila file sudah terdownload, lalu mengambil sheet bernama weather_2014 dari file weather_data.xlsx,
# kemudian menyimpannya ke dalam file weather_2014.csv:
        in2csv weather_data.xlsx --sheet "weather_2014" > weather_2014.csv
# mengambil sheet bernama weather_2015 dari file weather_data.xlsx,
# kemudian menyimpannya ke dalam file weather_2015.csv:
        in2csv weather_data.xlsx --sheet "weather_2015" > weather_2015.csv
# menyatukan file weather_2014.csv dan weather_2015.csv ke dalam file weather.csv:
        csvstack weather_2014.csv weather_2015.csv > weather.csv
# menghapus file excel awal weather_data.xlsx:
        rm weather_data.xlsx
# apabila file belum terdownload, maka akan ditampilkan tulisan "File doesn't exist":
else
        echo "File doesn't exist"
fi

# memastikan file weather.csv berhasil disimpan di folder data,
# kemudian mengambil sample dengan rate 0.3
# kemudian menyimpan hasil sampling ke dalam file sample_weather.csv:
FILE=/mnt/c/sampling_data/data/weather.csv
if [[ -f "$FILE" ]]; then
        cat weather.csv | sample -r 0.3 >> sample_weather.csv
# mencetak notifikasi bahwa file sampling berhasil tersimpan:        
        echo "Successfully saved sample_weather.csv"
# apabila file weather.csv tidak berhasil disimpan, maka
# akan mencetak tulisan notifikasi "File weather.csv doesn't exist"
else
        echo "File weather.csv doesn't exist"
fi
