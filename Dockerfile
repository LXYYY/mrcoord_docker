FROM ros-tensorflow-melodic:latest

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN apt update && apt install git libv4l-dev libsuitesparse-dev libnlopt-dev -y && apt clean
RUN apt update && apt install python-catkin-tools python-wstool ros-melodic-joy ros-melodic-octomap-ros protobuf-compiler libgoogle-glog-dev ros-melodic-mav-msgs ros-melodic-mav-planning-msgs ros-melodic-sophus ros-melodic-hector-gazebo-plugins ros-melodic-pcl-ros ros-melodic-pcl-conversions libatlas-base-dev python-matplotlib python-numpy -y && apt clean
RUN apt update && apt install liblapacke-dev libode6 libompl-dev libompl12 libopenexr-dev libglm-dev -y && apt clean
RUN apt update && apt install clang -y && apt clean

RUN mkdir -p ~/.gazebo/models
COPY gazebo_models-master/* ~/.gazebo/models/

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
