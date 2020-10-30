FROM voxgraph:kinetic-tf1.6.0-perception

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update && apt install -y libcgal-dev libopencv-dev liboctomap-dev libcgal-qt5-dev libqt5svg5-dev && apt clean

RUN apt update && apt install python-catkin-tools -y && apt clean

# add user
# ARG myuser
# ARG USERNAME=$myuser
# ARG USER_UID=1000
# ARG USER_GID=$USER_UID

# RUN groupadd --gid $USER_GID $USERNAME \
#     && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
#     && apt-get update \
#     && apt-get install -y sudo \
#     && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
#     && chmod 0440 /etc/sudoers.d/$USERNAME
# RUN usermod -a -G dialout $myuser

RUN apt update && apt install -y ros-kinetic-gazebo-msgs ros-kinetic-gazebo-ros && apt clean

RUN apt update && apt install -y xterm && apt clean 
RUN apt update && apt install -y mesa-utils libgl1-mesa-glx && apt clean

RUN mkdir -p ~/.gazebo/models
COPY gazebo_models-master/* ~/.gazebo/models/

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
