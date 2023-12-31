load("@rules_cc//cc:defs.bzl", "cc_library")
load("//tools:cpplint.bzl", "cpplint")

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "base_lane_postprocessor",
    hdrs = ["base_lane_postprocessor.h"],
    deps = [
        ":base_init_options",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "//modules/perception/pipeline:stage",
    ],
)

cc_library(
    name = "base_calibrator",
    hdrs = ["base_calibrator.h"],
    deps = [
        ":base_init_options",
        "//cyber",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "//modules/perception/pipeline:plugin",
    ],
)

cc_library(
    name = "base_cipv",
    hdrs = ["base_cipv.h"],
    deps = [
        "//cyber",
        ":base_init_options",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "@eigen",
    ],
)

cc_library(
    name = "base_tl_preprocessor",
    hdrs = ["base_tl_preprocessor.h"],
    deps = [
        "//cyber",
        ":base_init_options",
        "//modules/perception/lib/registerer",
        "//modules/perception/camera/lib/traffic_light/preprocessor:pose",
        "//modules/perception/base:traffic_light",
    ],
)

cc_library(
    name = "base_lane_detector",
    hdrs = ["base_lane_detector.h"],
    deps = [
        ":base_init_options",
        "//modules/perception/base",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "//modules/perception/pipeline:stage",
    ],
)

cc_library(
    name = "base_landmark_detector",
    hdrs = ["base_landmark_detector.h"],
    deps = [
        ":base_init_options",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "//modules/perception/pipeline:stage",
    ],
)

cc_library(
    name = "base_calibration_service",
    hdrs = ["base_calibration_service.h"],
    deps = [
        ":base_init_options",
        "//modules/common/util:util_tool",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "//modules/perception/pipeline:stage",
    ],
)

cc_library(
    name = "base_obstacle_postprocessor",
    hdrs = ["base_obstacle_postprocessor.h"],
    deps = [
        "//modules/perception/pipeline:stage",
    ],
)

cc_library(
    name = "base_obstacle_tracker",
    hdrs = ["base_obstacle_tracker.h"],
    deps = [
        ":base_init_options",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "//modules/perception/pipeline:stage",
    ],
)

cc_library(
    name = "base_obstacle_transformer",
    hdrs = ["base_obstacle_transformer.h"],
    deps = [
        ":base_init_options",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "//modules/perception/pipeline:stage",
    ],
)

cc_library(
    name = "base_scene_parser",
    hdrs = ["base_scene_parser.h"],
    deps = [
        ":base_init_options",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "//modules/perception/pipeline:stage",
    ],
)

cc_library(
    name = "base_lane_tracker",
    hdrs = ["base_lane_tracker.h"],
    deps = [
        ":base_init_options",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "//modules/perception/pipeline:stage",
    ],
)

cc_library(
    name = "base_traffic_light_detector",
    hdrs = ["base_traffic_light_detector.h"],
    deps = [
        ":base_init_options",
        "//modules/perception/base",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "//modules/perception/pipeline:stage",
    ],
)

cc_library(
    name = "base_init_options",
    hdrs = ["base_init_options.h"],
)

cc_library(
    name = "base_obstacle_detector",
    hdrs = ["base_obstacle_detector.h"],
    deps = [
        ":base_init_options",
        "//modules/perception/base",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "//modules/perception/pipeline:stage",
    ],
)

cc_library(
    name = "base_traffic_light_tracker",
    hdrs = ["base_traffic_light_tracker.h"],
    deps = [
        ":base_init_options",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "//modules/perception/pipeline:stage",
    ],
)

cc_library(
    name = "base_feature_extractor",
    hdrs = ["base_feature_extractor.h"],
    deps = [
        ":base_init_options",
        "//modules/perception/base",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "//modules/perception/pipeline:stage",
    ],
)

cc_library(
    name = "base_inference_engine",
    hdrs = ["base_inference_engine.h"],
    deps = [
        ":base_init_options",
        "//modules/perception/base",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "//modules/perception/pipeline:stage",
    ],
)

cc_library(
    name = "base_camera_perception",
    hdrs = ["base_camera_perception.h"],
    deps = [
        ":base_init_options",
        "//modules/perception/camera/common",
        "//modules/perception/lib/registerer",
        "//modules/perception/pipeline:stage",
    ],
)

cc_library(
    name = "interface",
    deps = [
        ":base_calibration_service",
        ":base_calibrator",
        ":base_camera_perception",
        ":base_feature_extractor",
        ":base_inference_engine",
        ":base_init_options",
        ":base_landmark_detector",
        ":base_lane_detector",
        ":base_lane_postprocessor",
        ":base_lane_tracker",
        ":base_obstacle_detector",
        ":base_obstacle_postprocessor",
        ":base_obstacle_tracker",
        ":base_obstacle_transformer",
        ":base_scene_parser",
        ":base_traffic_light_detector",
        ":base_traffic_light_tracker",
        ":base_cipv",
        ":base_tl_preprocessor",
    ],
)

cpplint()
