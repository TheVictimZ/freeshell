git clone https://github.com/Verlangid11/nebulafiles.git /var/www/nebulafiles
mv /var/www/nebulafiles/nebula.sh /var/www/nebula.sh
mv /var/www/nebulafiles/nebulaptero.zip /var/www/nebulaptero.zip
rm -rf /var/www/nebulafiles
echo "File nebula.sh berhasil dipindahkan ke /var/www/"
cd /var/www/ 
yes A | unzip nebulaptero.zip
cd /var/www && bash nebula.sh
