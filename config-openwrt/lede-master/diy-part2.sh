#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

sed -i '/CYXluq4wUazHjmCDBCqXF/d' package/lean/default-settings/files/zzz-default-settings    # 设置密码为空
# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile

# Modify some code adaptation
#sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' feeds/luci/applications/luci-app-cpufreq/Makefile

# Add autocore support for armvirt






# Modify system hostname（FROM OpenWrt CHANGE TO OpenWrt-N1）
# sed -i 's/OpenWrt/OpenWrt-N1/g' package/base-files/files/bin/config_generate

# Replace the default software source
# sed -i 's#openwrt.proxy.ustclug.org#mirrors.bfsu.edu.cn\\/openwrt#' package/lean/default-settings/files/zzz-default-settings

sed -i 's/invalid users = root/#invalid users = root/g' feeds/packages/net/samba4/files/smb.conf.template

# 修复部分插件自启动脚本丢失可执行权限问题
sed -i '/exit 0/i\chmod +x /etc/init.d/*' package/lean/default-settings/files/zzz-default-settings

# 拉取软件包

git clone https://github.com/ophub/luci-app-amlogic.git package/luci-app-amlogic
git clone https://github.com/kenzok8/small-package package/small-package
# git clone -b luci https://github.com/pexcn/openwrt-chinadns-ng.git package/luci-app-chinadns-ng
# svn co https://github.com/immortalwrt-collections/openwrt-gowebdav/trunk/luci-app-gowebdav package/luci-app-gowebdav
# svn co https://github.com/immortalwrt-collections/openwrt-gowebdav/trunk/gowebdav package/gowebdav
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon




# 删除重复包

# rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf package/small-package/luci-app-openvpn-server
rm -rf package/small-package/openvpn-easy-rsa-whisky
rm -rf package/small-package/luci-app-wrtbwmon
rm -rf package/small-package/wrtbwmon
rm -rf package/small-package/luci-app-koolproxyR
rm -rf package/small-package/luci-app-godproxy
rm -rf package/small-package/luci-app-argon*
rm -rf package/small-package/luci-theme-argon*
rm -rf package/small-package/luci-app-amlogic
rm -rf package/small-package/luci-app-unblockneteasemusic
rm -rf package/small-package/upx-static
rm -rf package/small-package/upx
rm -rf package/small-package/firewall*
rm -rf package/small-package/opkg
rm -rf package/small-package/nftables
# 其他调整



sed -i 's#ARMv8#openwrt_armvirt_v8#g' package/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic
sed -i 's#opt/kernel#kernel#g' package/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic

sed -i 's#mount -t cifs#mount.cifs#g' feeds/luci/applications/luci-app-cifs-mount/root/etc/init.d/cifs

#sed -i 's#<%+cbi/tabmenu%>##g' package/small-packages/luci-app-nginx-manager/luasrc/view/nginx-manager/index.htm

# 为alist插件更换最新的golang版本
# rm -rf feeds/packages/lang/golang
# svn export https://github.com/sbwml/packages_lang_golang/trunk feeds/packages/lang/golang
rm -rf package/small-package/alist/patches/001-disable-delete-of-temp-directory-at-startup.patch

# mosdns
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f
git clone https://github.com/sbwml/luci-app-mosdns package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/geodata
