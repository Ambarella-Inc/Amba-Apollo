#! /usr/bin/env bash


APOLLO_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

export CYBER_PATH="$APOLLO_ROOT_DIR"
source ${APOLLO_ROOT_DIR}/scripts/common.bashrc

APOLLO_IN_LYCHEE=true
# If not run with lychee
if [ -d ${APOLLO_ROOT_DIR}/lib/cmake ]; then
  APOLLO_IN_LYCHEE=false
fi

#set lib path
export LD_LIBRARY_PATH="$APOLLO_ROOT_DIR/lib/:$APOLLO_ROOT_DIR/component/"

#set lychee native lib path
if [ $APOLLO_IN_LYCHEE = true ]; then

oss_path="/opt/apollo/oss"
fastcdr_lib_path="${oss_path}/fast-cdr/lib"
fastrtps_lib_path="${oss_path}/fast-rtps/lib"
abseil_lib_path="${oss_path}/abseil-cpp/lib64"
osqp_lib_path="${oss_path}/osqp/lib64"
tf2_lib_path="${oss_path}/tf2/lib"
proj_lib_path="${oss_path}/proj/lib64"
civetweb_lib_path="${oss_path}/civetweb/lib"
adolc_lib_path="${oss_path}/adol-c/lib64"
ipopt_lib_path="${oss_path}/Ipopt/lib"
ad_rss_lib_path="${oss_path}/ad_rss_lib/lib"

for entry in "${fastcdr_lib_path}" \
    "${fastrtps_lib_path}" \
    "${abseil_lib_path}" \
    "${osqp_lib_path}" \
    "${tf2_lib_path}" \
    "${proj_lib_path}" \
    "${civetweb_lib_path}"\
    "${adolc_lib_path}" \
    "${ipopt_lib_path}" \
    "${ad_rss_lib_path}"; do
    pathprepend "${entry}" LD_LIBRARY_PATH
done

fi


export PATH=$PATH:$APOLLO_ROOT_DIR/bin

export CYBER_DOMAIN_ID=80
export CYBER_IP=127.0.0.1

export GLOG_log_dir="${APOLLO_ROOT_DIR}/data/log"
export GLOG_alsologtostderr=1
export GLOG_colorlogtostderr=1
export GLOG_minloglevel=0

export sysmo_start=0

# for DEBUG log
export GLOG_v=4

#for ncurses lib
export TERM=xterm
#export TERMINFO=$PWD/usr/share/terminfo

#export PYTHONPATH="/home/yyu/Desktop/native_compile/apollo/out/AARCH64/tmp_test/binary/cyber/python/:/home/yyu/Desktop/native_compile/apollo/py_proto"