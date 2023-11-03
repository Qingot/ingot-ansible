FROM ubuntu:22.04
LABEL maintainer="QA"
LABEL repository=""

ARG REF=main
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y bash \
	build-essential \
	git \
	curl \
	ca-certificates \
	python3 \
	python3-pip \
    && rm -rf /var/lib/apt/lists

RUN python3 -m pip install --no-cache-dir --upgrade pip && \
	    python3 -m pip install --no-cache-dir \
	    jupyter


WORKDIR /workspace

COPY . mypath
RUN cd mypath/ \
	&& python3 -m pip install --no-cache-dir .

RUN git clone 

CMD ["/bin/bash"]




