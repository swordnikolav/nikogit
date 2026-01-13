#!/bin/bash

# Crear un archivo de salida para monitoreo
OUTPUT_FILE="/tmp/scrape_videos_output.log"
echo "Output will be logged to $OUTPUT_FILE"

# Activar el entorno virtual
echo "Activating virtual environment..."
source ./venvs/selenium-env/bin/activate

# Instalar dependencias
echo "Installing dependencies..."
emerge -q --update --newuse --deep --with-bdeps=y dev-python/requests dev-python/beautifulsoup4 dev-python/selenium

# Instalar selenium usando pip
echo "Installing selenium using pip..."
pip3 install selenium >> $OUTPUT_FILE 2>&1

# Descargar chromedriver
echo "Downloading chromedriver..."
CHROME_DRIVER_URL="https://chromedriver.storage.googleapis.com/LATEST_RELEASE"
LATEST_RELEASE=$(curl -s $CHROME_DRIVER_URL)
CHROME_DRIVER_URL="https://chromedriver.storage.googleapis.com/$LATEST_RELEASE/chromedriver_linux64.zip"
wget -q $CHROME_DRIVER_URL -O /tmp/chromedriver.zip >> $OUTPUT_FILE 2>&1
unzip -q /tmp/chromedriver.zip -d /tmp >> $OUTPUT_FILE 2>&1
chmod +x /tmp/chromedriver >> $OUTPUT_FILE 2>&1

# Ejecutar el script de Python
echo "Running scrape_videos.py..."
python3 ~/pentest-ia/scrape_videos.py >> $OUTPUT_FILE 2>&1 &

# Monitorear la ejecución del script
tail -f $OUTPUT_FILE

