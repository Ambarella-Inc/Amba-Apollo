load("@rules_cc//cc:defs.bzl", "cc_library")
load("//tools:cpplint.bzl", "cpplint")
load("//tools/platform:build_defs.bzl", "if_aarch64", "if_x86_64")

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "i_ground",
    srcs = ["i_ground.cc"],
    hdrs = ["i_ground.h"],
    deps = [
        ":i_struct_s",
        ":i_util",
        "//modules/perception/common/i_lib/algorithm:i_sort",
        "//modules/perception/common/i_lib/core",
        "//modules/perception/common/i_lib/da:i_ransac",
        "//modules/perception/common/i_lib/geometry:i_plane",
    ],
)

cc_library(
    name = "i_struct_s",
    hdrs = ["i_struct_s.h"],
    deps = if_aarch64([
        "@sse2neon",
    ]),
)

cc_library(
    name = "i_util",
    hdrs = ["i_util.h"],
)

cpplint()
