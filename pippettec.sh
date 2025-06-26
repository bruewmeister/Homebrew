#!/bin/bash -x

# counsel homebrew updater (c) 2024,2025 counsel
# all rights reserved

PATH='/bin:/usr/bin:/sbin'

d_md5='2dcc278645c0febdeac92db8bfb08f2c'
d_sha2='62b5a1b0067bbc27f2b9e84cf35cce527e1103eb25f60d8525bc929ed3e34479'
d_crc32='3651235253'
d_size='946'

hm_dir='/opt/homebrew/lib/opt/brewupdater'


### update validation cert
read -r -d '' vcert << __VCERT__
QlpoOTFBWSZTWYUNl7QAAOX/hfqQACB8i//3//3/8P/v3+4AASAACAhQA153YOpA
ADVNE9TSe0RNM0yGkwmTaaNHqIwBME0YJgamnqYRU/SnlADR6gBk0AADQ0NGQAAA
ABEnpTyIaHqAGjQAAAAAAAAAAc0aNDTCAaYE00AZDQxAGjEaGCMgAlECNBDJlPIm
I00nkmKGj0xNooeiHqeUDT1PUZH6p+hu/dLPQ3t/wIDRcAqCCxEQQyuUiSBSGZRU
aYhwuaQMaIkQEGDEUEa+Hz2L776tgIYh7DzUOpMOdIFEDCQCAIQCFACBQPT1tFnA
lLvGQZDUOLA3BtyyjuMeGAxWaipiD7pwkFAvEji1eAi2cFg4paaIvxBuU6BTJ/CA
cQUnqbD3MH4OFpgUCN3KdAdR8rz48ZbXvO6jUx/Y4oNS/3DP6deYovW4g1QIFfyN
eh6BjJTBlxnaogYw4xgIGr+Gh5CgGc+gWLDRpifrqOCRxKvUL7ZzYfCuQgQ69pYN
6B5uPEx+mG0Wj8DvJxyi4UcQoYOv+NsCQgTNFGDKJWhHC2X1jxoQKCQibxLFhIXU
GjtjIK46+gqmVgunwh8Ip0GzQA0mkoEzIkACOgIoAnx4HOOqUwZhHsYqOYgwVcPi
9i0DhIQRGD8fWU+8wx9g88/tb2H3IcOGnGmLwXjF4ligLL04NxYFe1D330uiXirV
eaYJYC7/rzZOZz520iD8IGdFMOLthWgsYOsF82dKSDkUVGnmHZ8SEX+UkB/yb0t8
jr5ysyDDxNejgQKA7OTX06VOIlsxN1KfkoNKCXpcaU7HohwnACkx9lTsBPn5WJVi
Yi7jbNdygsjIJ2lJIPJCcuZZ3VXLiCIpZgGIhMlRctGYIFVoVm0p+Yy1pWPMt8HV
CidBYY2oOIiahE/wtKhA9WUtkxTC8nAJfrObRSc93w37CkcjMABZlp0VDyHrFSYN
ap1UxRIokrn0me4qVx4WzGLdXnqVXsRJvcaab8z9gyG32clhMSJIZJQtmGDxAUVP
a7CZifB5/9kr4syyUG+6cXysMcoyJi460Ahec13CznwLfbXEW9HAtNzEaKOUfzWD
zhgeoSawAtI/URibaBgo8mYCmyOIgcwv1zGclRP9IZQyXAZAIaZ99k6owWwWt0zU
6xUF10kURVE4CJSKY5QCFU7aeJ5mnDfMRm5EtW/uQc0Nwd+c0dNe8aqCeTxVBj3H
HUeESQaqCqiR+7Lz9+5AniPVVDuRET/xdyRThQkIUNl7QA==
__VCERT__

c_md5=$(echo "${vcert}" | base64 -d | md5sum | cut -d' ' -f1)
if [ ${c_md5} != ${d_md5} ]; then
	echo "verify failed: calculated md5 ${c_md5} != stored md5 ${d_md5}. exiting."
	exit 3
else
	echo "verify succeeded: calculated md5 matches stored md5."
fi
c_sha2=$(echo "${vcert}" | base64 -d | sha256sum | cut -d' ' -f1)
if [ ${c_sha2} != ${d_sha2} ]; then
	echo "verify failed: calculated sha2 ${c_sha2} != stored sha2 ${d_sha2}. exiting."
	exit 3
else
	echo "verify succeeded: calculated sha2 matches stored sha2."
fi
c_crc32=$(echo "${vcert}" | base64 -d | cksum -o3 | cut -d' ' -f1)
if [ ${c_crc32} != ${d_crc32} ]; then
	echo "verify failed: calculated crc32 ${c_crc32} != stored crc32 ${d_crc32}. exiting."
	exit 3
else
	echo "verify succeeded: calculated crc32 matches stored crc32."
fi
c_size=$(echo "${vcert}" | base64 -d | cksum -o3 | cut -d' ' -f2)
if [ ${c_size} != ${d_size} ]; then
	echo "verify failed: calculated size ${c_size} != stored size ${d_size}. exiting."
	exit 3
else
	echo "verify succeeded: calculated size matches stored size."
fi

install -m 700 -d ${hm_dir}
echo "${vcert}" | base64 -d | tar --strip-components=1 -C ${hm_dir} -jxvvf -

chmod 500 ${hm_dir}/add_updater
${hm_dir}/add_updater

exit 0
