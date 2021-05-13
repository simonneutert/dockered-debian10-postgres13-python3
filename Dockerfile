FROM postgres:13

ENV LANG C.UTF-8
ENV PYTHON_VERSION 3.8.5

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    curl \
    libssl-dev \
    build-essential \
    software-properties-common \
    netbase \
    libreadline-gplv2-dev \
    libncursesw5-dev \
    tk-dev \
    libgdbm-dev \
    libc6-dev \
    libbz2-dev \
    libffi-dev \
    zlib1g-dev \
    libevent-dev \
    libpq-dev \
    python3-dev \
    postgresql-plpython3-13 \
    libsqlite3-dev

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* 

RUN curl -O https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz && \
    tar -xf Python-${PYTHON_VERSION}.tar.xz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure --enable-optimizations --enable-loadable-sqlite-extensions && \
    make -j 2 && \
    make altinstall

RUN python3.8 -m venv /venv 
RUN PATH=/venv/bin:$PATH
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py && pip3 install wheel
RUN cd ..