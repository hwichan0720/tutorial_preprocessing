FROM pytorch/pytorch:1.6.0-cuda10.1-cudnn7-devel

ENV HOME=/home/app

COPY . $HOME/myapp

RUN apt-get update && apt-get install -y \
    sudo \
    build-essential \
    curl \
    bzip2 \
    libjuman \
    libcdb-dev \
    libboost-all-dev \
    make \
    cmake \
    wget \
    git \
    autoconf \
    unzip \
    automake \
    zlib1g-dev 

# install juman++
RUN mkdir $HOME/src && \
    cd $HOME/src && \
    curl -L -o jumanpp-2.0.0-rc2.tar.xz https://github.com/ku-nlp/jumanpp/releases/download/v2.0.0-rc2/jumanpp-2.0.0-rc2.tar.xz && \
    tar Jxfv jumanpp-2.0.0-rc2.tar.xz && \
    cd jumanpp-2.0.0-rc2/ && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local/ && \
    make && \
    make install

# install kytea
RUN wget http://www.phontron.com/kytea/download/kytea-0.4.7.tar.gz &&\
    tar zxvf kytea-0.4.7.tar.gz && cd kytea-0.4.7 && \
    wget https://patch-diff.githubusercontent.com/raw/neubig/kytea/pull/24.patch && \
    git apply ./24.patch && ./configure && \
    make && make install && ldconfig -v

# install mecab
RUN apt-get install -y mecab libmecab-dev mecab-ipadic mecab-ipadic-utf8

# install mecab-ko
RUN wget https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz &&\
    tar zxfv mecab-ko-dic-2.1.1-20180720.tar.gz &&\
    cd mecab-ko-dic-2.1.1-20180720 &&\
    ./autogen.sh &&\
    ./configure  &&\
    make &&\
    make install 

# install sentencepiece
RUN git clone https://github.com/google/sentencepiece.git &&\
    cd sentencepiece &&\
    mkdir build &&\
    cd build &&\
    cmake .. &&\
    make -j $(nproc) &&\
    make install &&\
    ldconfig -v

# install moses
RUN git clone https://github.com/moses-smt/mosesdecoder.git

RUN pip install -U pip &&\
    pip install torch &&\
    pip install zenhan &&\
    pip install sentencepiece &&\
    pip install scipy &&\
    pip install -U numpy &&\
    pip install transformers &&\
    pip install jupyterlab &&\
    pip install fairseq &&\
    pip install pandas &&\
    pip install pyknp

RUN jupyter serverextension enable --py jupyterlab 

WORKDIR /home