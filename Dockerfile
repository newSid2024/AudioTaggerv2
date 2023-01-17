FROM tensorflow/tensorflow:2.9.0-gpu

MAINTAINER Sabyasachi Ghosal, saby.ghosal@gmail.com

RUN apt-get -y update

RUN apt-get install --assume-yes --no-install-recommends --quiet \
        python3 \
        python3-pip \
        ffmpeg
RUN python3 -m pip install --upgrade pip
       
RUN pip install --upgrade tensorflow-hub        

RUN pip install --no-cache --upgrade pip setuptools
    
# Set working directory
WORKDIR /TaggingAudioEffects
RUN pwd

# Copying the folder into the local
ADD ./tagging_audio_effects .
RUN pwd


# View contents while building dockerfile
RUN ls -a

# Install local dependencies
RUN pip3 install -r requirements.txt

# Installing JQ required for parsing
WORKDIR /bin
RUN apt-get install -y wget
RUN wget "http://stedolan.github.io/jq/download/linux64/jq" && chmod 755 jq
RUN pwd 
# CMD ["/bin/jq"]

# Remove copied folder
RUN rm -f -r ./tagging_audio_effects
