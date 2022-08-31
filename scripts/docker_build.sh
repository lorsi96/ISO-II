cp .config docker/
docker image build -t lorsi/crosstool:1.0.0 ./docker/ 
rm ./docker/.config