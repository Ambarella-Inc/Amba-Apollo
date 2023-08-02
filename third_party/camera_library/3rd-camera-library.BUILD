load("@rules_cc//cc:defs.bzl", "cc_library")

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

cc_library(
    name = "smartereye",
    srcs = glob(["lib/*.so*"]),
    hdrs = glob(["include/*.h"]),
    copts = [
        "-Iinclude",
    ],
    linkopts = [
        "-Llib",
    ],
    include_prefix = "third_party/camera_library/smartereye",
    visibility = ["//visibility:public"],
)