FROM debian:bookworm

RUN apt update
RUN apt install -y python3-gi python3-venv make

RUN python3 -m venv /opt/venv --system-site-packages
ENV VIRTUAL_ENV="/opt/venv"
ENV PATH="/opt/venv/bin:/usr/sbin:/usr/bin:/sbin:/bin"
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

ARG DOCKER_WORK_DIR
RUN mkdir -p ${DOCKER_WORK_DIR}
WORKDIR ${DOCKER_WORK_DIR}

COPY pyproject.toml pyproject.toml
COPY easyevent easyevent
RUN pip install --no-cache-dir --editable '.[dev]'
