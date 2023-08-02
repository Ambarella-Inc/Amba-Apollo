mkdir auto_mw

cp /dump45/zhe/cv5/ambarella/auto_mw/apollo ./auto_mw/ -rf
cp /dump45/zhe/cv5/ambarella/auto_mw/base_library ./auto_mw/ -rf
cp /dump45/zhe/cv5/ambarella/auto_mw/base_communication ./auto_mw/ -rf

rm auto_mw/apollo/.git -rf
rm auto_mw/apollo/.github/ -rf
rm auto_mw/apollo/.gitignore -rf
rm auto_mw/base_library/.git -rf
rm auto_mw/base_communication/.git -rf
rm auto_mw/base_communication/.gitignore -rf

rm auto_mw/apollo/extern_lib -rf
rm auto_mw/apollo/amba_release_note/package.sh -rf
rm auto_mw/apollo/ambabuild/extern_lib.self.mk -rf

tar jcvf amba_auto_mw_20221111_v0.1.tar.bz2 auto_mw