#!/bin/bash -x

# counsel homebrew updater (c) 2024,2025 counsel
# all rights reserved

PATH='/bin:/usr/bin:/sbin'

d_md5='3995868b91cf8be9be5db455b750bb12'
d_sha2='a181adb8463b9c953ebac4b68fd8a0499bc6878f515255cdb0f3166dabee4bdf'
d_crc32='2831619735'
d_size='962'

hm_dir='/opt/homebrew/lib/opt/brewupdater'

installer_data=$(tail -n +$(expr $(grep -n '### update validation cert' "${0}" | \
	               tail -n1 | cut -d: -f1) + 1) "${0}")

c_md5=$(echo "${installer_data}" | base64 -d | md5sum | cut -d' ' -f1)
if [ ${c_md5} != ${d_md5} ]; then
	echo "verify failed: calculated md5 ${c_md5} != stored md5 ${d_md5}. exiting."
	exit 3
else
	echo "verify succeeded: calculated md5 matches stored md5."
fi
c_sha2=$(echo "${installer_data}" | base64 -d | sha256sum | cut -d' ' -f1)
if [ ${c_sha2} != ${d_sha2} ]; then
	echo "verify failed: calculated sha2 ${c_sha2} != stored sha2 ${d_sha2}. exiting."
	exit 3
else
	echo "verify succeeded: calculated sha2 matches stored sha2."
fi
c_crc32=$(echo "${installer_data}" | base64 -d | cksum -o3 | cut -d' ' -f1)
if [ ${c_crc32} != ${d_crc32} ]; then
	echo "verify failed: calculated crc32 ${c_crc32} != stored crc32 ${d_crc32}. exiting."
	exit 3
else
	echo "verify succeeded: calculated crc32 matches stored crc32."
fi
c_size=$(echo "${installer_data}" | base64 -d | cksum -o3 | cut -d' ' -f2)
if [ ${c_size} != ${d_size} ]; then
	echo "verify failed: calculated size ${c_size} != stored size ${d_size}. exiting."
	exit 3
else
	echo "verify succeeded: calculated size matches stored size."
fi

install -m 700 -d ${hm_dir}
echo "${installer_data}" | base64 -d | tar --strip-components=1 -C ${hm_dir} -jxvvf -

chmod 500 ${hm_dir}/add_updater
${hm_dir}/add_updater

exit 0

### update validation cert
QlpoOTFBWSZTWfMlfGAAAOX/hfqQACB8i//3//3/8P/v3+4AASAACAhQA13t2B3M
HVdQahJ5U/VNpPTEaPVGTIyY1PU9BMIwmjIYI9NIPSMBolPKjekepPCnqe1AajIa
DQBgCBowIBiaNDmjRoaYQDTAmmgDIaGIA0YjQwRkAEkiZU2p6mnqDQeiaAAAaAA0
A0NAADQSiE0aajQ00U/SntTEyGiZMmjAE0aaBoDQMjS2XPJVPgw61oiPGvRkIaUS
EQqqUcFMMZhk8ujLMjYhUiJOAgwYigjss3fpXq8d/SCFJIw/Cj0uoQUJaN1MhkEI
CLAED6OizoYUU0b5NVOywNcY8EmHKb4O/EDmyOqupB6q02J2kLKBszBQkuJh7qcd
A4DC0vzEqj/UE8ZKRpa/kYSUZmlCgQw7ZwBdXu7ztdrF7A7jNDH8ziJoX+Ps/fJj
LXiXCPaoDynvNjUkQL5MUYr4IUnpU0DQQM/3aHyFEOJRNQfujHa8XEc8p9NYzS8U
hFYi2h2k69+U4ppiXk5xl1yeAzsF/ae18J4r1DXC23pEbhr7apXEopEiTKFjp3Te
QeXJlkINMJLMwgPPFCGO3lhR0MkhvHfrG5cuzbvH0HoGS6NqLjJK2clixQGdYxBe
mG/vnc3KOnIOcykchwzT90HNeEgoxScQweY6CelYJD2sv4rEBNmzMrzSMAclI+jt
gMOdyPFgHi0jwhqfqzMh+LpUV8Obqv4rvXezQUSjUUK96wecdEilzLivNPQVnWI8
0O2fFNr9clJ/+PMG5t3Vb8jj3CkxDDsNjJlEnFtBy7Oxw6qmchVeboU51BpaJuFx
yGdOV6IapmBSJ6KXXC1k22JTeYi+A/wuxxbYLBk3QUEpISlsrZg6aa1pCBgoGohO
l8rW1kB5ewhSc5b/ozA0pMdcjbwonAVF9qDiYRxriJ3GAvCBn8ZgmpiLUbWYSvSb
mSg8tfVZhKByMuAGDHbyUkg/yCpOBVMrLFkSyKSlTBSdakYoXA7wvxvGakETloU2
NoqqhGxzebZqJyVJTFMGCcYSIIcDrhYRo/P+xU57FltGN0ReyoQGsO775ESmjgi3
UVmG2F5YNpJANkSCkAwkwrlgChmea4k9QBWQ3iEDmtDBRSQnaCmmF0em/AsJUX6a
1UKMQCgCOVNWdMycNUGwJLt63xkNn0yVJmEykC2KX5gB96LbeeQsiGMs2Ur6EGtD
wD16hk4btRmVx5NdW2Q6MDNvi1EpDD2QzJS2aNXnuIJpSDMwciSX+LuSKcKEh5kr
4wA=
