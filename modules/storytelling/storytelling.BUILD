load("@rules_cc//cc:defs.bzl", "cc_library")

cc_library(
    name = "storytelling",
    includes = ["include"],
    hdrs = glob(["include/**/*.h"]),
    srcs = glob(["lib/**/*.so*"]),
    include_prefix = "modules/storytelling",
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)