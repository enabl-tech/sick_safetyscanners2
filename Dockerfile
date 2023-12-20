FROM althack/ros2:humble-full

ENV ROS_DISTRO=humble
RUN apt update -y && apt upgrade -y && apt install -y git nano

RUN mkdir -p ~/colcon_ws/src/ && cd ~/colcon_ws/src/ && git clone https://github.com/SICKAG/sick_safetyscanners2.git

RUN apt install -y ros-humble-rmw-cyclonedds-cpp
RUN cd ~/colcon_ws && bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash" && rosdep update && rosdep install -i -r -y --from-paths src && colcon build --symlink-install
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash && source ~/colcon_ws/install.bash && export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp" >> ~/.bashrc